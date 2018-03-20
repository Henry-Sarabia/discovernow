module Discover.Types exposing (..)

import RemoteData exposing (WebData)
import Spotify.Types exposing (..)

type alias Model =
    { instant : WebData Playlist }

 
type Msg
    = FetchPlaylist Token
    | OnFetchPlaylist (WebData Playlist)