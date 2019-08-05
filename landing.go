package main

import (
	"encoding/json"
	"github.com/pkg/errors"
	"io/ioutil"
	"net/http"
)

func landingHandler(env *Env, w http.ResponseWriter, r *http.Request) error {
	v, ok := env.Views[landingView]
	if !ok {
		return errors.Errorf("cannot find '%s' view", landingView)
	}

	resp, err := http.Get(env.FrontendURI + apiPath + loginPath)
	if err != nil {
		_ = v.Render(w, login{})
		return StatusError{http.StatusBadGateway, err}
	}
	defer resp.Body.Close()

	b, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		_ = v.Render(w, login{})
		return StatusError{http.StatusInternalServerError, err}
	}

	l := &login{}

	err = json.Unmarshal(b, &l)
	if err != nil {
		_ = v.Render(w, login{})
		return StatusError{http.StatusInternalServerError, err}
	}

	return v.Render(w, l)
}
