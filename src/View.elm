module View exposing (..)

import Html exposing (Html)
import Models exposing (Model, Token)
import Msgs exposing (Msg)
import Routing exposing (..)
import Views.About as About
import Views.Discover as Discover
import Views.Error as Error
import Views.Landing as Landing


root : Model -> Html Msg
root model =
    page model


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
            errorPage model

        NotFoundRoute ->
            notFoundPage model


landingPage : Model -> Html Msg
landingPage model =
    Landing.root model


aboutPage : Model -> Html Msg
aboutPage model =
    About.root model


discoverPage : Model -> Html Msg
discoverPage model =
    Discover.root model


errorPage : Model -> Html Msg
errorPage model =
    Error.serverErrorPage model


notFoundPage : Model -> Html Msg
notFoundPage model =
    Error.notFoundPage model


checkResults : Model -> Html Msg
checkResults model =
    case model.token of
        Nothing ->
            errorPage model

        Just token ->
            discoverPage model
