module Views.Footer exposing (heroFooter, simpleFooter)

import Html exposing (Html, div, text, span, a, footer, p, i, h2, h4)
import Html.Attributes exposing (class, style, href)
import Msgs exposing (Msg(..))
import Routing exposing (homePath)
import Utils exposing (..)


simpleFooter : Html Msg
simpleFooter =
    footer
        [ class "footer" ]
        [ content
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
            [ content ]
        ]


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
        [ class "is-hidden-tablet"
        , style [ ( "padding-left", "2rem" ) ]
        ]
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
        , footerLink "" "Spotify Page"
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

        -- , footerLink "https://unsplash.com/@umbe" "Umberto Cofini"
        ]


stack : Html Msg
stack =
    div
        [ style [ ( "padding-bottom", "3rem" ) ] ]
        [ footerTitle "Stack"
        , footerLink "http://elm-lang.org/" "Elm"
        , footerLink "https://golang.org/" "Go"
        , footerLink "https://sass-lang.com/" "Sass"
        ]


footerHeader : String -> Html Msg
footerHeader txt =
    h2
        [ style [ ( "padding-bottom", "1.5rem" ) ] ]
        [ a
            [ class "title is-size-3 has-text-primary"
            , style
                [ ( "font-family", "Permanent Marker" ) ]
            , href homePath
            ]
            [ text txt ]
        ]


footerTitle : String -> Html Msg
footerTitle txt =
    h4
        [ class "title is-size-5 has-text-primary has-text-weight-medium"
        , style
            [ ( "font-family", "Quicksand" )
            , ( "padding", "0.25em 0em" )
            ]
        ]
        [ text txt ]


footerCopy : String -> Html Msg
footerCopy txt =
    p
        [ class "is-size-6 has-text-left has-text-primary"
        , style [ ( "padding-right", "3.5rem" ) ]
        ]
        [ text txt ]


footerLink : String -> String -> Html Msg
footerLink link txt =
    p
        [ style
            [ ( "padding", "0.25em 0em" )
            , ( "letter-spacing", "0.5px" )
            ]
        ]
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
            [ style
                [ ( "color", "#ffc0cb" ) ]
            , class "fas fa-heart"
            ]
            []
        , text " by Henry Sarabia"
        ]
