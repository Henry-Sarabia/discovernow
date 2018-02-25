package main

import (
	"errors"
	"log"

	"github.com/davecgh/go-spew/spew"
	"github.com/zmb3/spotify"
)

const (
	maxArtists    = 15 // max = 50
	minArtistData = 15
)

type generator struct {
	client clienter
}

type genre struct {
	name    string
	artists []string
	score   int
}

type genres map[string]*genre

// clienter is implemented by any type that has certain Spotify functions.
// Helpful for testing purposes.
type clienter interface {
	CurrentUsersTopArtistsOpt(*spotify.Options) (*spotify.FullArtistPage, error)
}

func (g *generator) playlist(tr string) error {
	log.Println("Calling playlist()")
	ta, err := g.artists(maxArtists, tr)
	if err != nil {
		return err
	}

	gs, err := extractGenres(ta)
	if err != nil {
		return err
	}

	scs := spew.ConfigState{SortKeys: true}
	scs.Dump(gs)
	return nil
}

func (g *generator) artists(lim int, tr string) (*spotify.FullArtistPage, error) {
	log.Println("Calling artists()")
	opt := spotify.Options{
		Limit:     &lim,
		Timerange: &tr,
	}
	ta, err := g.client.CurrentUsersTopArtistsOpt(&opt)
	if err != nil {
		return nil, err
	}

	return ta, nil
}

func extractGenres(art *spotify.FullArtistPage) (genres, error) {
	log.Println("Calling extractGenres()")
	if len(art.Artists) < minArtistData {
		return nil, errors.New("insufficient artist data")
	}

	genmap := make(genres)
	for _, a := range art.Artists {
		for _, n := range a.Genres {
			if _, ok := genmap[n]; !ok {
				genmap[n] = &genre{
					name:    n,
					artists: make([]string, 1),
					score:   0,
				}
			}
			genmap[n].artists = append(genmap[n].artists, a.Name)
			genmap[n].score++
		}
	}

	return genmap, nil
}

// func ()
