module Views.Header exposing (navbar)

import Html exposing (Html, text, div, a, nav, h1)
import Html.Attributes exposing (style, class, href)
import Models exposing (Model, Login)
import Msgs exposing (Msg(..))
import Views.Buttons exposing (smallGithubButton)
import Views.Styles exposing (..)


navbar : Model -> Html Msg
navbar model =
    div
        [ class "hero-head is-hidden-mobile"
        , style [ ( "box-shadow", "0 1px 0 hsla(0,0%,100%,.2)" ) ]
        ]
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
        [ class "title is-size-3 has-text-grey-darker"
        , fontMarker
        , style [ ( "margin-left", "-1rem" ) ]
        ]
        [ text "Discover Now" ]


navbarItem : Html Msg -> Html Msg
navbarItem item =
    div
        [ class "navbar-item" ]
        [ item ]
