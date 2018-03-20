module Spotify.Rest exposing (..)

import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Spotify.Types exposing (..)

playlistDecoder : Decode.Decoder Playlist
playlistDecoder =
    decode Playlist
        |> required "id" Decode.string
