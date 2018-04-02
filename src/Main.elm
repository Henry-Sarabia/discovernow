module Main exposing (..)

import Init exposing (initialModel, initialCommands)
import Navigation
import Models exposing (Model)
import Msgs exposing (Msg(..))
import Routing exposing (parseLocation)
import Subscriptions exposing (subscriptions)
import Update exposing (update)
import View exposing (root)
  
init : Navigation.Location -> ( Model, Cmd Msg )
init location = 
    let 
        currentRoute =
            parseLocation location
    in
        ( initialModel currentRoute, initialCommands currentRoute )
 
main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { view = root
        , init = init
        , update = update
        , subscriptions = subscriptions
        } 
