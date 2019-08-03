package main

import (
	"github.com/go-chi/render"
	"net/http"
)

// login contains the URL configured for Spotify authentication.
type login struct {
	URL string `json:"url"`
}

// loginHandler responds to requests with an authorization URL configured for a
// user's Spotify data. In addition, a session is created to store the caller's
// UUID and time of request. Sessions are saved as secure, encrypted cookies.
func loginHandler(env *Env, w http.ResponseWriter, r *http.Request) error {
	url := env.Auth.AuthURL(state)

	l := login{URL: url}
	render.JSON(w, r, l)

	return nil
}
