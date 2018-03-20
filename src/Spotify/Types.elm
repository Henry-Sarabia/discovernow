module Spotify.Types exposing (..)

type alias Playlist = 
    { id: String }


type Range = Short | Medium | Long


type alias Token =
    { code : String
    , state : String
    }
