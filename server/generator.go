package main

import (
	"log"
	"math"
	"math/rand"
	"strconv"
	"time"

	"github.com/pkg/errors"

	"github.com/zmb3/spotify"
)

const (
	playlistSize      = 30
	maxRequestTracks  = 50
	maxRequestArtists = 50
	publicPlaylist    = true
	targetPopularity  = 40
	recRetryLimit     = 3
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
	IDs := extractTrackIDs(shuffleTracks(recs))
	pl, err := g.playlist(name, IDs)
	if err != nil {
		return nil, err
	}

	log.Println("Taste Summary finished.")
	return pl, nil
}

// Discover returns a playlist based on the analysis of a user's recently
// played tracks.
func (g *generator) Discover() (*spotify.FullPlaylist, error) {
	tracks, err := g.discoverTracks()
	if err != nil {
		return nil, err
	}

	name := "Discover Now - Popularity " + strconv.Itoa(targetPopularity)
	IDs := extractTrackIDs(tracks)
	pl, err := g.playlist(name, IDs)
	if err != nil {
		return nil, errors.WithMessage(err, "discover: cannot create playlist")
	}

	log.Println("Discover finished.")
	return pl, nil
}

// discoverTracks returns a list of tracks based on the analysis of the logged
// in user's recently played tracks.
func (g *generator) discoverTracks() ([]spotify.SimpleTrack, error) {
	rt, err := g.recentTracks(maxRequestTracks)
	if err != nil {
		return nil, errors.WithMessage(err, "discover: requires recent tracks")
	}

	attr := spotify.NewTrackAttributes().TargetPopularity(targetPopularity)

	recs, err := g.recommendationsByTracks(rt, attr)
	if err != nil {
		return nil, errors.WithMessage(err, "discover: requires recommendations")
	}

	return recs, nil
}

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

// removeDuplicateArtists returns a list with only unique artists.
func removeDuplicateArtists(old []spotify.FullArtist) []spotify.FullArtist {
	visited := make(map[string]bool)
	new := make([]spotify.FullArtist, 0)
	for _, a := range old {
		if ok := visited[a.Name]; !ok {
			visited[a.Name] = true
			new = append(new, a)
		}
	}
	return new
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

	tracks := make([]spotify.SimpleTrack, 0)
	for _, t := range rp {
		tracks = append(tracks, t.Track)
	}

	return tracks, nil
}

// recommendation returns a list of recommended tracks based on the given
// seed.
func (g *generator) recommendation(sd spotify.Seeds, num int, attr *spotify.TrackAttributes) ([]spotify.SimpleTrack, error) {
	opt := &spotify.Options{Limit: &num}
	rec, err := g.client.GetRecommendations(sd, attr, opt)
	if err != nil {
		return nil, err
	}

	return rec.Tracks, nil
}

// uniqueRecommendation returns a list of recommended tracks omitting any
// which have any of the provided artists.
func (g *generator) uniqueRecommendations(sd spotify.Seeds, num int, attr *spotify.TrackAttributes, visited map[string]bool) ([]spotify.SimpleTrack, error) {
	uniq := make([]spotify.SimpleTrack, 0)

	for i := 0; len(uniq) < num; {
		if i > recRetryLimit {
			break
		}
		rec, err := g.recommendation(sd, num, attr)
		if err != nil {
			return nil, err
		}

		for _, r := range rec {
			if ok := visited[r.Artists[0].Name]; !ok {
				uniq = append(uniq, r)
			}
			visited[r.Artists[0].Name] = true
		}
	}

	return uniq, nil
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

		rec, err := g.recommendation(gen.seed(), int(num), nil)
		if err != nil {
			return nil, errors.WithMessage(err, "cannot get recommendation with a genre seed")
		}
		recs = append(recs, rec...)
	}

	return recs, nil
}

// recommendationsByTracks returns a list of about 30 tracks recommended based
// on the provided tracks.
func (g *generator) recommendationsByTracks(tracks []spotify.SimpleTrack, attr *spotify.TrackAttributes) ([]spotify.SimpleTrack, error) {
	sds := trackSeeds(shuffleTracks(tracks))

	ta, err := g.allTopArtists()
	if err != nil {
		return nil, errors.WithMessage(err, "cannot retrieve all top artists")
	}

	visited := visitedArtists(ta, tracks)
	log.Println(len(visited))

	recs := make([]spotify.SimpleTrack, 0)
	num := playlistSize / len(sds)
	for _, sd := range sds {
		rec, err := g.uniqueRecommendations(sd, num, attr, visited)
		if err != nil {
			return nil, errors.WithMessage(err, "cannot get recommendation with a track seed")
		}
		recs = append(recs, rec...)
		log.Println(len(visited))
	}

	return recs, nil
}

// visitedArtists returns a map of artists marked as visited derived from the
// provided list of artists and the artists from the provided list of tracks.
func visitedArtists(arts []spotify.FullArtist, tracks []spotify.SimpleTrack) map[string]bool {
	visited := make(map[string]bool)
	for _, a := range arts {
		visited[a.Name] = true
	}
	for _, t := range tracks {
		visited[t.Artists[0].Name] = true
	}
	return visited
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

// extractTrackIDs returns a list of IDs corresponding to the provided tracks.
func extractTrackIDs(tracks []spotify.SimpleTrack) []spotify.ID {
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
