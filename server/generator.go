package main

import (
	"log"
	"math"

	"github.com/pkg/errors"

	"github.com/zmb3/spotify"
)

const (
	playlistSize          = 20
	maxRequestTracks      = 50
	minRequestTracks      = 1
	maxRequestArtists     = 50
	minRecommendations    = 1
	maxRecommendations    = 100
	requiredRecentTracks  = 30
	requiredRecentArtists = 30
	requiredTopArtists    = 30
	requiredTopTracks     = 30
	publicPlaylist        = true
	recRetryLimit         = 2
	playlistName          = "Discover Now"
)

var (
	errRecentTracksUnavailable   = errors.New("cannot retrieve recent tracks")
	errRecentTracksInsufficient  = errors.New("insufficient recent track data")
	errRecentArtistsInsufficient = errors.New("insufficient recent artists data")
	errTopArtistsInsufficient    = errors.New("insufficient top artist data")
	errCannotCreatePlaylist      = errors.New("cannot create any relevant playlist")
	errTopTracksInsufficient     = errors.New("insufficient top track data")
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
	pl, err := g.TrackDiscover()
	if err == nil {
		log.Println("MostRelevantPlaylist: TrackDiscover")
		return pl, nil
	}

	pl, err = g.ArtistDiscover()
	if err == nil {
		log.Println("MostRelevantPlaylist: ArtistDiscover")
		return pl, nil
	}

	pl, err = g.TrackSummary("short")
	if err == nil {
		log.Println("MostRelevantPlaylist: Track Summary - Short")
		return pl, nil
	}

	pl, err = g.ArtistSummary("short")
	if err == nil {
		log.Println("MostRelevantPlaylist: Artist Summary - Short")
		return pl, nil
	}

	pl, err = g.ArtistSummary("medium")
	if err == nil {
		log.Println("MostRelevantPlaylist: Artist Summary - Medium")
		return pl, nil
	}

	pl, err = g.ArtistSummary("long")
	if err == nil {
		log.Println("MostRelevantPlaylist: Artist Summary - Long")
		return pl, nil
	}

	return nil, errCannotCreatePlaylist
}

// TrackDiscover returns a playlist based on the analysis of a user's recently
// played tracks.
func (g *generator) TrackDiscover() (*spotify.FullPlaylist, error) {
	// fmt.Println("Starting TrackDiscover")
	rt, err := g.c.RecentTracks(maxRequestTracks)
	if err != nil {
		return nil, errRecentTracksUnavailable
	}
	if len(rt) < requiredRecentTracks {
		return nil, errRecentTracksInsufficient
	}

	recs, err := g.recsByTrack(rt)
	if err != nil {
		return nil, errors.WithMessage(err, "discoverTracks: cannot retrieve recommendations")
	}

	name := playlistName
	IDs := extractTrackIDs(recs)
	pl, err := g.c.Playlist(name, IDs)
	if err != nil {
		return nil, errors.WithMessage(err, "trackDiscover: cannot create playlist")
	}

	log.Println("TrackDiscover finished.")
	return pl, nil
}

// ArtistDiscover creates a playlist for the current user based on the analysis
// of the user's recently played artists.
func (g *generator) ArtistDiscover() (*spotify.FullPlaylist, error) {
	// fmt.Println("Starting ArtistDiscover")
	artists, err := g.c.RecentArtists(maxRequestArtists)
	if err != nil {
		return nil, err
	}

	if len(artists) < requiredRecentArtists {
		return nil, errRecentArtistsInsufficient
	}

	genres, err := extractGenres(artists)
	if err != nil {
		return nil, err
	}

	recs, err := g.recsByGenre(genres)
	if err != nil {
		return nil, err
	}

	IDs := extractTrackIDs(shuffleTracks(recs))
	pl, err := g.c.Playlist(playlistName, IDs)
	if err != nil {
		return nil, errors.WithMessage(err, "ArtistDiscover: cannot create playlist")
	}

	log.Println("ArtistDiscover complete.")
	return pl, nil
}

func (g *generator) TrackSummary(time string) (*spotify.FullPlaylist, error) {
	// fmt.Println("Starting TrackSummary - ", time)
	top, err := g.c.TopTracks(maxRequestTracks, time)
	if err != nil {
		return nil, err
	}

	if len(top) < requiredTopTracks {
		return nil, errTopTracksInsufficient
	}

	recs, err := g.recsByTrack(simpleToFull(top...))
	if err != nil {
		return nil, err
	}

	IDs := extractTrackIDs(shuffleTracks(recs))
	pl, err := g.c.Playlist(playlistName, IDs)
	if err != nil {
		return nil, err
	}

	log.Println("Track Summary completed.")

	return pl, nil
}

// ArtistSummary returns a playlist based on the analysis of a user's taste profile.
func (g *generator) ArtistSummary(time string) (*spotify.FullPlaylist, error) {
	// fmt.Println("Starting ArtistSummary - ", time)
	ta, err := g.c.TopArtists(requiredTopArtists, time)
	if err != nil {
		return nil, err
	}

	if len(ta) < requiredTopArtists {
		return nil, errTopArtistsInsufficient
	}

	genres, err := extractGenres(ta)
	if err != nil {
		return nil, err
	}

	recs, err := g.recsByGenre(genres)
	if err != nil {
		return nil, err
	}

	IDs := extractTrackIDs(shuffleTracks(recs))
	pl, err := g.c.Playlist(playlistName, IDs)
	if err != nil {
		return nil, err
	}

	log.Println("Artist Summary completed.")
	return pl, nil
}

// discoverTracks returns a list of tracks based on the analysis of the logged
// in user's recently played tracks.
func (g *generator) discoverTracks() ([]spotify.SimpleTrack, error) {
	rt, err := g.c.RecentTracks(maxRequestTracks)
	if err != nil {
		return nil, errRecentTracksUnavailable
	}
	if len(rt) < requiredRecentTracks {
		return nil, errRecentTracksInsufficient
	}

	recs, err := g.recsByTrack(rt)
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

// recsByGenre returns a list of about 20 tracks recommended based on the
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

	for _, gen := range gens {
		for n := range gen.artists {
			g.invalidateArtist(n)
		}
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

func (g *generator) recsByTrack(tracks []spotify.SimpleTrack) ([]spotify.SimpleTrack, error) {
	sds := trackSeeds(shuffleTracks(tracks))

	ta, err := g.c.TopArtistsVar(maxRequestArtists, "short", "medium", "long")
	if err != nil {
		return nil, errors.WithMessage(err, "recsByTrack: cannot retrieve all top artists")
	}

	for _, a := range ta {
		g.invalidateArtist(a.Name)
	}
	// log.Println(len(g.invalidArtists))

	recs := make([]spotify.SimpleTrack, 0)
	num := playlistSize / len(sds)
	for _, sd := range sds {
		rec, err := g.Recommendations(num, sd)
		if err != nil {
			return nil, errors.WithMessage(err, "recsByTrack: cannot get recommendation with a track seed")
		}
		recs = append(recs, rec...)
		// log.Println(len(g.invalidArtists))
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
