package main

import (
	"fmt"
	"log"
	"math"
	"strconv"

	"github.com/davecgh/go-spew/spew"
	"github.com/pkg/errors"

	"github.com/zmb3/spotify"
)

const (
	playlistSize         = 30
	maxRequestTracks     = 50
	minRequestTracks     = 1
	maxRequestArtists    = 50
	minRecommendations   = 1
	maxRecommendations   = 100
	requiredRecentTracks = 30
	requiredTopArtists   = 30
	publicPlaylist       = true
	recRetryLimit        = 2
)

var (
	errRetrieveRecent           = errors.New("cannot retrieve recent tracks")
	errInsufficientRecentTracks = errors.New("insufficient recent track data")
	errInsufficientTopArtists   = errors.New("insufficient top artist data")
	errCannotCreatePlaylist     = errors.New("cannot create any relevant playlist")
)

type generator struct {
	c              *spotClient
	invalidArtists map[string]bool
}

func newGenerator(client clienter) *generator {
	return &generator{
		c:              &spotClient{c: client},
		invalidArtists: make(map[string]bool),
	}
}

func (g *generator) MostRelevantPlaylist() (*spotify.FullPlaylist, error) {
	pl, err := g.Discover()
	if err == nil || err == errInsufficientRecentTracks {
		log.Println("MostRelevantPlaylist: Discover")
		return pl, nil
	}

	// pl, err := g.GenreDiscover()
	// if err == nil {
	// 	log.Println("MostRelevantPlaylist: Genre Discover")
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
	ta, err := g.c.TopArtists(maxArtists, time)
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
	pl, err := g.c.Playlist(name, IDs)
	if err != nil {
		return nil, err
	}

	log.Println("Taste Summary finished.")
	return pl, nil
}

func (g *generator) GenreDiscover() (*spotify.FullPlaylist, error) {
	fmt.Println("Starting GenreDiscover")
	artists, err := g.c.RecentArtists()
	if err != nil {
		return nil, err
	}

	genres, err := extractGenres(artists)
	if err != nil {
		return nil, err
	}
	sps := spew.ConfigState{SortKeys: true, MaxDepth: 3}
	sps.Dump(genres)

	recs, err := g.recsByGenre(genres)
	if err != nil {
		return nil, err
	}

	IDs := extractTrackIDs(shuffleTracks(recs))
	pl, err := g.c.Playlist("Genre Discover", IDs)
	if err != nil {
		return nil, errors.WithMessage(err, "GenreDiscover: cannot create playlist")
	}

	log.Println("GenreDiscover complete.")
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
	pl, err := g.c.Playlist(name, IDs)
	if err != nil {
		return nil, errors.WithMessage(err, "discover: cannot create playlist")
	}

	log.Println("Discover finished.")
	return pl, nil
}

// discoverTracks returns a list of tracks based on the analysis of the logged
// in user's recently played tracks.
func (g *generator) discoverTracks() ([]spotify.SimpleTrack, error) {
	rt, err := g.c.RecentTracks(maxRequestTracks)
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

func (g *generator) Recommendations(num int, sd spotify.Seeds) ([]spotify.SimpleTrack, error) {
	log.Println("Starting newRec")
	uniq := make([]spotify.SimpleTrack, 0)

	buf := boundedInt(num*3, maxRecommendations)

	recs, err := g.c.Recommendation(sd, buf)
	if err != nil {
		return nil, err
	}

	i := 0
	for _, r := range recs {
		if i >= num {
			break
		}
		if g.isValidArtist(r.Artists[0].Name) {
			uniq = append(uniq, r)
			g.invalidateArtist(r.Artists[0].Name)
			i++
		}
	}

	return uniq, nil
}

// recsByGenre returns a list of about 30 tracks recommended based on the
// provided genres.
func (g *generator) recsByGenre(gens []*genre) ([]spotify.SimpleTrack, error) {
	sum := sumScore(gens)

	ta, err := g.c.TopArtistsVar(maxRequestArtists, "short", "medium", "long")
	if err != nil {
		return nil, err
	}

	for _, a := range ta {
		g.invalidateArtist(a.Name)
	}

	recs := make([]spotify.SimpleTrack, 0)
	for _, gen := range gens {
		ratio := float64(gen.score()) / float64(sum)
		tracks := ratio * playlistSize
		num := math.Ceil(tracks)

		rec, err := g.Recommendations(int(num), gen.seed())
		if err != nil {
			return nil, errors.WithMessage(err, "recsByGenre: cannot retrieve a recommendation")
		}
		recs = append(recs, rec...)
	}

	return recs, nil
}

func (g *generator) recsByTrack(tracks []spotify.SimpleTrack, attr *spotify.TrackAttributes) ([]spotify.SimpleTrack, error) {
	sds := trackSeeds(shuffleTracks(tracks))

	ta, err := g.c.TopArtistsVar(maxRequestArtists, "short", "medium", "long")
	if err != nil {
		return nil, errors.WithMessage(err, "recsByTrack: cannot retrieve all top artists")
	}

	for _, a := range ta {
		g.invalidateArtist(a.Name)
	}
	log.Println(len(g.invalidArtists))

	recs := make([]spotify.SimpleTrack, 0)
	num := playlistSize / len(sds)
	for _, sd := range sds {
		rec, err := g.Recommendations(num, sd)
		if err != nil {
			return nil, errors.WithMessage(err, "recsByTrack: cannot get recommendation with a track seed")
		}
		recs = append(recs, rec...)
		log.Println(len(g.invalidArtists))
	}

	return recs, nil
}

func (g *generator) invalidateArtists(artists ...string) {
	for _, a := range artists {
		g.invalidateArtist(a)
	}
	return
}

func (g *generator) invalidateArtist(a string) {
	g.invalidArtists[a] = true
	return
}

func (g *generator) isValidArtist(a string) bool {
	ok := g.invalidArtists[a]
	return !ok
}
