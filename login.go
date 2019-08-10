package main

import (
	"crypto/hmac"
	"crypto/sha256"
	"encoding/base64"
	"github.com/go-chi/render"
	"github.com/pkg/errors"
	"github.com/satori/go.uuid"
	"net/http"
	"time"
)

// login contains the URL configured for Spotify authentication.
type login struct {
	URL string `json:"url"`
}

// loginHandler responds to requests with an authorization URL configured for a
// user's Spotify data. In addition, a session is created to store the caller's
// UUID and time of request. Sessions are saved as secure, encrypted cookies.
func loginHandler(env *Env, w http.ResponseWriter, r *http.Request) error {
	sess, err := env.Store.Get(r, sessionName)
	if err != nil {
		return StatusError{http.StatusInternalServerError, errors.Wrapf(err, "cannot get session '%s'", sessionName)}
	}

	uid, err := uuid.NewV4()
	if err != nil {
		return StatusError{http.StatusInternalServerError, errors.Wrap(err, "cannot generate UUID")} //TODO: Can these InternalServerErrors just be the default?
	}

	id := uid.String()
	now := time.Now().String()

	sess.Values["id"] = id
	sess.Values["time"] = now
	delete(sess.Values, "playlist")

	sum := id + now
	state, err := hash([]byte(sum), env.HashKey) //TODO: Can I use a []byte variable instead?
	if err != nil {
		return StatusError{http.StatusInternalServerError, errors.Wrap(err, "cannot get state hash")}
	}

	enc := base64.URLEncoding.EncodeToString(state)
	url := env.Auth.AuthURL(enc)

	l := login{URL: url}
	render.JSON(w, r, l)

	return nil
}

// hash returns the HMAC hash of the provided slice of bytes using SHA-256.
func hash(b []byte, key []byte) ([]byte, error) {
	mac := hmac.New(sha256.New, key)

	_, err := mac.Write(b)
	if err != nil {
		return nil, err
	}

	h := mac.Sum(nil)
	return h, nil
}
