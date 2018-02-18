module Models exposing (..)

import RemoteData exposing (WebData)
import Routing exposing (Route)

type alias Model =
    { route : Route
    , changes : Int
    , login: WebData (Login)
    }


initialModel : Route -> Model
initialModel route =
    { route = route
    , changes = 0
    , login = RemoteData.NotAsked
    }


type alias Login = 
    { url: String } 