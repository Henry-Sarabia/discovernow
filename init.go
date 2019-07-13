package main

import (
	"encoding/hex"
	spotifyservice "github.com/Henry-Sarabia/refind/spotify"
	"github.com/pkg/errors"
	"log"
	"os"
)

func init() {
	var err error

	hashKey, err = decodeEnv(hashKeyName)
	if err != nil {
		log.Fatal(err)
	}

	storeAuth, err = decodeEnv(storeAuthName)
	if err != nil {
		log.Fatal(err)
	}

	storeCrypt, err = decodeEnv(storeCryptName)
	if err != nil {
		log.Fatal(err)
	}

	frontendURI, err = getEnv(frontendURIName)
	if err != nil {
		log.Fatal(err)
	}

	auth, err = spotifyservice.Authenticator(frontendURI + redirectPath)
	if err != nil {
		log.Fatalf("stack trace:\n%+v\n", err)
	}
}

func decodeEnv(name string) (string, error) {
	env, err := getEnv(name)
	if err != nil {
		return "", err
	}

	d, err := hex.DecodeString(env)
	if err != nil {
		return "", errors.Wrapf(err, "environment variable with name '%s' cannot be decoded from hex", name)
	}

	return string(d), nil
}

func getEnv(name string) (string, error) {
	env, ok := os.LookupEnv(name)
	if !ok {
		return "", errors.Errorf("environment variable with name '%s' cannot be found", name)
	}

	return env, nil
}
