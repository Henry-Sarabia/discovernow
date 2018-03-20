module Main exposing (..)

import Models exposing (Model, initialModel)
import Msgs exposing (Msg(..))
import Navigation 
import Routing exposing (parseLocation)
import Subscriptions exposing (subscriptions)
import Update exposing (update) 
import View exposing (view)

import State
import View
 
main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { view = View.root
        , init = State.init
        , update = State.update
        , subscriptions = State.subscriptions 
        } 
