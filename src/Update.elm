module Update exposing (..)

import Commands exposing (fetchLoginCmd, fetchPlaylistCmd)
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
            ( { model | login = response }, Navigation.load response.url)

        OnFetchLogin (Err error) -> 
            ( model, Cmd.none )

        FetchPlaylist code state -> 
            ( model, fetchPlaylistCmd code state)

        OnFetchPlaylist (Ok response) ->
            ( { model | playlist = response }, Cmd.none )

        OnFetchPlaylist (Err error) ->
            ( { model | playlist = Playlist (toString error) }, Cmd.none ) 