module Taste.State exposing (..)

import RemoteData
import Spotify.Types exposing (Range(..))
import Taste.Rest exposing (..)
import Taste.Types exposing (..)


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    { short = RemoteData.NotAsked 
    , medium = RemoteData.NotAsked
    , long = RemoteData.NotAsked
    }


initialCommands : Cmd Msg
initialCommands =
    Cmd.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchPlaylist token range ->
            case range of
                Short -> 
                    ( { model | short = RemoteData.Loading }, fetchPlaylistCmd token range )
                
                Medium ->
                    ( { model | medium = RemoteData.Loading }, fetchPlaylistCmd token range )
                
                Long ->
                    ( { model | long = RemoteData.Loading }, fetchPlaylistCmd token range )
                 
        OnFetchShort response ->
            ( { model | short = response }, Cmd.none )

        OnFetchMedium response ->
            ( { model | medium = response }, Cmd.none )

        OnFetchLong response ->
            ( { model | long = response } , Cmd.none )