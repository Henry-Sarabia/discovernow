module Views.Header exposing (heroNavbar, navbar)

import Html exposing (Html, text, div, img, span, a, nav, i, h1)
import Html.Attributes exposing (style, src, class, href, attribute)
import Html.Events exposing (onClick)
import Models exposing (Model, Login)
import Msgs exposing (Msg(..))
import RemoteData exposing (WebData)
import Views.Icons exposing (..)
import Views.Styles exposing (..)


navbar : Model -> Html Msg
navbar model =
    nav
        [ class "navbar is-light" ]
        [ div
            [ class "container" ]
            [ navbarBrand
            , div
                [ class "navbar-menu" ]
                [ div
                    [ class "navbar-end" ]
                    [ navbarItem githubButton
                    , navbarItem (loginButton model.login)
                    ]
                ]
            ]
        ]


heroNavbar : Model -> Html Msg
heroNavbar model =
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
                    [ navbarItem githubButton
                    , navbarItem (loginButton model.login)
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


loginButton : WebData Login -> Html Msg
loginButton login =
    case login of
        RemoteData.NotAsked ->
            spotifyButton ForceFetchLogin

        RemoteData.Loading ->
            spotifyButton ForceFetchLogin

        RemoteData.Success response ->
            spotifyButton (LoadLogin response.url)

        RemoteData.Failure err ->
            spotifyButton ForceFetchLogin


spotifyButton : Msg -> Html Msg
spotifyButton msg =
    a
        [ class "button is-primary"
        , onClick msg
        ]
        [ icon "fab fa-spotify fa-lg"
        , iconText "Connect"
        ]


githubButton : Html Msg
githubButton =
    a
        [ class "button is-dark is-outlined"
        , href "https://github.com/Henry-Sarabia/myfy"
        ]
        [ icon "fab fa-github fa-lg"
        , iconText "Explore"
        ]
