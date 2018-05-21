module Views.Footer exposing (heroFooter, simpleFooter)

import Html exposing (Html, div, text, span, a, img, footer, p)
import Html.Attributes exposing (class, style, src, href, alt, height, width, attribute)
import Msgs exposing (Msg(..))
import Views.Common exposing (..)


simpleFooter : Html Msg
simpleFooter =
    footer
        [ class "footer is-success"

        -- , style [ ( "background-color", "#959e98" ) ]
        , style [ ( "background-color", "#d8d8d8" ) ]
        ]
        [ div
            [ class "container" ]
            [ footerContent ]
        ]


heroFooter : Html Msg
heroFooter =
    footer
        [ class "hero-foot"
        , style
            [ ( "padding", "4rem 0rem" )
            , ( "box-shadow", "0 -1px 0 hsla(0,0%,100%,.2)" )
            ]
        ]
        [ div
            [ class "container" ]
            [ footerContent ]
        ]


footerContent : Html Msg
footerContent =
    columns
        [ div
            []
            [ brandTitle "Discover Now"
            , footerText "Created by Henry Sarabia"
            , footerText "Licensed under MIT"
            ]
        , div
            []
            [ footerTitle "Project"
            , footerLink "https://github.com/Henry-Sarabia/myfy" "GitHub"
            , footerLink "" "Spotify"
            , footerLink "" "License"
            ]
        , div
            []
            [ footerTitle "Resources"
            , footerLink "https://bulma.io/" "Bulma"
            , footerLink "https://fontawesome.com/" "FontAwesome"
            , footerLink "https://unsplash.com/@markusspiske" "Markus Spiske"
            , footerLink "https://unsplash.com/@umbe" "Umberto Cofini"
            ]
        , div
            []
            [ footerTitle "Stack"
            , footerLink "http://elm-lang.org/" "Elm"
            , footerLink "https://golang.org/" "Go"
            ]
        ]


brandTitle : String -> Html Msg
brandTitle txt =
    div
        [ class "title is-size-3 has-text-grey-darker"
        , style [ ( "font-family", "Permanent Marker" ) ]
        ]
        [ text txt
        ]


footerTitle : String -> Html Msg
footerTitle txt =
    p
        [ class "title is-size-5 "

        -- , style [ ( "font-family", "Roboto" ) ]
        , style [ ( "font-family", "Quicksand" ), ( "font-weight", "500" ), ( "padding", "0.25em 0em" ) ]
        ]
        [ text txt ]


footerText : String -> Html Msg
footerText txt =
    p
        [ class "is-size-6 has-text-left has-text-weight-normal"
        , style
            [ ( "color", "#707070" )
            ]
        ]
        [ text txt ]


footerLink : String -> String -> Html Msg
footerLink link txt =
    p
        [ style [ ( "padding", "0.25em 0em" ) ] ]
        [ a
            [ class "is-size-6 has-text-left has-text-link"
            , style [ ( "font-weight", "600" ) ]
            , href link
            ]
            [ text txt ]
        ]


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
