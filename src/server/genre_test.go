package main

import (
	"encoding/json"
	"os"
	"testing"

	"github.com/zmb3/spotify"
)

type testClient struct {
}

func (ts testClient) CurrentUsersTopArtistsOpt(opt *spotify.Options) (*spotify.FullArtistPage, error) {
	a, err := loadArtists("testdata.json")
	if err != nil {
		return nil, err
	}

	return a, nil
}

func loadArtists(name string) (*spotify.FullArtistPage, error) {
	var a spotify.FullArtistPage
	file, err := os.Open(name)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	dec := json.NewDecoder(file)
	dec.Decode(&a)
	return &a, nil
}

func TestArtists(t *testing.T) {
	g := generator{
		client: testClient{},
	}

	art, err := g.artists(50, "long")
	if err != nil {
		t.Fatal(err)
	}

	expLength := 50
	actLength := len(art.Artists)
	if actLength != expLength {
		t.Fatalf("Expected length %d, got %d", expLength, actLength)
	}

	expName := "Radiohead"
	actName := art.Artists[0].Name
	if actName != expName {
		t.Fatalf("Expected name %s, got %s", expName, actName)
	}

	return
}
