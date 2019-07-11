module Init exposing (..)

import Commands exposing (..)
import Models exposing (Model, Flags, Token)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)
import Routing exposing (Route(..))


initialModel : Flags -> Route -> Model
initialModel flags route =
    case route of
        LandingRoute ->
            baseModel flags route

        AboutRoute ->
            baseModel flags route

        ResultsRoute maybeCode maybeState ->
            case ( maybeCode, maybeState ) of
                ( Just newCode, Just newState ) ->
                    let
                        newToken =
                            Just (Token newCode newState)
                    in
                        { route = route
                        , changes = 0
                        , flags = flags
                        , token = newToken
                        , login = RemoteData.NotAsked
                        , discover = RemoteData.Loading
                        }

                ( Nothing, _ ) ->
                    baseModel flags route

                ( _, Nothing ) ->
                    baseModel flags route

        ErrorRoute ->
            baseModel flags route

        NotFoundRoute ->
            baseModel flags route


baseModel : Flags -> Route -> Model
baseModel flags route =
    { route = route
    , changes = 0
    , flags = flags
    , token = Nothing
    , login = RemoteData.NotAsked
    , discover = RemoteData.NotAsked
    }


initialCommands : Route -> Cmd Msg
initialCommands route =
    case route of
        LandingRoute ->
            Cmd.none

        AboutRoute ->
            Cmd.none

        ResultsRoute maybeCode maybeState ->
            case ( maybeCode, maybeState ) of
                ( Just newCode, Just newState ) ->
                    let
                        newToken =
                            Token newCode newState
                    in
                        fetchPlaylistCmd newToken

                ( Nothing, _ ) ->
                    Cmd.none

                ( _, Nothing ) ->
                    Cmd.none

        ErrorRoute ->
            Cmd.none

        NotFoundRoute ->
            Cmd.none
