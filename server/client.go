package main

import (
	"errors"
	"fmt"

	"github.com/zmb3/spotify"
)

var (
	errNoRecentTracks = errors.New("recentTracks: there are no recent tracks to return")
	errNoTopArtists   = errors.New("topArtists: there are no top artists to return")
)

// playlist creates and returns a playlist with the provided name and
// populates it with the tracks corresponding to the provided IDs.
func (g *generator) playlist(name string, IDs []spotify.ID) (*spotify.FullPlaylist, error) {
	u, err := g.client.CurrentUser()
	if err != nil {
		return nil, err
	}

	pl, err := g.client.CreatePlaylistForUser(u.ID, name, publicPlaylist)
	if err != nil {
		return nil, err
	}

	_, err = g.client.AddTracksToPlaylist(u.ID, pl.ID, IDs...)
	if err != nil {
		return nil, err
	}

	return pl, nil
}

// recentTracks returns a list of the user's recently played tracks.
func (g *generator) recentTracks(num int) ([]spotify.SimpleTrack, error) {
	opt := spotify.RecentlyPlayedOptions{
		Limit: num,
	}
	rp, err := g.client.PlayerRecentlyPlayedOpt(&opt)
	if err != nil {
		return nil, err
	}
	if len(rp) == 0 {
		return nil, errNoRecentTracks
	}

	tracks := make([]spotify.SimpleTrack, 0)
	for _, t := range rp {
		tracks = append(tracks, t.Track)
	}

	return tracks, nil
}

// topArtists returns a list of the user's top artists from the provided
// time-frame.
func (g *generator) topArtists(num int, time string) (*spotify.FullArtistPage, error) {
	opt := spotify.Options{
		Limit:     &num,
		Timerange: &time,
	}
	top, err := g.client.CurrentUsersTopArtistsOpt(&opt)
	if err != nil {
		return nil, err
	}

	if len(top.Artists) == 0 {
		return nil, errNoTopArtists
	}

	return top, nil
}

// allTopArtists returns a list of the user's top artists from every available
// timeframe.
func (g *generator) allTopArtists() ([]spotify.FullArtist, error) {
	s, err := g.topArtists(maxRequestArtists, "short")
	if err != nil {
		return nil, err
	}

	m, err := g.topArtists(maxRequestArtists, "medium")
	if err != nil {
		return nil, err
	}

	l, err := g.topArtists(maxRequestArtists, "long")
	if err != nil {
		return nil, err
	}

	all := append(l.Artists, m.Artists...)
	all = append(all, s.Artists...)
	all = removeDuplicateArtists(all)

	return all, nil
}

// recommendation returns a list of recommended tracks based on the given
// seed.
func (g *generator) recommendation(sd spotify.Seeds, num int, attr *spotify.TrackAttributes) ([]spotify.SimpleTrack, error) {
	if num < minRequestTracks || num > maxRequestArtists {
		return nil, fmt.Errorf("recommendation: invalid input of %d, expecting input between %d and %d", num, minRequestTracks, maxRequestTracks)
	}
	opt := &spotify.Options{Limit: &num}
	rec, err := g.client.GetRecommendations(sd, attr, opt)
	if err != nil {
		return nil, err
	}

	return rec.Tracks, nil
}
