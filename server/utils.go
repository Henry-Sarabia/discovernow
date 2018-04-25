package main

import (
	"math/rand"
	"time"

	"github.com/zmb3/spotify"
)

// TODO: use type alias for simpleTrack, fullTrack to make ID method and accept interface instead
// func (t spotify.FullTrack) ID() spotify.ID {
// 	return t.ID
// }

// simpleToFull returns a list of simple tracks corresponding to the provided
// full tracks.
func simpleToFull(full ...spotify.FullTrack) []spotify.SimpleTrack {
	simple := make([]spotify.SimpleTrack, 0)
	for _, f := range full {
		new := spotify.SimpleTrack{
			Artists: f.Artists,
			ID:      f.ID,
			Name:    f.Name,
		}
		simple = append(simple, new)
	}
	return simple
}

func boundedInt(num int, max int) int {
	if num > max {
		return max
	}
	return num
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

// extractArtistIDs returns a list of IDs corresponding to the artists of the
// provided tracks.
func extractArtistIDs(tracks []spotify.SimpleTrack) []spotify.ID {
	IDs := make([]spotify.ID, 0)
	for _, t := range tracks {
		IDs = append(IDs, t.Artists[0].ID)
	}

	return IDs
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

func trackSeedNew(IDs []spotify.ID) spotify.Seeds {
	sd := spotify.Seeds{}

	for _, ID := range IDs {
		if len(sd.Tracks) > maxSeedInput {
			break
		}
		sd.Tracks = append(sd.Tracks, ID)
	}

	return sd
}

func trackSeedsNew(IDs []spotify.ID) []spotify.Seeds {
	sds := make([]spotify.Seeds, 0)

	i := 0
	for i <= len(IDs)-maxSeedInput {
		sds = append(sds, trackSeedNew(IDs[i:i+maxSeedInput]))
		i += maxSeedInput
	}
	if i < len(IDs) {
		sds = append(sds, trackSeedNew(IDs[i:len(IDs)]))
	}

	return sds
}

// playlistName returns the name to be given to a playlist based on the
// provided time range.
func playlistName(t string) string {
	switch t {
	case "short":
		return "New Interests"
	case "medium":
		return "Common Trends"
	case "long":
		return "Core Taste"
	default:
		return "default"
	}
}
