package main

import (
	"log"
	"net/http"

	"github.com/go-chi/chi"
	"github.com/go-chi/cors"
	"github.com/go-chi/render"
	"github.com/zmb3/spotify"
)

const (
	redirectURI = "http://localhost:3000/results"
)

var (
	auth  = spotify.NewAuthenticator(redirectURI, spotify.ScopeUserReadPrivate)
	ch    = make(chan *spotify.Client)
	state = "abc123"
)

// Payload contains the URL to be delivered to the Elm frontend.
type Payload struct {
	URL string `json:"url"`
}

// Playlist contains the ID to a user's playlist
type Playlist struct {
	ID string `json:"id"`
}

func main() {
	r := chi.NewRouter()

	r.Use(cors.Default().Handler)

	r.Get("/login", httpLoginURL)
	r.Get("/playlist", httpCompleteAuth)

	http.ListenAndServe(":8080", r)
}

func httpLoginURL(w http.ResponseWriter, r *http.Request) {
	log.Println("Got request for: ", r.URL.String())

	url := auth.AuthURL(state)
	// send this state to elm app through payload
	payload := Payload{URL: url}
	render.JSON(w, r, payload)
}

func httpCompleteAuth(w http.ResponseWriter, r *http.Request) {
	tok, err := auth.Token(state, r)
	if err != nil {
		http.Error(w, "Couldn't get token", http.StatusForbidden)
		log.Print(err)
		return
	}

	if st := r.FormValue("state"); st != state {
		http.NotFound(w, r)
		log.Printf("State mismatch: %s != %s\n", st, state)
		return

	}

	var tr string
	if tr = r.FormValue("timerange"); !isValidRange(tr) {
		http.NotFound(w, r)
		log.Printf("Timerange '%s' is not valid", tr)
		return
	}
	log.Println(tr)

	client := auth.NewClient(tok)

	u, err := client.CurrentUser()
	if err != nil {
		log.Print(err)
		return
	}

	log.Println(u.User.ID)
	pl := Playlist{ID: "mockPlaylistID"}
	render.JSON(w, r, pl)
}

func isValidRange(r string) bool {
	if r == "short" || r == "medium" || r == "long" {
		return true
	}
	return false
}
