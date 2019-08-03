package main

import (
	"github.com/Henry-Sarabia/refind"
	"github.com/Henry-Sarabia/refind/buffer"
	"github.com/go-chi/render"
	"github.com/pkg/errors"
	"github.com/zmb3/spotify"
	"golang.org/x/oauth2"
	"net/http"
	"strings"

	spotifyservice "github.com/Henry-Sarabia/refind/spotify"
	adj "github.com/nii236/adjectiveadjectiveanimal"
)

const (
	playlistLimit       int    = 30
	playlistDescription string = "Curated by Discover Now"
)

// playlist contains the URI of a user's playlist.
type playlist struct {
	URI string `json:"uri"`
}

// playlistHandler responds to requests with a Spotify playlist URI generated
// using the authenticated user's playback data. This URI is stored in the
// user's session and is used as the response to any further requests unless
// the URI is cleared from the session.
func playlistHandler(env *Env, w http.ResponseWriter, r *http.Request) error {
	tok, err := authorizeRequest(env.Auth, w, r)
	if err != nil {
		return StatusError{http.StatusBadGateway, errors.Wrap(err, "cannot authorize Spotify request")}
	}

	c := env.Auth.NewClient(tok)
	c.AutoRetry = true

	serv, err := spotifyservice.New(&c)
	if err != nil {
		return StatusError{http.StatusInternalServerError, errors.Wrap(err, "cannot initialize Spotify service")}
	}

	buf, err := buffer.New(serv)
	if err != nil {
		return StatusError{http.StatusInternalServerError, errors.Wrap(err, "cannot initialize service buffer")}
	}

	gen, err := refind.New(buf, serv)
	if err != nil {
		return StatusError{http.StatusInternalServerError, errors.Wrap(err, "cannot initialize Refind client")}
	}

	list, err := gen.Tracklist(playlistLimit)
	if err != nil {
		return StatusError{http.StatusInternalServerError, errors.Wrap(err, "cannot generate track list")}
	}

	t := strings.Title(adj.GenerateCombined(1, "-"))

	pl, err := serv.Playlist(t, playlistDescription, list)
	if err != nil {
		return StatusError{http.StatusInternalServerError, errors.Wrap(err, "cannot create user playlist")}
	}

	p := playlist{URI: string(pl.URI)}
	render.JSON(w, r, p)

	return nil
}

// authorizeRequest returns an oauth2 token authenticated for access to a
// particular user's Spotify data after verifying the same user both
// initiated and authorized the request. This verification is done by checking
// for a matching state from the initial request and this subsequent callback.
func authorizeRequest(auth *spotify.Authenticator, w http.ResponseWriter, r *http.Request) (*oauth2.Token, error) {
	tok, err := auth.Token(state, r)
	if err != nil {
		return nil, err
	}

	return tok, nil
}
