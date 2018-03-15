package main

import (
	"testing"
)

func TestExtractGenres(t *testing.T) {
	g := generator{
		client: testClient{},
	}

	art, err := g.topArtists(50, "long")
	if err != nil {
		t.Fatal(err)
	}

	genres, err := extractGenres(art)
	if err != nil {
		t.Fatal(err)
	}

	expLength := 137
	actLength := len(genres)
	if actLength != expLength {
		// scs := spew.ConfigState{SortKeys: true, MaxDepth: 2}
		// t.Fatal(scs.Sdump(genres))
		t.Fatalf("Expected length %d, got %d", expLength, actLength)
	}

	if _, ok := genres["vaporwave"]; !ok {
		t.Fatal("Expected genre string 'vaporwave', got nil")
	}

	if _, ok := genres["zolo"]; !ok {
		t.Fatal("Expected genre string 'zolo', got nil")
	}

	if _, ok := genres["adult standards"]; !ok {
		t.Fatal("Expected genre string 'adults standards', got nil")
	}
}
