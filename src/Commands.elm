module Commands exposing (..)

import Http
-- import Json.Encode as Encode
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Models exposing (Login, Playlist, Token, PlaylistRange(..))
import Msgs exposing (Msg(..))


fetchLoginCmd : Cmd Msg
fetchLoginCmd =
    Http.get fetchLoginUrl loginDecoder
    |> Http.send OnFetchLogin


fetchLoginUrl : String
fetchLoginUrl =
    "http://localhost:8080/login" 
 

loginDecoder : Decode.Decoder Login
loginDecoder = 
    decode Login
        |> required "url" Decode.string
 

fetchPlaylistCmd : Token -> PlaylistRange -> Cmd Msg
fetchPlaylistCmd token range =
    Http.get (createPlaylistUrl token range) playlistDecoder
    |> Http.send OnFetchPlaylist


createPlaylistUrl : Token -> PlaylistRange -> String
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
    "http://localhost:8080/playlist"


playlistDecoder : Decode.Decoder Playlist
playlistDecoder =
    decode Playlist
        |> required "id" Decode.string