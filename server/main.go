package main

import (
	"errors"
	"log"
	"net/http"
	"os"

	"github.com/go-chi/chi"
	"github.com/go-chi/cors"
	"github.com/go-chi/render"
	"github.com/zmb3/spotify"
)

const (
	redirectURI = "http://localhost:3000/results"
	// redirectURI = "https://discover-test-69db3.firebaseapp.com/results"
)

var (
	auth = spotify.NewAuthenticator(
		redirectURI,
		spotify.ScopeUserReadPrivate,
		spotify.ScopeUserTopRead,
		spotify.ScopeUserReadRecentlyPlayed,
		spotify.ScopePlaylistModifyPublic,
	)
	ch    = make(chan *spotify.Client)
	state = "abc123"
)

// Login contains the URL to be delivered to the Elm frontend.
type Login struct {
	URL string `json:"url"`
}

// Playlist contains the ID to a user's playlist
type Playlist struct {
	ID string `json:"id"`
	// Type string `json:"type"`
	// Fallback bool   `json:"fallback"`
	// Error    string `json:"error"`
}

func main() {
	// remove if deploying to heroku
	os.Setenv("PORT", "8080")
	r := chi.NewRouter()

	r.Use(cors.Default().Handler)

	r.Get("/login", httpLoginURL)
	r.Get("/playlist", httpPlaylist)
	r.Get("/test", httpTest)

	port := os.Getenv("PORT")
	if port == "" {
		log.Fatal("$PORT must be set")
	}
	http.ListenAndServe(":"+port, r)
}

func httpTest(w http.ResponseWriter, r *http.Request) {
	render.PlainText(w, r, "testing testing")
}

func httpLoginURL(w http.ResponseWriter, r *http.Request) {
	log.Println("Got request for: ", r.URL.String())
	log.Println("Replied.")

	url := auth.AuthURL(state)
	login := Login{URL: url}
	render.JSON(w, r, login)
}

// TODO: Add error checking to completeAuth
func httpPlaylist(w http.ResponseWriter, r *http.Request) {
	g, err := completeAuth(w, r)
	if err != nil {
		log.Println(err)
		return
	}

	pl, err := g.MostRelevantPlaylist()
	if err != nil {
		log.Println(err)
		http.Error(w, "cannot create playlist", http.StatusInternalServerError)
		return
	}

	payload := Playlist{ID: string(pl.URI)}
	render.JSON(w, r, payload)
	return
}

// TODO: Figure out if those http.Errors should instead just return normal errors
func completeAuth(w http.ResponseWriter, r *http.Request) (*generator, error) {
	tok, err := auth.Token(state, r)
	if err != nil {
		http.Error(w, "Couldn't get token", http.StatusForbidden)
		return nil, err
	}

	if st := r.FormValue("state"); st != state {
		http.NotFound(w, r)
		log.Printf("State mismatch: %s != %s\n", st, state)
		return nil, errors.New("state mistmatch")
	}

	client := auth.NewClient(tok)
	client.AutoRetry = true
	return newGenerator(&client), nil
}
