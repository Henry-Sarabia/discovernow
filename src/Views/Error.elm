module Views.Error exposing (notFoundPage, serverErrorPage)

import Html exposing (Html, div, text, h1, h2, h3, section, span, a, i)
import Html.Attributes exposing (class, style)
import Models exposing (Model)
import Msgs exposing (Msg(..))
import Routing exposing (homePath)
import Utils exposing (..)
import Views.Icons exposing (..)
import Views.Styles exposing (..)


notFoundPage : Model -> Html Msg
notFoundPage model =
    heroContainer model notFoundBody


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
    heroContainer model errorBody


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


heroContainer : Model -> Html Msg -> Html Msg
heroContainer model body =
    section
        [ class "hero is-fullheight is-light error-background"
        , svgBackground model.flags.errorBG
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
        [ class "error-header-desktop is-hidden-mobile" ]
        [ text txt ]


errorHeaderMobile : String -> Html Msg
errorHeaderMobile txt =
    h1
        [ class "error-header-mobile is-hidden-tablet" ]
        [ text txt ]


errorTitle : String -> Html Msg
errorTitle txt =
    h2
        [ class "title is-spaced" ]
        [ text txt ]


errorSubtitle : String -> Html Msg
errorSubtitle txt =
    h3
        [ class "subtitle is-size-4 has-text-grey-copy" ]
        [ text txt ]


homeButton : String -> Html Msg
homeButton label =
    -- Keep styling local
    a
        [ class "is-size-4 has-text-link"
        , style
            [ ( "margin-left", "-0.4rem" )
            , ( "text-decoration", "underline" )
            ]
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
