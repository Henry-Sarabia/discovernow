module Landing.Rest exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Landing.Types exposing (Login, Msg(..))
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