module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Models exposing (Login, Token, Playlist)
import Msgs exposing (Msg(..))
import RemoteData exposing (WebData)


fetchLoginCmd : Cmd Msg
fetchLoginCmd =
    Http.get fetchLoginUrl loginDecoder
        |> RemoteData.sendRequest
        |> Cmd.map OnFetchLogin


fetchLoginUrl : String
fetchLoginUrl =
    "https://nameless-thicket-99291.herokuapp.com/login"



-- "http://localhost:8080/login"


loginDecoder : Decode.Decoder Login
loginDecoder =
    decode Login
        |> required "url" Decode.string


forceFetchLoginCmd : Cmd Msg
forceFetchLoginCmd =
    Http.get fetchLoginUrl loginDecoder
        |> RemoteData.sendRequest
        |> Cmd.map OnForceFetchLogin


fetchPlaylistCmd : Token -> Cmd Msg
fetchPlaylistCmd token =
    Http.get (fetchPlaylistUrl ++ createTokenUrl token) playlistDecoder
        |> RemoteData.sendRequest
        |> Cmd.map OnFetchPlaylist


createTokenUrl : Token -> String
createTokenUrl token =
    "?code=" ++ token.code ++ "&state=" ++ token.state



-- TODO: change to /api/ endpoint


fetchPlaylistUrl : String
fetchPlaylistUrl =
    "https://nameless-thicket-99291.herokuapp.com/playlist"



-- "http://localhost:8080/playlist"


playlistDecoder : Decode.Decoder Playlist
playlistDecoder =
    decode Playlist
        |> required "id" Decode.string
