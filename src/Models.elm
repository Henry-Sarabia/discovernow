module Models exposing (..)

import Routing exposing (Route(..))
import RemoteData exposing (WebData)


type alias Model =
    { route : Route
    , changes : Int
    , token : Maybe Token
    , login : WebData Login
    , discover : WebData Playlist
    }


type Range
    = Short
    | Medium
    | Long


type alias Login =
    { url : String }


type alias Playlist =
    { id : String }


type alias Token =
    { code : String
    , state : String
    }
