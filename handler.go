package main

import (
	"github.com/gorilla/sessions"
	"github.com/zmb3/spotify"
	"log"
	"net/http"
)

// HandlerError represents an error from a handler function.
// It provides the embedded error interface methods and a custom
// HTTP status code method.
type HandlerError interface {
	error
	Status() int
}

// StatusError represents an HTTP status error.
type StatusError struct {
	Code int
	Err  error
}

// Error returns a StatusError's error.
func (se StatusError) Error() string {
	return se.Err.Error()
}

// Status returns the HTTP status code.
func (se StatusError) Status() int {
	return se.Code
}

// Env contains the application environment.
type Env struct {
	Store *sessions.CookieStore
	Auth  *spotify.Authenticator
}

type Handler struct {
	*Env
	H func(e *Env, w http.ResponseWriter, r *http.Request) error
}

func (h Handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	err := h.H(h.Env, w, r)
	if err != nil {
		switch e := err.(type) {
		case HandlerError:
			log.Printf("HTTP %d - %s", e.Status(), e)
			http.Error(w, e.Error(), e.Status())
		default:
			http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
		}
	}
}
