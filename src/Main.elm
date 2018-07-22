module Main exposing (..)

import Init exposing (initialModel, initialCommands)
import Navigation
import Models exposing (Model, Flags)
import Msgs exposing (Msg(..))
import Routing exposing (parseLocation)
import Subscriptions exposing (subscriptions)
import Update exposing (update)
import View exposing (root)


init : Flags -> Navigation.Location -> ( Model, Cmd Msg )
init flags location =
    let
        currentRoute =
            parseLocation location
    in
        ( initialModel flags currentRoute, initialCommands currentRoute )


main : Program Flags Model Msg
main =
    Navigation.programWithFlags OnLocationChange
        { view = root
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
