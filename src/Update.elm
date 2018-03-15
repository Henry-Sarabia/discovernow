module Update exposing (..)

import Commands exposing (fetchLoginCmd, fetchSummaryCmd, fetchDiscoverCmd)
import Models exposing (Model, Login, Playlist, Token)
import Msgs exposing (Msg(..))
import Navigation
import Routing exposing (parseLocation, Route, resultsPath)

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

        FetchLogin -> 
            ( model, fetchLoginCmd )

        OnFetchLogin (Ok response) -> 
            ( model, Navigation.load response.url) 

        OnFetchLogin (Err error) -> 
            ( model, Cmd.none )
 
        FetchSummary token range ->
            ( model, fetchSummaryCmd token range )

        OnFetchSummary (Ok response) ->
            ( { model | summary = response }, Cmd.none )

        OnFetchSummary (Err error) ->
            ( { model | summary = Playlist (toString error) }, Cmd.none )

        FetchDiscover token ->
            ( model, fetchDiscoverCmd token ) 

        OnFetchDiscover (Ok response) ->
            ( { model | discover = response }, Cmd.none )

        OnFetchDiscover (Err error) ->
            ( { model | summary = Playlist (toString error) }, Cmd.none )