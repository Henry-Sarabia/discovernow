package main

import (
	"log"
	"net/http"
)

type appHandler func(http.ResponseWriter, *http.Request) (int, error)

func (fn appHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	status, err := fn(w, r)
	if status >= 400 {
		http.Error(w, http.StatusText(status), status)
	}

	if err != nil {
		log.Println(err)
	}
}