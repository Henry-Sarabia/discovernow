module Models exposing (..)

import RemoteData exposing (WebData)
import Routing exposing (Route(..))

type alias Model =
    { route : Route
    , changes : Int
    , token : Maybe Token
    , summary: WebData Playlist
    , discover: WebData Playlist
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
                        , summary = RemoteData.NotAsked
                        , discover = RemoteData.NotAsked
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
    , summary = RemoteData.NotAsked
    , discover = RemoteData.NotAsked
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