module Taste.View exposing (root)

import Html exposing (Html, Attribute, div, text, h1, h2, nav, section, span, a, i, p, ul, li, img, header, footer, article)
import Html.Attributes exposing (class, style, src, href, alt, height, width, attribute)
import Html.Events exposing (onWithOptions, onClick)
import Spotify.Types as Spotify
import Taste.Types exposing (Model, Msg(..))

root : Model -> Spotify.Token -> Html Msg
root model token =
    div
        []
        [ hero [page model token] ]


hero : List (Html Msg) -> Html Msg
hero children =
    div
        [ class "hero is-large is-light" ]
        [ div
            [ class "hero-body" ]
            children
        ]


page : Model -> Spotify.Token -> Html Msg
page model token =
    div
        [ class "container" ]
        [ title "Choose from 3 different types of analysis"
        , subtitle ""
        , boxes
            [ ("Recent Trends", "Up to 4 weeks of play history.", [generateButton token Spotify.Short])
            , ("Established Trends", "Up to 6 months of play history.", [generateButton token Spotify.Medium])
            , ("All Trends", "Up to several years of play history.", [generateButton token Spotify.Long])
            ]
        ]


icon : String -> Html Msg
icon link =
    span
        [ class "icon" ]
        [ i
            [ class link ]
            []
        ]


title : String -> Html Msg
title txt =
    p
        [ class "title is-2 has-text-centered is-capitalized has-text-weight-normal" ]
        [ text txt ]

subtitle : String -> Html Msg
subtitle txt =
    p
        [ class "title is-3 has-text-centered has-text-weight-normal"]
        [ text txt ]
 

boxes : List (String, String, List (Html Msg)) -> Html Msg
boxes options =
    div
        [ class "columns" ]
        (List.map box options)


box : (String, String, List(Html Msg)) -> Html Msg
box (head, body, buttons) =
    div
        [ class "column" ]
        [ article
            [ class "message is-success is-large" ]
            [ boxHeader head
            , boxContent body buttons
            ]
        ]


boxHeader : String -> Html Msg
boxHeader txt =
    div
        [ class "message-header is-block has-text-centered" ]
        [ text txt
        ]


boxContent : String -> List(Html Msg) -> Html Msg
boxContent txt buttons =
    div
        [ class "message-body has-text-centered" ]
        [ span [] [text txt]
        , div [] []
        , boxButtons buttons ]


boxButtons : List (Html Msg) -> Html Msg
boxButtons buttons =
    div
        [ class "level" ]
        ( List.map boxButton buttons )


boxButton : Html Msg -> Html Msg
boxButton btn =
    div
        [ class "level-item" ]
        [ btn ]


generateButton : Spotify.Token -> Spotify.Range -> Html Msg
generateButton token range =
    a
        [ class "button is-large is-success"
        , style [("margin-top", "1rem")]
        , onClick (FetchPlaylist token range) ]
        [ span
            []
            [ text "Generate" ]
        ]


recentTrendsBlurb : Html Msg
recentTrendsBlurb =
    div
        []
        [ 
        ]


cards : List (String, String, List (Html Msg)) -> Html Msg
cards options =
    div
        [ class "columns" ]
        (List.map card options)


card : (String, String, List(Html Msg)) -> Html Msg
card (head, body, foot) =
    div 
        [ class "column" ]
        [ div
            [ class "card" ]
            [ cardHeader head
            , cardContent body
            , cardFooter foot
            ]
        ]


cardHeader : String -> Html Msg
cardHeader txt =
    header
        [ class "card-header" ]
        [ p
            [ class "card-header-title is-centered" ]
            [ text txt ]
        ]


cardContent : String -> Html Msg
cardContent txt =
    div
        [ class "card-content" ]
        [ div
            [ class "content" ]
            [ text txt ]
        ]


cardFooter : List (Html Msg) -> Html Msg
cardFooter items =
    footer
        [ class "card-footer" ]
        ( List.map cardFooterItem items )


cardFooterItem : Html Msg -> Html Msg
cardFooterItem item =
    div
        [ class "card-footer-item" ]
        [ item ]


tab : String -> String -> Html Msg
tab iconLink label =
    li
        [ ]
        [ a
            []
            [ icon iconLink
            , span
                []
                [ text label ]
            ]
        ]

tabs : Html Msg
tabs =
    div
        [  ]
        [ div
            [ class "tabs is-left is-large" ]
            [ ul 
                []
                [ tab "fas fa-hourglass-start" "Short"
                , tab "fas fa-hourglass-half" "Medium"
                , tab "fas fa-hourglass-end" "Long"
                ]
            ]
        ]

-- unorderedList : List String -> Html Msg
-- unorderedList items =
--     ul
--         []
--         ( List.map listItem items )

-- listItem : String -> Html Msg
-- listItem txt =
--     li
--         []
--         [ text txt ]