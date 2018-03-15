package main

import (
	"log"
	"math"
	"math/rand"
	"time"

	"github.com/davecgh/go-spew/spew"
	"github.com/pkg/errors"

	"github.com/zmb3/spotify"
)

const (
	playlistSize     = 30
	maxRequestTracks = 50
	publicPlaylist   = true
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

type generator struct {
	client clienter
}

// TasteSummary returns a playlist based on the analysis of a user's taste profile.
func (g *generator) TasteSummary(time string) (*spotify.FullPlaylist, error) {
	ta, err := g.topArtists(maxArtists, time)
	if err != nil {
		return nil, err
	}

	gm, err := extractGenres(ta)
	if err != nil {
		return nil, err
	}

	gens, err := processGenres(gm)
	if err != nil {
		return nil, err
	}

	recs, err := g.recommendationsByGenres(gens)
	if err != nil {
		return nil, err
	}

	name := playlistName(time)
	pl, err := g.playlist(name, shuffleTracks(recs))
	if err != nil {
		return nil, err
	}

	log.Println("Taste Summary finished.")
	return pl, nil
}

// Discover returns a playlist based on the analysis of a user's recently
// played tracks.
func (g *generator) Discover() (*spotify.FullPlaylist, error) {
	rt, err := g.recentTracks(maxRequestTracks)
	if err != nil {
		return nil, errors.WithMessage(err, "discover: requires recent tracks")
	}

	recs, err := g.recommendationsByTracks(rt)
	if err != nil {
		return nil, errors.WithMessage(err, "discover: requires recommendations")
	}

	pl, err := g.playlist("MyFy - Discover Now", recs)
	if err != nil {
		return nil, errors.WithMessage(err, "discover: cannot create playlist")
	}

	log.Println("Discover finished.")
	return pl, nil
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

	return top, nil
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
	scs := spew.ConfigState{SortKeys: true, MaxDepth: 2}
	scs.Dump(rp)

	tracks := make([]spotify.SimpleTrack, 0)
	for _, t := range rp {
		tracks = append(tracks, t.Track)
	}

	return tracks, nil
}

// recommendation returns a list of recommended tracks based on the given
// seed.
func (g *generator) recommendation(sd spotify.Seeds, num int) ([]spotify.SimpleTrack, error) {
	attr := spotify.NewTrackAttributes()

	opt := &spotify.Options{Limit: &num}
	rec, err := g.client.GetRecommendations(sd, attr, opt)
	if err != nil {
		return nil, err
	}

	return rec.Tracks, nil
}

// recommendationsByGenre returns a list of about 30 tracks recommended based on the
// provided genres.
func (g *generator) recommendationsByGenres(gens []*genre) ([]spotify.SimpleTrack, error) {
	sum := sumScore(gens)

	recs := make([]spotify.SimpleTrack, 0)
	for _, gen := range gens {
		ratio := float64(gen.score()) / float64(sum)
		tracks := ratio * playlistSize
		num := math.Ceil(tracks)

		rec, err := g.recommendation(gen.seed(), int(num))
		if err != nil {
			return nil, errors.WithMessage(err, "cannot get recommendation with a genre seed")
		}
		recs = append(recs, rec...)
	}

	return recs, nil
}

// recommendationsByTracks returns a list of about 30 tracks recommended based
// on the provided tracks.
func (g *generator) recommendationsByTracks(tracks []spotify.SimpleTrack) ([]spotify.SimpleTrack, error) {
	sds := trackSeeds(shuffleTracks(tracks))

	recs := make([]spotify.SimpleTrack, 0)
	num := playlistSize / len(sds)
	for _, sd := range sds {
		rec, err := g.recommendation(sd, num)
		if err != nil {
			return nil, errors.WithMessage(err, "cannot get recommendation with a track seed")
		}
		recs = append(recs, rec...)
	}

	return recs, nil
}

// playlist creates and returns a playlist with the provided name and
// tracks for the user.
func (g *generator) playlist(name string, tracks []spotify.SimpleTrack) (*spotify.FullPlaylist, error) {
	u, err := g.client.CurrentUser()
	if err != nil {
		return nil, err
	}

	pl, err := g.client.CreatePlaylistForUser(u.ID, name, publicPlaylist)
	if err != nil {
		return nil, err
	}

	IDs := extractIDs(tracks)
	_, err = g.client.AddTracksToPlaylist(u.ID, pl.ID, IDs...)
	if err != nil {
		return nil, err
	}

	return pl, nil
}

// shuffleTracks returns returns a shuffled list of the provided tracks.
func shuffleTracks(old []spotify.SimpleTrack) []spotify.SimpleTrack {
	r := rand.New(rand.NewSource(time.Now().Unix()))
	new := make([]spotify.SimpleTrack, len(old))
	p := r.Perm(len(old))
	for i, j := range p {
		new[i] = old[j]
	}
	return new

}

// extractIDs returns a list of IDs corresponding to the provided tracks.
func extractIDs(tracks []spotify.SimpleTrack) []spotify.ID {
	IDs := make([]spotify.ID, 0)
	for _, t := range tracks {
		IDs = append(IDs, t.ID)
	}

	return IDs
}

// trackSeed returns a seed using up to 5 of the provided tracks.
func trackSeed(tracks []spotify.SimpleTrack) spotify.Seeds {
	sd := spotify.Seeds{}

	for _, t := range tracks {
		if len(sd.Tracks) > maxSeedInput {
			break
		}
		sd.Tracks = append(sd.Tracks, t.ID)
	}

	return sd
}

// trackSeeds returns a list of seeds using up to 5 of the provided tracks per
// seed.
func trackSeeds(tracks []spotify.SimpleTrack) []spotify.Seeds {
	// tracks = shuffleTracks(tracks)
	sds := make([]spotify.Seeds, 0)

	i := 0
	for i <= len(tracks)-maxSeedInput {
		sds = append(sds, trackSeed(tracks[i:i+maxSeedInput]))
		i += maxSeedInput
	}
	if i < len(tracks) {
		sds = append(sds, trackSeed(tracks[i:len(tracks)]))
	}

	return sds
}

// playlistName returns the name to be given to a playlist based on the
// provided time range.
func playlistName(t string) string {
	switch t {
	case "short":
		return "MyFy - Recent Weeks"
	case "medium":
		return "MyFy - Recent Months"
	case "long":
		return "MyFy - Recent Years"
	default:
		return "MyFy Playlist"
	}
}
