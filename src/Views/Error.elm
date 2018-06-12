module Views.Error exposing (notFoundPage, serverErrorPage)

import Html exposing (Html, div, text, h1, h2, h3, section, span, a, i)
import Html.Attributes exposing (class, style, href)
import Models exposing (Model)
import Msgs exposing (Msg(..))
import Routing exposing (homePath)
import Utils exposing (..)
import Views.Icons exposing (..)
import Views.Styles exposing (..)


notFoundPage : Model -> Html Msg
notFoundPage model =
    heroContainer notFoundBody


notFoundBody : Html Msg
notFoundBody =
    div
        [ class "hero-body" ]
        [ div
            [ class "container" ]
            [ errorHeader "Error 404"
            , errorTitle "This page doesn't actually exist."
            , errorSubtitle "But don't worry, we'll help you get home."
            , homeButton "Back to home"
            ]
        ]


serverErrorPage : Model -> Html Msg
serverErrorPage model =
    heroContainer errorBody


errorBody : Html Msg
errorBody =
    div
        [ class "hero-body" ]
        [ div
            [ class "container" ]
            [ errorHeader "Error"
            , errorTitle "Looks like you found an error!"
            , errorSubtitle "It seems some data got lost in translation."
            , homeButton "Back to home"
            ]
        ]


heroContainer : Html Msg -> Html Msg
heroContainer body =
    section
        [ class "hero is-fullheight is-light"
        , svgBackground "images/roseTopography.svg"
        , style [ ( "background-position", "bottom" ) ]
        ]
        [ body ]


errorHeader : String -> Html Msg
errorHeader txt =
    h1
        []
        [ errorHeaderDesktop txt
        , errorHeaderMobile txt
        ]


errorHeaderDesktop : String -> Html Msg
errorHeaderDesktop txt =
    h1
        [ class "title has-text-left is-hidden-mobile"
        , fontMarker
        , style
            [ ( "margin-top", "-20rem" )
            , ( "font-size", "6rem" )
            , ( "padding-bottom", "1rem" )
            ]
        ]
        [ text txt ]


errorHeaderMobile : String -> Html Msg
errorHeaderMobile txt =
    h1
        [ class "title has-text-left is-hidden-tablet"
        , fontMarker
        , style
            [ ( "font-size", "6rem" )
            , ( "padding-bottom", "1rem" )
            ]
        ]
        [ text txt ]


errorTitle : String -> Html Msg
errorTitle txt =
    h2
        [ class "title is-size-3 has-text-weight-medium has-text-left is-spaced"
        , fontQuicksand
        ]
        [ text txt ]


errorSubtitle : String -> Html Msg
errorSubtitle txt =
    h3
        [ class "subtitle is-size-4 has-text-weight-medium has-text-grey-copy has-text-left"
        , fontQuicksand
        ]
        [ text txt ]


homeButton : String -> Html Msg
homeButton label =
    a
        [ class "is-size-4 has-text-link"
        , style
            [ ( "margin-left", "-0.4rem" )
            ]
        , underlineFont
        , onLinkClick (ChangeLocation homePath)
        ]
        [ iconText label
        , span
            [ class "icon"
            , style [ ( "position", "relative" ) ]
            ]
            [ i
                [ class "fas fa-angle-right"
                , style
                    [ ( "position", "absolute" )
                    , ( "top", "5px" )
                    , ( "margin-left", "0.5rem" )
                    ]
                ]
                []
            ]
        ]
