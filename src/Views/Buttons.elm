module Views.Buttons exposing (..)

import Html exposing (Html, a)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import Msgs exposing (Msg(..))
import Views.Icons exposing (..)


spotifyButton : Html Msg
spotifyButton =
    a
        [ class "button is-medium is-primary"
        , onClick FetchLogin

        -- , buttonMargin
        ]
        [ icon "fab fa-spotify fa-lg"
        , iconText "Connect"
        ]


githubButton : Html Msg
githubButton =
    a
        [ class "button is-medium is-dark is-outlined"
        , href "https://github.com/Henry-Sarabia/myfy"

        -- , buttonMargin
        ]
        [ icon "fab fa-github fa-lg"
        , iconText "Explore"
        ]


smallGithubButton : Html Msg
smallGithubButton =
    a
        [ class "button is-dark is-outlined"
        , href "https://github.com/Henry-Sarabia/myfy"

        -- , buttonMargin
        ]
        [ icon "fab fa-github fa-lg"
        , iconText "Explore"
        ]
