module Models exposing (..)

import Routing exposing (Route(..))

type alias Model =
    { route : Route
    , changes : Int
    , token : Maybe Token
    , summary: Playlist
    , discover: Playlist
    }


initialModel : Route -> Model
initialModel route = 
    case route of
        HomeRoute ->
            baseModel route

        AboutRoute ->
            baseModel route

        NotFoundRoute ->
            baseModel route

        ResultsRoute maybeCode maybeState ->
            case (maybeCode, maybeState) of
                ( Just newCode, Just newState ) ->
                    let 
                        newToken = Just (Token newCode newState)
                    in
                        { route = route
                        , changes = 0
                        , token = newToken
                        , summary = Playlist ""
                        , discover = Playlist ""
                        } 

                ( Nothing, _ ) ->
                    baseModel route

                ( _, Nothing ) ->
                    baseModel route

 
baseModel : Route -> Model
baseModel route =
    { route = route
    , changes = 0
    , token = Nothing
    , summary = Playlist ""
    , discover = Playlist ""
    } 
  
  
type alias Login = 
    { url: String }  


type alias Token =
    { code : String
    , state : String
    }


type alias Playlist =
    { id: String }


type PlaylistRange = Short | Medium | Long