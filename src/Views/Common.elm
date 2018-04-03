module Views.Common exposing (..)

import Html exposing (Html, Attribute, div, span, text, a, i)
import Html.Attributes exposing (class)
import Html.Events exposing (onWithOptions)
import Json.Decode as Decode
import Msgs exposing (Msg)

onLinkClick : Msg -> Attribute Msg
onLinkClick msg =
    let
        options =
            { stopPropagation = False
            , preventDefault = True
            }
    in
        onWithOptions "click" options (Decode.succeed msg)


container : Html Msg -> Html Msg
container child =
    div
        [ class "container" ]
        [ child ]


icon : String -> Html Msg
icon link =
    span
        [ class "icon" ]
        [ i
            [ class link ]
            []
        ]


largeIcon : String -> Html Msg
largeIcon link =
    span
        [ class "icon is-large" ]
        [ i
            [ class link ]
            []
        ]


spanText : String -> Html Msg
spanText txt =
    span
        []
        [ text txt ]

wrap : Html Msg -> Html Msg
wrap child =
    div 
        []
        [ child ]

level : List (Html Msg) -> Html Msg
level items =
    div
        [ class "level" ]
        (List.map levelItem items)


levelItem : Html Msg -> Html Msg
levelItem item =
    div
        [ class "level-item" ]
        [ item ]