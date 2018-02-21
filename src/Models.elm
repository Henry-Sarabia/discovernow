module Models exposing (..)

import Routing exposing (Route)

type alias Model =
    { route : Route
    , changes : Int
    , playlist: Playlist
    , login : Login
    }


initialModel : Route -> Model
initialModel route =
    { route = route
    , changes = 0
    , playlist = Playlist ""
    , login = Login ""
    }

  
type alias Login = 
    { url: String }  


type alias Playlist =
    { id: String }
