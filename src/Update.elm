module Update exposing (..)

import Commands exposing (..)
import Models exposing (Model)
import Msgs exposing (Msg(..))
import Navigation
import RemoteData
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

        FetchLogin ->
            ( model, fetchLoginCmd )

        OnFetchLogin response ->
            ( { model | login = response }, Cmd.none )

        LoadLogin url ->
            ( model, Navigation.load url )

        ForceFetchLogin ->
            ( model, forceFetchLoginCmd )

        OnForceFetchLogin response ->
            case response of
                RemoteData.NotAsked ->
                    ( { model | login = response }, Cmd.none )

                RemoteData.Loading ->
                    ( { model | login = response }, Cmd.none )

                RemoteData.Success resp ->
                    ( { model | login = response }, Navigation.load resp.url )

                RemoteData.Failure err ->
                    ( { model | login = response }, Navigation.newUrl "/error" )

        FetchPlaylist token ->
            ( { model | discover = RemoteData.Loading }, fetchDiscoverCmd token )

        OnFetchPlaylist response ->
            ( { model | discover = response }, Cmd.none )
