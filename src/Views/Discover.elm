module Views.Discover exposing (root)

import Html exposing (Html, div, text, span, a)
import Html.Attributes exposing (class, src, height, width)
import Html.Events exposing (onClick)
import Models exposing (Model, Token)
import Msgs exposing (Msg(..))


root : Model -> Token -> Html Msg
root model token =
    div
        []
        [ hero [ page model token ] ]


hero : List (Html Msg) -> Html Msg
hero children =
    div
        [ class "hero is-large is-light" ]
        [ div
            [ class "hero-body" ]
            children
        ]


page : Model -> Token -> Html Msg
page model token =
    div
        [ class "container has-text-centered" ]
        [ discoverButton token ]


discoverButton : Token -> Html Msg
discoverButton token =
    a
        [ class "button is-large is-success"
        , onClick (FetchPlaylist token)
        ]
        [ span
            []
            [ text "Generate Discover" ]
        ]
