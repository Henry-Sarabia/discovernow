module Models exposing (..)

import Routing exposing (Route)

type alias Model =
    { route : Route
    , changes : Int
    , login: Login
    }


initialModel : Route -> Model
initialModel route =
    { route = route
    , changes = 0
    , login = Login ""
    }


type alias Login = 
    { url: String }  