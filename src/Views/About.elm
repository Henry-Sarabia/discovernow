module Views.About exposing (root)

import Html exposing (Html, div, text, h1, h2, nav, section, span, a, p, i, hr, article)
import Html.Attributes exposing (class, style, alt, id, attribute, href)
import Html.Events exposing (onClick)
import Models exposing (Model, Login)
import Msgs exposing (Msg(..))
import RemoteData exposing (WebData)
import Routing exposing (aboutPath)
import Utils exposing (..)
import Views.Common exposing (..)


root : Model -> Html Msg
root model =
    div
        []
        [ banner model
        ]


banner : Model -> Html Msg
banner model =
    section
        [ class "hero is-fullheight"
        , photoBackgroundStyle "images/cassette.jpg" 0.2
        ]
        [ desktopBanner model ]


desktopBanner : Model -> Html Msg
desktopBanner model =
    div
        [ class "hero-body is-hidden-touch"
        , style [ ( "margin-top", "-20rem" ) ]
        ]
        [ div
            [ class "container" ]
            [ features model ]
        ]


features : Model -> Html Msg
features model =
    section
        [ class "hero is-small has-text-centered"
        ]
        [ div
            [ class "hero-body container"
            , style [ ( "padding-top", "4rem" ) ]
            ]
            [ div
                [ class "columns" ]
                [ div
                    -- [ class "column is-three-fifths is-offset-one-fifth" ]
                    [ class "column is-narrow" ]
                    [ boxedHeader "Designed with you in mind" ]
                ]
            , div
                [ class "columns" ]
                [ iconColumn "fab fa-github fa-lg fa-fw has-text-primary" "Open Source" "Honest code for honest users. Contributions are always appreciated - explore on GitHub"
                , iconColumn "fab fa-spotify fa-lg fa-fw has-text-primary" "Simple Login" "You have enough accounts to worry about - connect to your existing Spotify account to log in"
                , iconColumn "fas fa-unlock-alt fa-lg fa-fw has-text-primary" "Forever Free" "No ads, no analytics, no subscription - simply share and enjoy"
                , iconColumn "fas fa-mobile-alt fa-lg fa-fw has-text-primary" "Responsive Design" "Designed for both desktop and mobile - for when you need new music on the go"
                ]
            ]
        ]


iconColumn : String -> String -> String -> Html Msg
iconColumn link title sub =
    div
        [ class "column has-text-centered"
        , style [ ( "margin-top", "2.5rem" ), ( "padding", "1.5rem" ) ]
        ]
        [ largeIcon link
        , columnTitle title
        , columnSub sub
        ]


columnTitle : String -> Html Msg
columnTitle txt =
    p
        [ class "title is-spaced is-size-4 has-text-weight-normal"

        -- , style [ ( "font-family", "Quicksand" ) ]
        ]
        [ text txt ]


columnSub : String -> Html Msg
columnSub txt =
    p
        [ class "subtitle is-size-5"
        , style
            [ ( "line-height", "1.4" )
            , ( "font-family", "Quicksand" )
            ]
        ]
        [ text txt ]


boxedHeader : String -> Html Msg
boxedHeader txt =
    article
        [ class "message is-dark has-text-left"
        , style [ ( "border-width", "0 0 0 4px" ), ( "border-radius", "4px" ), ( "border-style", "solid" ), ( "border-color", "#363636" ) ]
        ]
        [ div
            [ class "message-body" ]
            [ div
                [ class "title is-size-3 has-text-weight-normal"
                , style [ ( "font-family", "Quicksand" ) ]
                ]
                [ text txt ]
            ]
        ]
