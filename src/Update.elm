module Update exposing (..)

import Models exposing (Model)
import Msgs exposing (Msg(..))
import Navigation
import Routing exposing (parseLocation)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeLocation path ->
            ( { model | changes = model.changes + 1 }, Navigation.newUrl path )
        
        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            
            in
                ( { model | route = newRoute }, Cmd.none )