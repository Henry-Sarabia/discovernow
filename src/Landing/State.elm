module Landing.State exposing (..)

import Landing.Rest exposing (..)
import Landing.Types exposing (..)
import Navigation
import RemoteData


init : ( Model, Cmd Msg )
init =
    ( initialModel, fetchLoginCmd )

initialModel : Model
initialModel =
    { login = RemoteData.Loading }

initialCommands : Cmd Msg
initialCommands =
    fetchLoginCmd
 
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of  
        FetchLogin ->
            ( model, fetchLoginCmd )
        
        OnFetchLogin response ->
            ( { model | login = response }, Cmd.none )

        LoadLogin url ->
            ( model, Navigation.load url) 

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