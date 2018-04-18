module Msgs exposing (..)

import Models exposing (Login, Token, Playlist, Direction(..))
import Navigation
import RemoteData exposing (WebData)


type Msg
    = ChangeLocation String
    | OnLocationChange Navigation.Location
    | FetchLogin
    | OnFetchLogin (WebData Login)
    | LoadLogin String
    | ForceFetchLogin
    | OnForceFetchLogin (WebData Login)
    | FetchPlaylist Token
    | OnFetchPlaylist (WebData Playlist)
    | OnScroll Direction String
