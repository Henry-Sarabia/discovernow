module Views.Header exposing (heroNavbar)

import Html exposing (Html, text, div, img, span, a, nav, i)
import Html.Attributes exposing (style, src, class, href, attribute)
import Msgs exposing (Msg(..))
import Views.Common exposing (..)


-- navBrand : Html Msg
-- navBrand =
--     div
--         [ class "navbar-brand" ]
--         [ a
--             [ class "navbar-item" ]
--             [ img
--                 [ src "logoxx.png"
--                 , alt "Logo"
--                 ]
--                 []
--             ]
--         ]


heroNavbar : Html Msg
heroNavbar =
    div
        [ class "hero-head"
        , style [ ( "box-shadow", "0 1px 0 hsla(0,0%,100%,.2)" ) ]
        ]
        [ nav
            [ class "navbar container" ]
            [ navbarBrand
            , div
                [ class "navbar-menu" ]
                [ div
                    [ class "navbar-end" ]
                    [ navbarItem githubButton
                    , navbarItem spotifyButton
                    ]
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
    span
        [ class "icon is-large fa-fw fa-3x has-text-info" ]
        [ span
            [ class "fa-layers fa-fw" ]
            [ i
                [ class "far fa-circle"

                -- , attribute "data-fa-transform" "left-0"
                ]
                []
            , i
                [ class "fas fa-dna"
                , attribute "data-fa-transform" "shrink-7"
                ]
                []
            ]
        ]


navbarItem : Html Msg -> Html Msg
navbarItem item =
    div
        [ class "navbar-item" ]
        [ item ]


spotifyButton : Html Msg
spotifyButton =
    a
        [ class "button is-info"
        ]
        [ icon "fab fa-spotify fa-lg"
        , iconText "Connect"
        ]


githubButton : Html Msg
githubButton =
    a
        [ class "button is-dark is-inverted is outlined" ]
        [ icon "fab fa-github fa-lg"
        , iconText "GitHub"
        ]
