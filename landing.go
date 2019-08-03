package main

import (
	"encoding/json"
	"io/ioutil"
	"net/http"
)

func landingHandler(env *Env, w http.ResponseWriter, r *http.Request) error {
	resp, err := http.Get(frontendURI + apiPath + loginPath)
	if err != nil {
		_ = landing.Render(w, login{})
		return StatusError{http.StatusBadGateway, err}
	}
	defer resp.Body.Close()

	b, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		_ = landing.Render(w, login{})
		return StatusError{http.StatusInternalServerError, err}
	}

	l := &login{}

	err = json.Unmarshal(b, &l)
	if err != nil {
		_ = landing.Render(w, login{})
		return StatusError{http.StatusInternalServerError, err}
	}

	return landing.Render(w, l)
}