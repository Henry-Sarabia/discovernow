module Views.Header exposing (navbar)

import Html exposing (Html, text, div, a, nav, h1)
import Html.Attributes exposing (class, href)
import Models exposing (Model, Login)
import Msgs exposing (Msg(..))
import Views.Buttons exposing (smallGithubButton)


navbar : Model -> Html Msg
navbar model =
    div
        [ class "hero-head nav-shadow is-hidden-mobile" ]
        [ nav
            [ class "navbar container" ]
            [ navbarBrand
            , div
                [ class "navbar-menu" ]
                [ div
                    [ class "navbar-end" ]
                    [ navbarItem smallGithubButton ]
                ]
            ]
        ]


navbarBrand : Html Msg
navbarBrand =
    div
        [ class "navbar-brand" ]
        [ div
            [ class "navbar-item" ]
            [ a
                [ href "http://localhost:3000/" ]
                [ logo ]
            ]
        ]


logo : Html Msg
logo =
    h1
        [ class "logo title has-text-weight-bold has-text-grey-darker" ]
        [ text "Discover Now" ]


navbarItem : Html Msg -> Html Msg
navbarItem item =
    div
        [ class "navbar-item" ]
        [ item ]
