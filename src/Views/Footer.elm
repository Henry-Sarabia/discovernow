module Views.Footer exposing (infoFooter)

import Html exposing (Html, div, text, span, a, img, footer)
import Html.Attributes exposing (class, style, src, href, alt, height, width, attribute)
import Msgs exposing (Msg(..))
import Views.Common exposing (..)


infoFooter : Html Msg
infoFooter =
    footer
        [ class "footer"
        , style [ ( "background-color", "#F0F0F0" ) ]
        ]
        [ div
            [ class "container" ]
            [ div
                [ class "columns" ]
                [ footerItem githubInfo
                , footerItem authorInfo
                , footerItem creditInfo
                ]
            ]
        ]


footerItem : Html Msg -> Html Msg
footerItem child =
    div
        [ class "column is-one-third" ]
        [ child ]


authorInfo : Html Msg
authorInfo =
    div
        [ class "has-text-centered" ]
        [ div
            []
            [ text "Created by Henry Sarabia" ]
        , div
            []
            [ text "Licensed under MIT" ]
        ]


githubInfo : Html Msg
githubInfo =
    div
        []
        [ wrap repoButton
        ]


repoButton : Html Msg
repoButton =
    a
        [ class "button" ]
        [ icon "fab fa-github fa-lg"
        , spanText "View on GitHub"
        ]



-- repoButton : Html Msg
-- repoButton =
--     div
--         []
--         [ a
--             [ class "github-button"
--             , href "https://github.com/Henry-Sarabia"
--             , attribute "data-size" "large"
--             , attribute "aria-label" "Follow @Henry-Sarabia on GitHub"
--             ]
--             [  span
--                 []
--                 [ text "Follow @Henry-Sarabia" ]
--             ]
--         ]
-- starButton : Html Msg
-- starButton =
--     div
--         []
--         [ a
--             [ class "github-button"
--             , href "https://github.com/Henry-Sarabia/myfy"
--             , attribute "data-icon" "octicon-star"
--             , attribute "data-size" "large"
--             , attribute "data-show-count" "true"
--             , attribute "aria-label" "Star Henry-Sarabia on GitHub"
--             ]
--             [ span
--                 []
--                 [ text "Star" ]
--             ]]


creditInfo : Html Msg
creditInfo =
    div
        [ class "has-text-right" ]
        [ wrap bulmaButton
        , wrap unsplashButton
        ]


bulmaButton : Html Msg
bulmaButton =
    a
        [ class "button is-small"
        , href "https://bulma.io"
        ]
        [ img
            [ src "https://bulma.io/images/made-with-bulma--semiblack.png"
            , alt "Made with Bulma"
            , width 128
            , height 24
            ]
            []
        ]


unsplashButton : Html Msg
unsplashButton =
    a
        [ class "button is-small is-text"
        , href "https://unsplash.com/photos/pFqrYbhIAXs?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText"
        ]
        [ icon "fas fa-camera fa-lg"
        , span
            []
            [ text "Photo by Luke Chesser" ]
        ]
