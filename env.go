package main

import (
	"encoding/hex"
	"github.com/Henry-Sarabia/discovernow/views"
	"github.com/gorilla/sessions"
	"github.com/pkg/errors"
	"github.com/zmb3/spotify"
	"log"
	"os"
)

// Env contains the application environment.
type Env struct {
	Store       *sessions.CookieStore
	Auth        *spotify.Authenticator
	Views       map[string]*views.View
	FrontendURI string
	HashKey     []byte
}

// mustDecodeHexEnv retrieves and hex decodes the environment variable with the
// provided name. Panics if environment variable is not set.
func mustDecodeHexEnv(name string) []byte {
	env, err := decodeHexEnv(name)
	if err != nil {
		log.Fatal(err)
	}

	return env
}

// decodeHexEnv retrieves and hex decodes the environment variable with the
// provided name. Returns an error if environment variable is not set.
func decodeHexEnv(name string) ([]byte, error) {
	env, err := getEnv(name)
	if err != nil {
		return nil, err
	}

	h, err := hex.DecodeString(env)
	if err != nil {
		return nil, errors.Wrapf(err, "environment variable with name '%s' cannot be decoded from hex", name)
	}

	return h, nil
}

// mustGetEnv retrieves the environment variable with the provided name.
// Panics if environment variable is not set.
func mustGetEnv(name string) string {
	env, err := getEnv(name)
	if err != nil {
		log.Fatal(err)
	}

	return env
}

// getEnv retrieves the environment variable with the provided name. Returns
// an error if environment variable is not set.
func getEnv(name string) (string, error) {
	env, ok := os.LookupEnv(name)
	if !ok {
		return "", errors.Errorf("environment variable with name '%s' cannot be found", name)
	}

	return env, nil
}