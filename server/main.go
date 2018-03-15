package main

import (
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
)

var (
	auth = spotify.NewAuthenticator(
		redirectURI,
		spotify.ScopeUserReadPrivate,
		spotify.ScopeUserTopRead,
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
}

func main() {
	os.Setenv("PORT", "8080")
	r := chi.NewRouter()

	r.Use(cors.Default().Handler)

	r.Get("/login", httpLoginURL)
	r.Get("/summary", httpSummary)
	r.Get("/discover", httpDiscover)

	port := os.Getenv("PORT")
	if port == "" {
		log.Fatal("$PORT must be set")
	}
	http.ListenAndServe(":"+port, r)
}

func httpLoginURL(w http.ResponseWriter, r *http.Request) {
	log.Println("Got request for: ", r.URL.String())

	url := auth.AuthURL(state)
	// send this state to elm app through login
	login := Login{URL: url}
	render.JSON(w, r, login)
}

// httpSummary
func httpSummary(w http.ResponseWriter, r *http.Request) {
	g := completeAuth(w, r)

	var time string
	if time = r.FormValue("timerange"); !isValidRange(time) {
		http.NotFound(w, r)
		log.Printf("Timerange '%s' is not valid", time)
		return
	}

	pl, err := g.TasteSummary(time)
	if err != nil {
		log.Print(err)
		return
	}

	payload := Playlist{ID: string(pl.URI)}
	render.JSON(w, r, payload)
}

func httpDiscover(w http.ResponseWriter, r *http.Request) {
	g := completeAuth(w, r)

	pl, err := g.Discover()
	if err != nil {
		log.Print(err)
		return
	}

	payload := Playlist{ID: string(pl.URI)}
	render.JSON(w, r, payload)
}

// TODO: Figure out if those http.Errors should instead just return normal errors
func completeAuth(w http.ResponseWriter, r *http.Request) *generator {
	tok, err := auth.Token(state, r)
	if err != nil {
		http.Error(w, "Couldn't get token", http.StatusForbidden)
		log.Print(err)
		return nil
	}

	if st := r.FormValue("state"); st != state {
		http.NotFound(w, r)
		log.Printf("State mismatch: %s != %s\n", st, state)
		return nil
	}

	c := auth.NewClient(tok)
	return &generator{client: &c}
}

func isValidRange(r string) bool {
	if r == "short" || r == "medium" || r == "long" {
		return true
	}
	return false
}
