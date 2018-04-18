package main

import (
	"encoding/json"
	"os"
	"testing"

	"github.com/zmb3/spotify"
)

type testClient struct{}

func (ts testClient) CurrentUser() (*spotify.PrivateUser, error) {
	u := spotify.User{
		DisplayName: "testName",
		ID:          "testID",
	}
	pu := spotify.PrivateUser{
		User: u,
	}

	return &pu, nil
}

func (ts testClient) CurrentUsersTopArtistsOpt(opt *spotify.Options) (*spotify.FullArtistPage, error) {
	a := spotify.FullArtistPage{}
	err := loadFile("test_data/current_users_top_artists.json", &a)
	if err != nil {
		return nil, err
	}
	return &a, nil
}

func (ts testClient) PlayerRecentlyPlayedOpt(opt *spotify.RecentlyPlayedOptions) ([]spotify.RecentlyPlayedItem, error) {
	rp := spotify.RecentlyPlayedResult{}
	err := loadFile("test_data/player_recently_played.json", &rp)
	if err != nil {
		return nil, err
	}
	return rp.Items, nil
}

func (ts testClient) GetRecommendations(spotify.Seeds, *spotify.TrackAttributes, *spotify.Options) (*spotify.Recommendations, error) {
	recs := spotify.Recommendations{}
	err := loadFile("test_data/get_recommendations.json", &recs)
	if err != nil {
		return nil, err
	}
	return &recs, nil
}

func (ts testClient) CreatePlaylistForUser(string, string, bool) (*spotify.FullPlaylist, error) {
	return nil, nil
}

func (ts testClient) AddTracksToPlaylist(string, spotify.ID, ...spotify.ID) (string, error) {
	return "", nil
}

func loadFile(name string, dest interface{}) error {
	f, err := os.Open(name)
	if err != nil {
		return err
	}
	defer f.Close()

	dec := json.NewDecoder(f)
	dec.Decode(&dest)
	return nil
}

func TestTopArtists(t *testing.T) {
	g := generator{
		client: testClient{},
	}

	ta, err := g.topArtists(50, "long")
	if err != nil {
		t.Fatal(err)
	}

	expLength := 50
	actLength := len(ta)
	if actLength != expLength {
		t.Fatalf("Expected length %d, got %d", expLength, actLength)
	}

	expName := "Radiohead"
	actName := ta[0].Name
	if actName != expName {
		t.Fatalf("Expected name %s, got %s", expName, actName)
	}

	return
}

func TestRecentTracks(t *testing.T) {
	g := generator{
		client: testClient{},
	}

	rt, err := g.recentTracks(20)
	if err != nil {
		t.Fatal(err)
	}

	expLength := 20
	actLength := len(rt)
	if actLength != expLength {
		t.Fatalf("Expected length %d, got %d", expLength, actLength)
	}

	expName := "The Sound Of Silence"
	actName := rt[0].Name
	if actName != expName {
		t.Fatalf("Expected name %s, got %s", expName, actName)
	}
}

func TestRecommendation(t *testing.T) {
	g := generator{
		client: testClient{},
	}

	recs, err := g.recommendation(spotify.Seeds{}, 10, nil)
	if err != nil {
		t.Fatal(err)
	}

	expLength := 10
	actLength := len(recs)
	if actLength != expLength {
		t.Fatalf("Expected length of %d, got %d", expLength, actLength)
	}

	expName := recs[9].Name
	actName := "Appalachian Spring: Moderato - Coda"
	if actName != expName {
		t.Fatalf("Expected name %s, got %s", expName, actName)
	}
}

// func TestUniqueRecommendations(t *testing.T) {
// 	g := generator{
// 		client: testClient{},
// 	}
//
// 	recs, err := g.uniqueRecommendations(spotify.Seeds{}, 5, nil, nil)
// }
