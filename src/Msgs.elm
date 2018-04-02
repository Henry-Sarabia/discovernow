module Msgs exposing (..)

import Navigation
import Models exposing (Login, Token, Playlist)
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