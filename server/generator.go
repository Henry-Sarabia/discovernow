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
	requiredTopArtists   = 30
	publicPlaylist       = true
	targetPopularity     = 40
	recRetryLimit        = 2
)

var (
	errRetrieveRecent           = errors.New("cannot retrieve recent tracks")
	errInsufficientRecentTracks = errors.New("insufficient recent track data")
	errInsufficientTopArtists   = errors.New("insufficient top artist data")
	errCannotCreatePlaylist     = errors.New("cannot create any relevant playlist")
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

func (g *generator) MostRelevantPlaylist() (*spotify.FullPlaylist, error) {
	pl, err := g.Discover()
	if err == nil || err == errInsufficientRecentTracks {
		log.Println("MostRelevantPlaylist: Discover")
		return pl, nil
	}

	// pl, err := g.UniqueDiscover()
	// if err == nil {
	// 	log.Println("MostRelevantPlaylist: Unique Discover")
	// 	return pl, nil
	// }
	// if err != nil {
	// 	log.Println(err)
	// 	return nil, err
	// }

	pl, err = g.TasteSummary("short")
	if err == nil || err == errInsufficientTopArtists {
		log.Println("MostRelevantPlaylist: Short Summary")
		return pl, nil
	}

	pl, err = g.TasteSummary("medium")
	if err == nil || err == errInsufficientTopArtists {
		log.Println("MostRelevantPlaylist: Medium Summary")
		return pl, nil
	}

	pl, err = g.TasteSummary("long")
	if err == nil || err == errInsufficientTopArtists {
		log.Println("MostRelevantPlaylist: Long Summary")
		return pl, nil
	}

	return nil, errCannotCreatePlaylist
}

// TasteSummary returns a playlist based on the analysis of a user's taste profile.
func (g *generator) TasteSummary(time string) (*spotify.FullPlaylist, error) {
	fmt.Println("Starting Taste")
	ta, err := g.topArtists(maxArtists, time)
	if err != nil {
		return nil, err
	}

	if len(ta) < requiredTopArtists {
		return nil, errInsufficientTopArtists
	}

	genres, err := extractGenres(ta)
	if err != nil {
		return nil, err
	}

	recs, err := g.recsByGenre(genres)
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

// func (g *generator) UniqueDiscover() (*spotify.FullPlaylist, error) {
// 	fmt.Println("Starting Unique Discover")

// 	tas, err := g.topArtists(maxArtists, "short")
// 	if err != nil {
// 		return nil, err
// 	}

// 	if len(tas) < requiredTopArtists {
// 		return nil, errInsufficientTopArtists
// 	}

// 	genres, err := extractGenres(tas)
// 	if err != nil {
// 		return nil, err
// 	}

// 	est, err := g.establishedTopArtists()
// 	if err != nil {
// 		return nil, err
// 	}

// 	visited := visitedArtists(all, nil)
// 	attr := spotify.NewTrackAttributes().TargetPopularity(targetPopularity)

// 	recs, err := g.uniqueRecsByGenre(genres, attr, visited)
// 	if err != nil {
// 		return nil, err
// 	}

// 	name := "Unique Discover Now - Popularity " + strconv.Itoa(targetPopularity)
// 	IDs := extractTrackIDs(recs)
// 	pl, err := g.playlist(name, IDs)
// 	if err != nil {
// 		return nil, errors.WithMessage(err, "discover: cannot create playlist")
// 	}

// 	log.Println("Unique Discover finished.")
// 	return pl, nil
// }

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
		// return nil, errors.WithMessage(err, "discoverTracks: cannot retrieve recent tracks")
		return nil, errRetrieveRecent
	}
	if len(rt) < requiredRecentTracks {
		return nil, errInsufficientRecentTracks
	}

	attr := spotify.NewTrackAttributes().TargetPopularity(targetPopularity)
	recs, err := g.recsByTrack(rt, attr)
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

// uniqueRec returns a list of recommended tracks omitting any
// which have any of the provided artists.
func (g *generator) uniqueRec(sd spotify.Seeds, num int, attr *spotify.TrackAttributes, visited map[string]bool) ([]spotify.SimpleTrack, error) {
	log.Println("starting unique rec")
	if num < minRequestTracks || num > maxRequestArtists {
		return nil, fmt.Errorf("uniqueRec: invalid input of %d, expecting input between %d and %d", num, minRequestTracks, maxRequestTracks)
	}
	uniq := make([]spotify.SimpleTrack, 0)

	for i := 0; len(uniq) < num; {
		log.Println("starting unique loop")
		if i > recRetryLimit {
			break
		}

		// request extra tracks in case of duplicates
		// getBuf

		rec, err := g.recommendation(sd, num, attr)
		if err != nil {
			return nil, err
		}

		// appendRec
		for _, r := range rec {
			if ok := visited[r.Artists[0].Name]; !ok {
				uniq = append(uniq, r)
			}
			visited[r.Artists[0].Name] = true
		}
	}

	return uniq, nil
}

// recsByGenre returns a list of about 30 tracks recommended based on the
// provided genres.
func (g *generator) recsByGenre(gens []*genre) ([]spotify.SimpleTrack, error) {
	sum := sumScore(gens)

	recs := make([]spotify.SimpleTrack, 0)
	for _, gen := range gens {
		ratio := float64(gen.score()) / float64(sum)
		tracks := ratio * playlistSize
		num := math.Ceil(tracks)

		rec, err := g.recommendation(gen.seed(), int(num), nil)
		if err != nil {
			return nil, errors.WithMessage(err, "recsByGenre: cannot retrieve a recommendation")
		}
		recs = append(recs, rec...)
	}

	return recs, nil
}

// func (g *generator) uniqueRecsByGenre(gens []*genre, attr *spotify.TrackAttributes, visited map[string]bool) ([]spotify.SimpleTrack, error) {
// 	sum := sumScore(gens)
// 	log.Println("original visited: ", len(visited))

// 	recs := make([]spotify.SimpleTrack, 0)
// 	for _, gen := range gens {
// 		log.Println("starting loop")
// 		ratio := float64(gen.score()) / float64(sum)
// 		tracks := ratio * playlistSize
// 		num := math.Ceil(tracks)

// 		rec, err := g.uniqueRec(gen.seed(), int(num), attr, visited)
// 		if err != nil {
// 			return nil, errors.WithMessage(err, "uniqueRecsByGenre: cannot get recommendation with a track seed")
// 		}
// 		recs = append(recs, rec...)
// 		log.Println("edited visited:", len(visited))
// 	}

// 	return recs, nil
// }

// recsByTrack returns a list of about 30 tracks recommended based
// on the provided tracks.
func (g *generator) recsByTrack(tracks []spotify.SimpleTrack, attr *spotify.TrackAttributes) ([]spotify.SimpleTrack, error) {
	sds := trackSeeds(shuffleTracks(tracks))

	ta, err := g.allTopArtists()
	if err != nil {
		return nil, errors.WithMessage(err, "recsByTrack: cannot retrieve all top artists")
	}

	visited := visitedArtists(ta, tracks)
	log.Println(len(visited))

	recs := make([]spotify.SimpleTrack, 0)
	num := playlistSize / len(sds)
	for _, sd := range sds {
		rec, err := g.uniqueRec(sd, num, attr, visited)
		if err != nil {
			return nil, errors.WithMessage(err, "recsByTrack: cannot get recommendation with a track seed")
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
