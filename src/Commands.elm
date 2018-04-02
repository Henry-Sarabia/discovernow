module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Models exposing (Login, Token, Playlist)
import Msgs exposing (Msg(..))
import RemoteData

fetchLoginCmd : Cmd Msg
fetchLoginCmd =
    Http.get fetchLoginUrl loginDecoder
    |> RemoteData.sendRequest
    |> Cmd.map OnFetchLogin


fetchLoginUrl : String
fetchLoginUrl = 
    "http://localhost:8080/login"
    -- "https://nameless-thicket-99291.herokuapp.com/login"
  

loginDecoder : Decode.Decoder Login
loginDecoder =  
    decode Login
        |> required "url" Decode.string
 

forceFetchLoginCmd : Cmd Msg
forceFetchLoginCmd =
    Http.get fetchLoginUrl loginDecoder
    |> RemoteData.sendRequest
    |> Cmd.map OnForceFetchLogin


fetchDiscoverCmd : Token -> Cmd Msg
fetchDiscoverCmd token =
    Http.get (fetchDiscoverUrl ++ createTokenUrl token) playlistDecoder
    |> RemoteData.sendRequest
    |> Cmd.map OnFetchPlaylist 


createTokenUrl : Token -> String
createTokenUrl token =
    "?code=" ++ token.code ++ "&state=" ++ token.state


fetchDiscoverUrl : String
fetchDiscoverUrl =
    "http://localhost:8080/discover"


playlistDecoder : Decode.Decoder Playlist
playlistDecoder = 
    decode Playlist
        |> required "id" Decode.string
