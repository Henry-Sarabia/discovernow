module Commands exposing (..)

import Http
-- import Json.Encode as Encode
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Models exposing (Login, Playlist)
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
 

fetchPlaylistCmd : String -> String -> Cmd Msg
fetchPlaylistCmd code state =
    Http.get (createPlaylistUrl code state) playlistDecoder
    |> Http.send OnFetchPlaylist


createPlaylistUrl : String -> String -> String
createPlaylistUrl code state =
    fetchPlaylistUrl ++ "?" ++ "code=" ++ code ++ "&" ++ "state=" ++ state


fetchPlaylistUrl : String
fetchPlaylistUrl =
    "http://localhost:8080/playlist"


playlistDecoder : Decode.Decoder Playlist
playlistDecoder =
    decode Playlist
        |> required "id" Decode.string