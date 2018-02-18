module Msgs exposing (..)

import Http
import Models exposing (Login)
import Navigation exposing (Location)

type Msg
    = ChangeLocation String
    | OnLocationChange Location
    | OnFetchLogin (Result Http.Error Login)
    | FetchLogin 