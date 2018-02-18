module Msgs exposing (..)

import Models exposing (Login)
import Navigation exposing (Location)
import RemoteData exposing (WebData)

type Msg
    = ChangeLocation String
    | OnLocationChange Location
    | OnFetchLogin (WebData Login)
    | FetchLogin 