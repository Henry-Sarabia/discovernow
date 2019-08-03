package main

import (
	"encoding/json"
	"github.com/Henry-Sarabia/blank"
	"github.com/pkg/errors"
	"io/ioutil"
	"net/http"
	"net/url"
)

func resultHandler(env *Env, w http.ResponseWriter, r *http.Request) error {
	q := r.URL.Query()

	code := q.Get("code")
	if blank.Is(code) {
		_ = result.Render(w, &playlist{})
		return StatusError{http.StatusInternalServerError, errors.New("result url is missing code")}
	}

	state := q.Get("state")
	if blank.Is(state) {
		_ = result.Render(w, playlist{})
		return StatusError{http.StatusInternalServerError, errors.New("result url is missing state")}
	}

	v := url.Values{}
	v.Set("code", code)
	v.Set("state", state)

	resp, err := http.Get(frontendURI + apiPath + playlistPath + "?" + v.Encode())
	if err != nil {
		_ = result.Render(w, playlist{})
		return StatusError{http.StatusBadGateway, err}
	}
	defer resp.Body.Close()

	b, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		_ = result.Render(w, playlist{})
		return StatusError{http.StatusInternalServerError, errors.Wrap(err, "invalid response body from playlist endpoint")}
	}

	play := &playlist{}

	err = json.Unmarshal(b, &play)
	if err != nil {
		_ = result.Render(w, playlist{})
		return StatusError{http.StatusInternalServerError, errors.Wrap(err, "cannot unmarshal JSON response from playlist endpoint")}
	}

	if blank.Is(string(play.URI)) {
		_ = result.Render(w, playlist{})
		return StatusError{http.StatusInternalServerError, errors.Wrap(err, "URI value is blank")}
	}

	return result.Render(w, play)
}