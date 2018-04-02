module Views.Discover exposing (root)

import Html exposing (Html, Attribute, div, text, h1, h2, nav, section, span, a, i, p, ul, li, img, header, footer, article)
import Html.Attributes exposing (class, style, src, href, alt, height, width, attribute)
import Html.Events exposing (onWithOptions, onClick)
import Models exposing (Model, Token)
import Msgs exposing (Msg(..))

root : Model -> Token -> Html Msg
root model token =
    div
        []
        [ hero [page model token]]

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