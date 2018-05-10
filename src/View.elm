module View exposing (..)

import Html exposing (Html, text, div)
import Models exposing (Model, Token, Login)
import Msgs exposing (Msg(..))
import Routing exposing (..)
import Views.Discover as Discover


-- import Views.Footer exposing (infoFooter)

import Views.Landing as Landing


root : Model -> Html Msg
root model =
    div
        []
        [ page model

        -- , infoFooter
        ]


page : Model -> Html Msg
page model =
    case model.route of
        LandingRoute ->
            landingPage model

        AboutRoute ->
            aboutPage model

        ResultsRoute _ _ ->
            checkResults model

        ErrorRoute ->
            errorPage

        NotFoundRoute ->
            notFoundPage


landingPage : Model -> Html Msg
landingPage model =
    div
        []
        [ Landing.root model ]


aboutPage : Model -> Html Msg
aboutPage model =
    text "about me"


discoverPage : Model -> Token -> Html Msg
discoverPage model token =
    div
        []
        [ Discover.root model token ]


errorPage : Html Msg
errorPage =
    div
        []
        [ text "Uh oh, looks like you found an error" ]


notFoundPage : Html Msg
notFoundPage =
    div
        []
        [ text "404" ]


checkResults : Model -> Html Msg
checkResults model =
    case model.token of
        Nothing ->
            text "you found an error"

        Just token ->
            discoverPage model token
