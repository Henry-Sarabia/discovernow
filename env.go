package main

import (
	"github.com/Henry-Sarabia/discovernow/views"
	"github.com/gorilla/sessions"
	"github.com/zmb3/spotify"
)

// Env contains the application environment.
type Env struct {
	Store *sessions.CookieStore
	Auth  *spotify.Authenticator
	Views map[string]*views.View
}
