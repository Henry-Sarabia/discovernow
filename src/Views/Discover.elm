module Views.Discover exposing (root)

import Html exposing (Html, div, text, span, a)
import Html.Attributes exposing (class, src, height, width)
import Html.Events exposing (onClick)
import Models exposing (Model, Token, Playlist)
import Msgs exposing (Msg(..))
import RemoteData exposing (WebData)
import Utils exposing (..)


root : Model -> Token -> Html Msg
root model token =
    div
        []
        [ hero [ page model token ] ]


hero : List (Html Msg) -> Html Msg
hero children =
    div
        [ class "hero is-fullheight  is-light" ]
        [ div
            [ class "hero-body" ]
            children
        ]


page : Model -> Token -> Html Msg
page model token =
    div
        [ class "container has-text-centered" ]
        [ text "good job buddy"
        ]



-- [ discoverButton token
-- , test model.discover
-- ]


discoverButton : Token -> Html Msg
discoverButton token =
    a
        [ class "button is-large is-success"

        -- , onClick (FetchPlaylist token)
        ]
        [ span
            []
            [ text "Generate Discover" ]
        ]


test : WebData Playlist -> Html Msg
test playlist =
    case playlist of
        RemoteData.NotAsked ->
            text "not asked"

        RemoteData.Loading ->
            text "loading"

        RemoteData.Success response ->
            text response.id

        RemoteData.Failure err ->
            text (errorToString err)
