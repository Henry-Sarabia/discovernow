package main

import (
	"github.com/Henry-Sarabia/discovernow/views"
	"github.com/gorilla/sessions"
	"github.com/zmb3/spotify"
)

// Env contains the application environment.
type Env struct {
	Store       *sessions.CookieStore
	Auth        *spotify.Authenticator
	Views       map[string]*views.View
	FrontendURI string
	HashKey     string
}

// config contains the application environment variables.
type config struct {
	Production  bool   `env:"DISCOVER_PRODUCTION"`
	HashKey     string `env:"DISCOVER_HASH"`
	StoreAuth   string `env:"DISCOVER_AUTH"`
	StoreCrypt  string `env:"DISCOVER_CRYPT"`
	FrontendURI string `env:"FRONTEND_URI"` //TODO: standardize with `DISCOVER` prefix
}
