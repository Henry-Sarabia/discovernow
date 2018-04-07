module Views.Common exposing (..)

import Html exposing (Html, Attribute, div, span, text, a, i)
import Html.Attributes exposing (class, style)
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


smallIcon : String -> Html Msg
smallIcon link =
    span
        [ class "icon is-small" ]
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


largeColorIcon : String -> String -> Html Msg
largeColorIcon link color =
    span
        [ class ("icon " ++ color) ]
        [ i
            [ class link ]
            []
        ]


iconImage : String -> Html Msg
iconImage link =
    span
        [ class "image is-square" ]
        [ i
            [ class link ]
            []
        ]


bouncingIcon : String -> Html Msg
bouncingIcon link =
    span
        [ class "icon is-large bounce" ]
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


stack : List (Html Msg) -> Html Msg
stack items =
    div
        []
        (List.map stackItem items)


stackItem : Html Msg -> Html Msg
stackItem item =
    div
        [ style
            [ ( "margin-top", "2rem" )
            , ( "margin-bottom", "3rem" )
            ]
        ]
        [ item ]


spacer : Html Msg -> Html Msg
spacer child =
    div
        [ style [ ( "margin-top", "5rem" ) ] ]
        [ child ]


columns : List (Html Msg) -> Html Msg
columns children =
    div
        [ class "columns" ]
        (List.map column children)


column : Html Msg -> Html Msg
column child =
    div
        [ class "column has-text-centered" ]
        [ child ]
