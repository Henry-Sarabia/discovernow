module Types exposing (..)

import Discover.Types as Discover
import Landing.Types as Landing
import Navigation
import Routing exposing (Route)
import Spotify.Types exposing (Token)
import Taste.Types as Taste
 
type alias Model = 
    { route : Route
    , changes : Int
    , token : Maybe Token
    , landing : Landing.Model
    , taste : Taste.Model
    , discover: Discover.Model
    }

 
type Msg
    = ChangeLocation String
    | OnLocationChange Navigation.Location
    | LandingMsg Landing.Msg
    | TasteMsg Taste.Msg
    | DiscoverMsg Discover.Msg