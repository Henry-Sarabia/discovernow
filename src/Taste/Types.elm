module Taste.Types exposing (..)

import RemoteData exposing (WebData)
import Spotify.Types exposing (Playlist, Token, Range)

 
type alias Model =
    { short : WebData Playlist
    , medium : WebData Playlist
    , long : WebData Playlist
    }

  
type Msg 
    = FetchPlaylist Token Range
    | OnFetchShort (WebData Playlist)
    | OnFetchMedium (WebData Playlist)
    | OnFetchLong (WebData Playlist)
 