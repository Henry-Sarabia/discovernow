module Main exposing (..)

import Models exposing (Model, initialModel)
import Msgs exposing (Msg(..))
import Navigation
import Routing exposing (parseLocation)
import Subscriptions exposing (subscriptions)
import Update exposing (update) 
import View exposing (view)

init : Navigation.Location -> ( Model, Cmd Msg )
init location = 
    let 
        currentRoute =
            parseLocation location
    in
        ( initialModel currentRoute, Cmd.none )

 
main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions 
        } 
   