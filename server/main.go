package main

import (
	"crypto/sha256"
	"encoding/base64"
	"errors"
	"log"
	"net/http"
	"os"
	"time"

	uuid "github.com/satori/go.uuid"
	"golang.org/x/oauth2"

	"github.com/gorilla/securecookie"
	"github.com/gorilla/sessions"

	"github.com/go-chi/chi"
	"github.com/go-chi/chi/middleware"
	"github.com/go-chi/cors"
	"github.com/go-chi/render"

	"github.com/zmb3/spotify"
)

const (
	redirectURI = "http://192.168.1.5:3000/results"
	// redirectURI = "https://discover-test-69db3.firebaseapp.com/results"
	sessionName = "discover_now"
)

var (
	auth = spotify.NewAuthenticator(
		redirectURI,
		spotify.ScopeUserReadPrivate,
		spotify.ScopeUserTopRead,
		spotify.ScopeUserReadRecentlyPlayed,
		spotify.ScopePlaylistModifyPublic,
	)
	hashKey    = securecookie.GenerateRandomKey(sha256.Size) // Move these keys to an environment variable
	storeAuth  = securecookie.GenerateRandomKey(64)
	storeCrypt = securecookie.GenerateRandomKey(32)
	store      = sessions.NewCookieStore(storeAuth, storeCrypt)
)

// Login contains the URL configured for Spotify authentication.
type Login struct {
	URL string `json:"url"`
}

// Playlist contains the URI of a user's playlist.
type Playlist struct {
	URI string `json:"uri"`
}

func main() {
	os.Setenv("PORT", "8080") // remove if deploying to heroku

	// Initialize router
	r := chi.NewRouter()

	// Configure CORS handler
	CORS := cors.New(cors.Options{
		AllowedOrigins:   []string{"http://192.168.1.5:3000"}, // add prod server origin on deployment
		AllowedMethods:   []string{"GET", "OPTIONS"},
		AllowedHeaders:   []string{},
		ExposedHeaders:   []string{},
		AllowCredentials: true,
		MaxAge:           300,
		Debug:            false,
	})

	// Specify middleware
	r.Use(CORS.Handler)
	r.Use(middleware.RequestID)
	// r.Use(middleware.RealIP)
	// r.Use(middleware.Logger)
	r.Use(middleware.Recoverer)

	// Configure session store
	store.Options = &sessions.Options{
		Path:     "/",
		HttpOnly: true,
		Secure:   false,
		//Secure: true, // Set to true on deploy
	}

	// Handlers
	r.Get("/login", loginHandler)
	r.Get("/playlist", playlistHandler)

	// Serve
	port := os.Getenv("PORT")
	if port == "" {
		log.Fatal("$PORT must be set")
	}
	http.ListenAndServe(":"+port, r)
}

// loginHandler responds to requests with an authorization URL configured for a
// user's Spotify data. In addition, a session is created to store the caller's
// UUID and time of request. Sessions are saved as secure, encrypted cookies.
func loginHandler(w http.ResponseWriter, r *http.Request) {
	sess, err := store.Get(r, sessionName)
	if err != nil {
		log.Println(err)
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	uid, err := uuid.NewV4()
	if err != nil {
		log.Println(err)
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	id := uid.String()
	time := time.Now().String()

	sess.Values["id"] = id
	sess.Values["time"] = time
	delete(sess.Values, "playlist")
	sess.Save(r, w)

	sum := concatBuf(id, time)
	state, err := hash(sum.Bytes())
	if err != nil {
		log.Println(err)
		http.Error(w, "hash error", http.StatusInternalServerError)
	}

	enc := base64.URLEncoding.EncodeToString(state)
	url := auth.AuthURL(enc)

	login := Login{URL: url}
	render.JSON(w, r, login)
}

// playlistHandler responds to requests with a Spotify playlist URI generated
// using the authenticated user's playback data. This URI is stored in the
// user's session and is used as the response to any further requests unless
// the URI is cleared from the session.
func playlistHandler(w http.ResponseWriter, r *http.Request) {
	sess, err := store.Get(r, sessionName)
	if err != nil {
		log.Println(err)
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	if uri, ok := sess.Values["playlist"].(string); ok {
		payload := Playlist{URI: uri}
		render.JSON(w, r, payload)
		return
	}

	tok, err := authorizeRequest(w, r)
	if err != nil {
		log.Println(err)
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	nc := auth.NewClient(tok)
	nc.AutoRetry = true

	g := newGenerator(&nc)

	pl, err := g.BestPlaylist()
	if err != nil {
		log.Println(err)
		http.Error(w, "cannot create playlist", http.StatusInternalServerError)
		return
	}

	sess.Values["playlist"] = string(pl.URI)
	sess.Save(r, w)

	payload := Playlist{URI: string(pl.URI)}
	render.JSON(w, r, payload)
}

// authorizeRequest returns an oauth2 token authenticated for access to a
// particular user's Spotify data after verifying the same user both
// initiated and authorized the request. This verification is done by checking
// for a matching state from the initial request and this subsequent callback.
func authorizeRequest(w http.ResponseWriter, r *http.Request) (*oauth2.Token, error) {
	sess, err := store.Get(r, sessionName)
	if err != nil {
		return nil, err
	}

	id, ok := sess.Values["id"].(string)
	if !ok {
		return nil, errors.New("id value not found")
	}

	time, ok := sess.Values["time"].(string)
	if !ok {
		return nil, errors.New("time value not found")
	}

	sum := concatBuf(id, time)
	state, err := hash(sum.Bytes())
	if err != nil {
		return nil, err
	}

	enc := base64.URLEncoding.EncodeToString(state)
	tok, err := auth.Token(enc, r)
	if err != nil {
		return nil, err
	}

	return tok, nil
}
