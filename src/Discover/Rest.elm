module Discover.Rest exposing (..)

import Http
import Spotify.Types exposing (Token)
import Spotify.Rest exposing (playlistDecoder)
import Discover.Types exposing (Msg(..))
import RemoteData
  
 
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