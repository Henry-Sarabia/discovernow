module Init exposing (..)

import Commands exposing (..)
import Models exposing (Model, Token)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)
import Routing exposing (Route(..))


initialModel : Route -> Model
initialModel route =
    case route of
        LandingRoute ->
            baseModel route

        AboutRoute ->
            baseModel route

        ResultsRoute maybeCode maybeState ->
            case ( maybeCode, maybeState ) of
                ( Just newCode, Just newState ) ->
                    let
                        newToken =
                            Just (Token newCode newState)
                    in
                        { route = route
                        , changes = 0
                        , token = newToken
                        , login = RemoteData.Loading
                        , discover = RemoteData.NotAsked
                        }

                ( Nothing, _ ) ->
                    baseModel route

                ( _, Nothing ) ->
                    baseModel route

        ErrorRoute ->
            baseModel route

        NotFoundRoute ->
            baseModel route


baseModel : Route -> Model
baseModel route =
    { route = route
    , changes = 0
    , token = Nothing
    , login = RemoteData.Loading
    , discover = RemoteData.NotAsked
    }


initialCommands : Route -> Cmd Msg
initialCommands route =
    case route of
        LandingRoute ->
            fetchLoginCmd

        AboutRoute ->
            fetchLoginCmd

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
