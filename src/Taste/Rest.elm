module Taste.Rest exposing (..)

import Http
import Spotify.Types exposing (Token, Range(..))
import Spotify.Rest exposing (playlistDecoder)
import Taste.Types exposing (Msg(..))
import RemoteData 
   

fetchPlaylistCmd : Token -> Range -> Cmd Msg
fetchPlaylistCmd token range =
    let
        temp = 
            Http.get (createPlaylistUrl token range) playlistDecoder
            |> RemoteData.sendRequest
    in 
        case range of
            Short ->
                temp |> Cmd.map OnFetchShort

            Medium ->
                temp |> Cmd.map OnFetchMedium

            Long ->
                temp |> Cmd.map OnFetchLong


createPlaylistUrl : Token -> Range -> String
createPlaylistUrl token range =
    case range of
        Short ->
            fetchPlaylistUrl ++ "?code=" ++ token.code ++ "&state=" ++ token.state ++ "&timerange=short"

        Medium ->
            fetchPlaylistUrl ++ "?code=" ++ token.code ++ "&state=" ++ token.state ++ "&timerange=medium"

        Long ->
            fetchPlaylistUrl ++ "?code=" ++ token.code ++ "&state=" ++ token.state ++ "&timerange=long"


fetchPlaylistUrl : String
fetchPlaylistUrl =
    "http://localhost:8080/summary"
    -- "https://nameless-thicket-99291.herokuapp.com/summary"
