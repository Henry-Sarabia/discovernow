module Main exposing (..)

import Navigation
import State exposing (..)
import Types exposing (..)
import View
 
main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { view = View.root
        , init = State.init
        , update = State.update 
        , subscriptions = State.subscriptions 
        } 
 