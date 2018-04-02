module Types exposing (..)

import Discover.Types as Discover
import Landing.Types as Landing
import Navigation
import Routing exposing (Route) 
import Spotify.Types exposing (Token)
 
type alias Model = 
    { route : Route
    , changes : Int
    , token : Maybe Token
    , landing : Landing.Model
    , discover: Discover.Model
    }

 
type Msg
    = ChangeLocation String
    | OnLocationChange Navigation.Location
    | LandingMsg Landing.Msg
    | DiscoverMsg Discover.Msg