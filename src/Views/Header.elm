module Views.Header exposing (navHeader)

import Html exposing (Html, text, div, img, span, a, nav)
import Html.Attributes exposing (src, class, href)
import Msgs exposing (Msg(..))
import Routing exposing (..)
import Views.Common exposing (..)

navHeader : Html Msg
navHeader =
    div
        [ class "container" ]
        [ nav
            [ class "navbar" ]
            [ navBrand logo
            , navMenu
            ]
        ]


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

navBrand : Html Msg -> Html Msg
navBrand child =
    div
        [ class "navbar-brand" ]
        [ a
            [ class "navbar-item" 
            , href homePath
            , onLinkClick (ChangeLocation homePath)
            ]
            [ child ]
        ]

navMenu : Html Msg
navMenu =
    div
        [ class "navbar-menu" ]
        [ div
            [ class "navbar-end" ]
            [ navItem "Home" homePath
            , navItem "About" aboutPath
            ]
        ]


navItem : String -> String -> Html Msg
navItem label path = 
    a
        [ class "navbar-item"
        , href path
        , onLinkClick (ChangeLocation path)
        ]
        [ text label ]

logo : Html Msg
logo =
    largeIcon "fas fa-headphones fa-3x"