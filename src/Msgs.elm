module Msgs exposing (..)

import Http
import Models exposing (Login, Playlist, Token, PlaylistRange)
import Navigation exposing (Location)
import RemoteData exposing (WebData)

type Msg
    = ChangeLocation String
    | OnLocationChange Location
    | FetchLogin  
    | OnFetchLogin (Result Http.Error Login)
    | FetchSummary Token PlaylistRange
    | OnFetchSummary (WebData Playlist)
    | FetchDiscover Token 
    | OnFetchDiscover (WebData Playlist)