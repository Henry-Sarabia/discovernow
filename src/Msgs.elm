module Msgs exposing (..)

import Http
import Models exposing (Login, Playlist, Token, PlaylistRange)
import Navigation exposing (Location)

type Msg
    = ChangeLocation String
    | OnLocationChange Location
    | OnFetchLogin (Result Http.Error Login)
    | FetchLogin  
    | OnFetchPlaylist (Result Http.Error Playlist)
    | FetchPlaylist Token PlaylistRange 