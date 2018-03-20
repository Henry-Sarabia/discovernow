module Discover.State exposing (..)

import RemoteData
import Discover.Rest exposing (..)
import Discover.Types exposing (..)


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    { instant = RemoteData.NotAsked }


initialCommands : Cmd Msg
initialCommands =
    Cmd.none

 
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of 
        FetchPlaylist token ->
            ( { model | instant = RemoteData.Loading } , fetchDiscoverCmd token )

        OnFetchPlaylist response ->
            ( { model | instant = response }, Cmd.none )
