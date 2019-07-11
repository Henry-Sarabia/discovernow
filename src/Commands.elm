module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Models exposing (Login, Token, Playlist)
import Msgs exposing (Msg(..))
import RemoteData exposing (WebData)


fetchLoginCmd : Cmd Msg
fetchLoginCmd =
    corsGetRequest loginEndpoint loginDecoder
        |> RemoteData.sendRequest
        |> Cmd.map OnFetchLogin


fetchPlaylistCmd : Token -> Cmd Msg
fetchPlaylistCmd token =
    corsGetRequest (playlistEndpoint ++ tokenQuery token) playlistDecoder
        |> RemoteData.sendRequest
        |> Cmd.map OnFetchPlaylist


corsGetRequest : String -> Decode.Decoder a -> Http.Request a
corsGetRequest url decoder =
    Http.request
        { method = "GET"
        , headers = []
        , url = url
        , body = Http.emptyBody
        , expect = Http.expectJson decoder
        , timeout = Nothing
        , withCredentials = True
        }


loginDecoder : Decode.Decoder Login
loginDecoder =
    decode Login
        |> required "url" Decode.string


playlistDecoder : Decode.Decoder Playlist
playlistDecoder =
    decode Playlist
        |> required "uri" Decode.string


tokenQuery : Token -> String
tokenQuery token =
    "?code=" ++ token.code ++ "&state=" ++ token.state



-- TODO: change to /api/ endpoint


loginEndpoint : String
loginEndpoint =
    "https://discover-now.herokuapp.com/api/v1/login"



-- "http://127.0.0.1:8080/api/v1/login"


playlistEndpoint : String
playlistEndpoint =
    "https://discover-now.herokuapp.com/api/v1/playlist"



-- "http://127.0.0.1:8080/api/v1/playlist"
