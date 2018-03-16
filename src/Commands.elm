module Commands exposing (..)

import Http
-- import Json.Encode as Encode
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Models exposing (Login, Playlist, Token, PlaylistRange(..))
import Msgs exposing (Msg(..))
import RemoteData


fetchLoginCmd : Cmd Msg
fetchLoginCmd =
    Http.get fetchLoginUrl loginDecoder
    |> Http.send OnFetchLogin

 
fetchLoginUrl : String
fetchLoginUrl = 
    "http://localhost:8080/login"
    -- "https://nameless-thicket-99291.herokuapp.com/login"
  

loginDecoder : Decode.Decoder Login
loginDecoder = 
    decode Login
        |> required "url" Decode.string
 

-- fetchSummaryCmd : Token -> PlaylistRange -> Cmd Msg
-- fetchSummaryCmd token range =
--     Http.get (createSummaryUrl token range) playlistDecoder
--     |> Http.send OnFetchSummary
fetchSummaryCmd : Token -> PlaylistRange -> Cmd Msg
fetchSummaryCmd token range =
    Http.get (createSummaryUrl token range) playlistDecoder
    |> RemoteData.sendRequest
    |> Cmd.map OnFetchSummary


createSummaryUrl : Token -> PlaylistRange -> String
createSummaryUrl token range =
    case range of
        Short ->
            fetchSummaryUrl ++ "?code=" ++ token.code ++ "&state=" ++ token.state ++ "&timerange=short"

        Medium ->
            fetchSummaryUrl ++ "?code=" ++ token.code ++ "&state=" ++ token.state ++ "&timerange=medium"

        Long ->
            fetchSummaryUrl ++ "?code=" ++ token.code ++ "&state=" ++ token.state ++ "&timerange=long"


fetchSummaryUrl : String
fetchSummaryUrl =
    "http://localhost:8080/summary"
    -- "https://nameless-thicket-99291.herokuapp.com/summary"


playlistDecoder : Decode.Decoder Playlist
playlistDecoder =
    decode Playlist
        |> required "id" Decode.string


-- fetchDiscoverCmd : Token -> Cmd Msg
-- fetchDiscoverCmd token =
--     Http.get (fetchDiscoverUrl ++ createTokenUrl token) playlistDecoder
--     |> Http.send OnFetchSummary
fetchDiscoverCmd : Token -> Cmd Msg
fetchDiscoverCmd token =
    Http.get (fetchDiscoverUrl ++ createTokenUrl token) playlistDecoder
    |> RemoteData.sendRequest
    |> Cmd.map OnFetchSummary


createTokenUrl : Token -> String
createTokenUrl token =
    "?code=" ++ token.code ++ "&state=" ++ token.state


fetchDiscoverUrl : String
fetchDiscoverUrl =
    "http://localhost:8080/discover"