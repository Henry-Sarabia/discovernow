module Msgs exposing (..)

import Http
import Models exposing (Login, Playlist)
import Navigation exposing (Location)

type Msg
    = ChangeLocation String
    | OnLocationChange Location
    | OnFetchLogin (Result Http.Error Login)
    | FetchLogin  
    | OnFetchPlaylist (Result Http.Error Playlist)
    | FetchPlaylist String String