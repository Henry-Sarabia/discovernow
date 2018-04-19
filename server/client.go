package main

import (
	"errors"

	"github.com/zmb3/spotify"
)

var (
	errRecentTracksMissing = errors.New("recentTracks: there are no recent tracks to return")
	errTopArtistsMissing   = errors.New("topArtists: there are no top artists to return")
	errNumRange            = errors.New("input should be between 1 and 50")
	errTimeMissing         = errors.New("TopArtistsVar: missing time range")
	errTimeInvalid         = errors.New("TopArtists: invalid time range")
)

// clienter is implemented by any type that has certain Spotify functions.
// Helpful for testing purposes.
type clienter interface {
	CurrentUser() (*spotify.PrivateUser, error)
	CurrentUsersTopArtistsOpt(*spotify.Options) (*spotify.FullArtistPage, error)
	PlayerRecentlyPlayedOpt(*spotify.RecentlyPlayedOptions) ([]spotify.RecentlyPlayedItem, error)
	GetRecommendations(spotify.Seeds, *spotify.TrackAttributes, *spotify.Options) (*spotify.Recommendations, error)
	CreatePlaylistForUser(string, string, bool) (*spotify.FullPlaylist, error)
	AddTracksToPlaylist(string, spotify.ID, ...spotify.ID) (string, error)
}

type spotClient struct {
	c               clienter
	user            *spotify.PrivateUser
	topArtistsShort []spotify.FullArtist
	topArtistsMed   []spotify.FullArtist
	topArtistsLong  []spotify.FullArtist
	recentTracks    []spotify.SimpleTrack
}

// User returns the currently logged in Spotify user.
func (sc *spotClient) User() (*spotify.PrivateUser, error) {
	if sc.user != nil {
		return sc.user, nil
	}

	u, err := sc.c.CurrentUser()
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
		return nil, errors.New("TopArtists: missing time range")
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
	opt := &spotify.Options{Limit: &num, Timerange: &time}
	switch time {
	case "short":
		if sc.topArtistsShort != nil {
			return sc.topArtistsShort, nil
		}

		top, err := sc.c.CurrentUsersTopArtistsOpt(opt)
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
		if err != nil {
			return nil, err
		}

		sc.topArtistsLong = top.Artists
		return top.Artists, nil

	default:
		return nil, errors.New("TopArtists: invalid time range")
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

// Recommendation returns a list of num recommended tracks generated using the
// provided seeds for the current user.
func (sc *spotClient) Recommendation(sd spotify.Seeds, num int) ([]spotify.SimpleTrack, error) {
	if num < minRequestTracks || num > maxRequestArtists {
		return nil, errNumRange
	}

	attr := spotify.NewTrackAttributes().TargetPopularity(targetPopularity)
	opt := &spotify.Options{Limit: &num}
	recs, err := sc.c.GetRecommendations(sd, attr, opt)
	if err != nil {
		return nil, err
	}

	return recs.Tracks, nil
}

// Playlist creates and returns a playlist with the provided name and track IDs
// for the current user.
func (sc *spotClient) Playlist(name string, IDs []spotify.ID) (*spotify.FullPlaylist, error) {
	u, err := sc.User()
	if err != nil {
		return nil, err
	}

	pl, err := sc.c.CreatePlaylistForUser(u.ID, name, publicPlaylist)
	if err != nil {
		return nil, err
	}

	_, err = sc.c.AddTracksToPlaylist(u.ID, pl.ID, IDs...)
	if err != nil {
		return nil, err
	}

	return pl, nil
}
