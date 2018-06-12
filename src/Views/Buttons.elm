module Views.Buttons exposing (loginButton, githubButton)

import Html exposing (Html, a)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import Models exposing (Login)
import Msgs exposing (Msg(..))
import RemoteData exposing (WebData)
import Views.Icons exposing (..)
import Views.Styles exposing (..)


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
        [ class "button is-medium is-primary"
        , onClick msg
        , buttonMargin
        ]
        [ icon "fab fa-spotify fa-lg"
        , iconText "Connect"
        ]


githubButton : Html Msg
githubButton =
    a
        [ class "button is-medium is-dark is-outlined"
        , href "https://github.com/Henry-Sarabia/myfy"
        , buttonMargin
        ]
        [ icon "fab fa-github fa-lg"
        , iconText "Explore"
        ]
