module Models exposing (..)

import Routing exposing (Route)
import RemoteData exposing (WebData)


type alias Model =
    { route : Route
    , changes : Int
    , token : Maybe Token
    , login : WebData Login
    , discover : WebData Playlist
    }


type alias Login =
    { url : String }


type alias Playlist =
    { uri : String }


type alias Token =
    { code : String
    , state : String
    }
