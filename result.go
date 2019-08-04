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
	v, ok := env.Views[resultView]
	if !ok {
		return errors.Errorf("cannot find '%s' view", resultView)
	}

	q := r.URL.Query()

	code := q.Get("code")
	if blank.Is(code) {
		_ = v.Render(w, &playlist{})
		return StatusError{http.StatusInternalServerError, errors.New("result url is missing code")}
	}

	state := q.Get("state")
	if blank.Is(state) {
		_ = v.Render(w, playlist{})
		return StatusError{http.StatusInternalServerError, errors.New("result url is missing state")}
	}

	val := url.Values{}
	val.Set("code", code)
	val.Set("state", state)

	resp, err := http.Get(frontendURI + apiPath + playlistPath + "?" + val.Encode())
	if err != nil {
		_ = v.Render(w, playlist{})
		return StatusError{http.StatusBadGateway, err}
	}
	defer resp.Body.Close()

	b, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		_ = v.Render(w, playlist{})
		return StatusError{http.StatusInternalServerError, errors.Wrap(err, "invalid response body from playlist endpoint")}
	}

	play := &playlist{}

	err = json.Unmarshal(b, &play)
	if err != nil {
		_ = v.Render(w, playlist{})
		return StatusError{http.StatusInternalServerError, errors.Wrap(err, "cannot unmarshal JSON response from playlist endpoint")}
	}

	if blank.Is(string(play.URI)) {
		_ = v.Render(w, playlist{})
		return StatusError{http.StatusInternalServerError, errors.Wrap(err, "URI value is blank")}
	}

	return v.Render(w, play)
}
