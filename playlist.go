package main

import (
	"encoding/base64"
	"github.com/Henry-Sarabia/refind"
	"github.com/Henry-Sarabia/refind/buffer"
	"github.com/go-chi/render"
	"github.com/pkg/errors"
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
	sess, err := env.Store.Get(r, sessionName)
	if err != nil {
		return StatusError{http.StatusInternalServerError, errors.Wrapf(err, "cannot get session '%s'", sessionName)}
	}
	if uri, ok := sess.Values["playlist"].(string); ok {
		p := playlist{URI: uri}
		render.JSON(w, r, p)
		return nil
	}

	tok, err := authorizeRequest(env, r)
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

	sess.Values["playlist"] = string(pl.URI)
	if err := sess.Save(r, w); err != nil {
		return StatusError{http.StatusInternalServerError, errors.Wrap(err, "cannot save session")}
	}

	p := playlist{URI: string(pl.URI)}
	render.JSON(w, r, p)

	return nil
}

// authorizeRequest returns an oauth2 token authenticated for access to a
// particular user's Spotify data after verifying the same user both
// initiated and authorized the request. This verification is done by checking
// for a matching state from the initial request and this subsequent callback.
func authorizeRequest(env *Env, r *http.Request) (*oauth2.Token, error) {
	sess, err := env.Store.Get(r, sessionName)
	if err != nil {
		return nil, err
	}

	id, ok := sess.Values["id"].(string)
	if !ok {
		return nil, errors.New("cannot find 'id' value")
	}

	tm, ok := sess.Values["time"].(string)
	if !ok {
		return nil, errors.New("cannot find 'time' value")
	}

	sum := id + tm
	state, err := hash([]byte(sum), []byte(env.HashKey))
	if err != nil {
		return nil, err
	}

	enc := base64.URLEncoding.EncodeToString(state)
	tok, err := env.Auth.Token(enc, r)
	if err != nil {
		return nil, err
	}

	return tok, nil
}
