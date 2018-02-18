module Commands exposing (..)

import Http
-- import Json.Encode as Encode
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Models exposing (Login)
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
 

loginDecoder : Decode.Decoder Login
loginDecoder =
    decode Login
        |> required "url" Decode.string


