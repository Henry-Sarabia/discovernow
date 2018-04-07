package main

import (
	"fmt"
	"log"
	"math"
	"math/rand"
	"strconv"
	"time"

	"github.com/pkg/errors"

	"github.com/zmb3/spotify"
)

const (
	playlistSize         = 30
	maxRequestTracks     = 50
	minRequestTracks     = 1
	maxRequestArtists    = 50
	requiredRecentTracks = 30
	publicPlaylist       = true
	targetPopularity     = 40
	recRetryLimit        = 2
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
	fmt.Println("Starting Taste")
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
	fmt.Println("Starting Discover")
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
		return nil, errors.WithMessage(err, "discoverTracks: cannot retrieve recent tracks")
	}
	if len(rt) < requiredRecentTracks {
		return nil, errors.New("discoverTracks: insufficient recent tracks")
	}

	attr := spotify.NewTrackAttributes().TargetPopularity(targetPopularity)
	recs, err := g.recommendationsByTracks(rt, attr)
	if err != nil {
		return nil, errors.WithMessage(err, "discoverTracks: cannot retrieve recommendations")
	}

	return recs, nil
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

// uniqueRecommendation returns a list of recommended tracks omitting any
// which have any of the provided artists.
func (g *generator) uniqueRecommendations(sd spotify.Seeds, num int, attr *spotify.TrackAttributes, visited map[string]bool) ([]spotify.SimpleTrack, error) {
	if num < minRequestTracks || num > maxRequestArtists {
		return nil, fmt.Errorf("uniqueRecommendations: invalid input of %d, expecting input between %d and %d", num, minRequestTracks, maxRequestTracks)
	}
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
			return nil, errors.WithMessage(err, "recommendationsByGenres: cannot retrieve a recommendation")
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
		return nil, errors.WithMessage(err, "recommendationsByTracks: cannot retrieve all top artists")
	}

	visited := visitedArtists(ta, tracks)
	log.Println(len(visited))

	recs := make([]spotify.SimpleTrack, 0)
	num := playlistSize / len(sds)
	for _, sd := range sds {
		rec, err := g.uniqueRecommendations(sd, num, attr, visited)
		if err != nil {
			return nil, errors.WithMessage(err, "recommendationsByTracks: cannot get recommendation with a track seed")
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
		return "Discover - Recent Weeks"
	case "medium":
		return "Discover - Recent Months"
	case "long":
		return "Discover - Recent Years"
	default:
		return "Discover Now Playlist"
	}
}
