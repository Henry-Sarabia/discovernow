module Models exposing (..)

import Routing exposing (Route)

type alias Model =
    { route : Route
    , changes : Int
    }


initialModel : Route -> Model
initialModel route =
    { route = route
    , changes = 0
    }


type alias Login = 
    { url: String }  