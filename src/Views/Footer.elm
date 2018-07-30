module Views.Footer exposing (simpleFooter)

import Html exposing (Html, div, text, a, footer, p, i, h1, h4)
import Html.Attributes exposing (class, href)
import Msgs exposing (Msg)
import Routing exposing (homePath)
import Utils exposing (..)


simpleFooter : Html Msg
simpleFooter =
    footer
        [ class "footer" ]
        [ content ]


content : Html Msg
content =
    div
        [ class "container" ]
        [ contentDesktop
        , contentMobile
        ]


contentDesktop : Html Msg
contentDesktop =
    div
        [ class "is-hidden-mobile" ]
        [ columns
            [ branding
            , project
            , resources
            , stack
            ]
        , authorNote
        ]


contentMobile : Html Msg
contentMobile =
    div
        [ class "footer-content-mobile is-hidden-tablet" ]
        [ columns
            [ project
            , resources
            , stack
            , branding
            ]
        , authorNote
        ]


branding : Html Msg
branding =
    div
        []
        [ footerHeader "Discover Now"
        , footerCopy "Discover Now is a Spotify playlist generator that learns from a user's recent musical interests. We are not endorsed by Spotify."
        ]


project : Html Msg
project =
    div
        []
        [ footerTitle "Project"
        , footerLink "https://github.com/Henry-Sarabia/myfy" "GitHub Repository"

        -- , footerLink "" "Spotify Page"
        , footerLink "" "License"
        ]


resources : Html Msg
resources =
    div
        []
        [ footerTitle "Resources"
        , footerLink "https://bulma.io/" "Bulma"
        , footerLink "https://fontawesome.com/" "Font Awesome"
        , footerLink "https://unsplash.com/@markusspiske" "Unsplash"
        , footerLink "https://coolbackgrounds.io/" "Cool Backgrounds"
        ]


stack : Html Msg
stack =
    div
        [ class "footer-stack" ]
        [ footerTitle "Stack"
        , footerLink "http://elm-lang.org/" "Elm"
        , footerLink "https://golang.org/" "Go"
        , footerLink "https://sass-lang.com/" "Sass"
        ]


footerHeader : String -> Html Msg
footerHeader txt =
    h1
        [ class "footer-header" ]
        [ a
            [ class "title has-text-weight-bold has-text-primary"
            , href homePath
            ]
            [ text txt ]
        ]


footerTitle : String -> Html Msg
footerTitle txt =
    h4
        [ class "footer-title title is-size-5 has-text-primary" ]
        [ text txt ]


footerCopy : String -> Html Msg
footerCopy txt =
    p
        [ class "footer-copy is-size-6 has-text-left has-text-primary" ]
        [ text txt ]


footerLink : String -> String -> Html Msg
footerLink link txt =
    p
        [ class "footer-link" ]
        [ a
            [ class "is-size-6 has-text-left has-text-grey-footer"
            , href link
            ]
            [ text txt ]
        ]


authorNote : Html Msg
authorNote =
    div
        [ class "has-text-primary" ]
        [ text "Made with "
        , i
            [ class "fas fa-heart" ]
            []
        , text " by Henry Sarabia"
        ]
