package main

import (
	"errors"
	"log"

	"github.com/zmb3/spotify"
)

const (
	targetPopularity  = 40
	maxPopularity     = 50
	minRequestArtists = 1
	minPlaylistTracks = 1
)

var (
	errRecentTracksMissing   = errors.New("recentTracks: there are no recent tracks to return")
	errTopArtistsMissing     = errors.New("topArtists: there are no top artists to return")
	errNumRange              = errors.New("input is out of range")
	errTimeMissing           = errors.New("TopArtistsVar: missing time range")
	errTimeInvalid           = errors.New("TopArtists: invalid time range")
	errPlaylistTracksMissing = errors.New("Playlist: missing playlist tracks")
)

// clienter is implemented by any type that has certain Spotify functions.
// Helpful for testing purposes.
type clienter interface {
	CurrentUser() (*spotify.PrivateUser, error)
	CurrentUsersTopArtistsOpt(*spotify.Options) (*spotify.FullArtistPage, error)
	CurrentUsersTopTracksOpt(*spotify.Options) (*spotify.FullTrackPage, error)
	PlayerRecentlyPlayedOpt(*spotify.RecentlyPlayedOptions) ([]spotify.RecentlyPlayedItem, error)
	GetRecommendations(spotify.Seeds, *spotify.TrackAttributes, *spotify.Options) (*spotify.Recommendations, error)
	CreatePlaylistForUser(string, string, bool) (*spotify.FullPlaylist, error)
	AddTracksToPlaylist(string, spotify.ID, ...spotify.ID) (string, error)
	GetArtists(...spotify.ID) ([]*spotify.FullArtist, error)
}

type spotClient struct {
	c               clienter
	user            *spotify.PrivateUser
	topArtistsShort []spotify.FullArtist
	topArtistsMed   []spotify.FullArtist
	topArtistsLong  []spotify.FullArtist
	topTracksShort  []spotify.FullTrack
	topTracksMed    []spotify.FullTrack
	topTracksLong   []spotify.FullTrack
	recentTracks    []spotify.SimpleTrack
	recentArtists   []spotify.FullArtist
	requests        int
}

// User returns the currently logged in Spotify user.
func (sc *spotClient) User() (*spotify.PrivateUser, error) {
	if sc.user != nil {
		return sc.user, nil
	}

	u, err := sc.c.CurrentUser()
	sc.requests++
	if err != nil {
		return nil, err
	}

	sc.user = u

	return u, nil
}

// TopArtistsVar returns a concatenated list of the num top artists from each
// provided time range for the current user.
func (sc *spotClient) TopArtistsVar(num int, time ...string) ([]spotify.FullArtist, error) {
	if len(time) <= 0 {
		return nil, errTimeMissing
	}

	top := make([]spotify.FullArtist, 0)
	for _, t := range time {
		curr, err := sc.TopArtists(num, t)
		if err != nil {
			return nil, err
		}
		top = append(top, curr...)
	}
	return top, nil
}

// TopArtists returns a list of the num top artists from the provided time
// range for the current user.
func (sc *spotClient) TopArtists(num int, time string) ([]spotify.FullArtist, error) {
	if num < minRequestArtists || num > maxRequestArtists {
		return nil, errNumRange
	}

	opt := &spotify.Options{Limit: &num, Timerange: &time}
	switch time {
	case "short":
		if sc.topArtistsShort != nil {
			return sc.topArtistsShort, nil
		}

		top, err := sc.c.CurrentUsersTopArtistsOpt(opt)
		sc.requests++
		if err != nil {
			return nil, err
		}

		sc.topArtistsShort = top.Artists

		return top.Artists, nil

	case "medium":
		if sc.topArtistsMed != nil {
			return sc.topArtistsMed, nil
		}

		top, err := sc.c.CurrentUsersTopArtistsOpt(opt)
		sc.requests++
		if err != nil {
			return nil, err
		}

		sc.topArtistsMed = top.Artists

		return top.Artists, nil

	case "long":
		if sc.topArtistsLong != nil {
			return sc.topArtistsLong, nil
		}

		top, err := sc.c.CurrentUsersTopArtistsOpt(opt)
		sc.requests++
		if err != nil {
			return nil, err
		}

		sc.topArtistsLong = top.Artists

		return top.Artists, nil

	default:
		return nil, errTimeInvalid
	}
}

// TopTracksVar returns a concatenated list of the num top tracks from each
// provided time range for the current user.
func (sc *spotClient) TopTracksVar(num int, time ...string) ([]spotify.FullTrack, error) {
	if len(time) <= 0 {
		return nil, errTimeMissing
	}

	top := make([]spotify.FullTrack, 0)
	for _, t := range time {
		curr, err := sc.TopTracks(num, t)
		if err != nil {
			return nil, err
		}
		top = append(top, curr...)
	}

	return top, nil
}

// TopTracks returns a list of the num top tracks from the provided time range
// for the current user.
func (sc *spotClient) TopTracks(num int, time string) ([]spotify.FullTrack, error) {
	if num < minRequestTracks || num > maxRequestTracks {
		return nil, errNumRange
	}

	opt := &spotify.Options{Limit: &num, Timerange: &time}
	switch time {
	case "short":
		if sc.topTracksShort != nil {
			return sc.topTracksShort, nil
		}

		top, err := sc.c.CurrentUsersTopTracksOpt(opt)
		sc.requests++
		if err != nil {
			return nil, err
		}

		sc.topTracksShort = top.Tracks
		return top.Tracks, nil
	case "medium":
		if sc.topTracksMed != nil {
			return sc.topTracksMed, nil
		}

		top, err := sc.c.CurrentUsersTopTracksOpt(opt)
		sc.requests++
		if err != nil {
			return nil, err
		}

		sc.topTracksMed = top.Tracks
		return top.Tracks, nil
	case "long":
		if sc.topTracksLong != nil {
			return sc.topTracksLong, nil
		}

		top, err := sc.c.CurrentUsersTopTracksOpt(opt)
		sc.requests++
		if err != nil {
			return nil, err
		}

		sc.topTracksLong = top.Tracks
		return top.Tracks, nil
	default:
		return nil, errTimeInvalid
	}
}

// RecentTracks returns a list of the num most recently played tracks for the
// current user.
func (sc *spotClient) RecentTracks(num int) ([]spotify.SimpleTrack, error) {
	if num < minRequestTracks || num > maxRequestTracks {
		return nil, errNumRange
	}

	if sc.recentTracks != nil {
		return sc.recentTracks, nil
	}

	recent, err := sc.c.PlayerRecentlyPlayedOpt(&spotify.RecentlyPlayedOptions{Limit: num})
	sc.requests++
	if err != nil {
		return nil, err
	}
	if len(recent) == 0 {
		return nil, errRecentTracksMissing
	}

	tracks := make([]spotify.SimpleTrack, 0)
	for _, t := range recent {
		tracks = append(tracks, t.Track)
	}

	sc.recentTracks = tracks

	return tracks, nil
}

// RecentArtists returns a list of the most recently played artists for the
// current user.
func (sc *spotClient) RecentArtists(num int) ([]spotify.FullArtist, error) {
	if num < minRequestArtists || num > maxRequestArtists {
		return nil, errNumRange
	}

	if sc.recentArtists != nil {
		return sc.recentArtists, nil
	}

	tracks, err := sc.RecentTracks(num)
	sc.requests++
	if err != nil {
		return nil, err
	}

	IDs := extractArtistIDs(tracks)
	artists, err := sc.c.GetArtists(IDs...)
	sc.requests++
	if err != nil {
		return nil, err
	}

	for _, a := range artists {
		sc.recentArtists = append(sc.recentArtists, *a)
	}

	return sc.recentArtists, nil
}

// Recommendation returns a list of num recommended tracks generated using the
// provided seeds for the current user.
func (sc *spotClient) Recommendation(sd spotify.Seeds, num int) ([]spotify.SimpleTrack, error) {
	if num < minRecommendations || num > maxRecommendations {
		return nil, errNumRange
	}

	attr := spotify.NewTrackAttributes().TargetPopularity(targetPopularity).MaxPopularity(maxPopularity)
	opt := &spotify.Options{Limit: &num}
	recs, err := sc.c.GetRecommendations(sd, attr, opt)
	sc.requests++
	if err != nil {
		return nil, err
	}

	return recs.Tracks, nil
}

// Playlist creates and returns a playlist with the provided name and track IDs
// for the current user.
func (sc *spotClient) Playlist(name string, IDs []spotify.ID) (*spotify.FullPlaylist, error) {
	if len(IDs) < minPlaylistTracks {
		return nil, errPlaylistTracksMissing
	}

	u, err := sc.User()
	if err != nil {
		return nil, err
	}

	pl, err := sc.c.CreatePlaylistForUser(u.ID, name, publicPlaylist)
	sc.requests++
	if err != nil {
		return nil, err
	}

	_, err = sc.c.AddTracksToPlaylist(u.ID, pl.ID, IDs...)
	sc.requests++
	if err != nil {
		return nil, err
	}

	log.Println("Requests: ", sc.requests)
	return pl, nil
}
