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
    -- "https://nameless-thicket-99291.herokuapp.com/login"
    "http://192.168.1.5:8080/login"


playlistEndpoint : String
playlistEndpoint =
    -- "https://nameless-thicket-99291.herokuapp.com/playlist"
    "http://192.168.1.5:8080/playlist"
