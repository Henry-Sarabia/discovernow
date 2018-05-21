module Views.Common exposing (..)

import Html exposing (Html, Attribute, div, span, text, a, i)
import Html.Attributes exposing (class, style)
import Msgs exposing (Msg(..))


green : String
green =
    "#5ed587"


blue : String
blue =
    "#5f9fb9"


yellow : String
yellow =
    "#ffe88f"


red : String
red =
    "#f58287"


grey : String
grey =
    "#7f807f"


pink : String
pink =
    "#ffb8c9"


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


iconText : String -> Html Msg
iconText txt =
    span
        [ style
            [ ( "padding-left", "0.33em" ), ( "font-family", "Roboto" ) ]
        ]
        [ text txt ]


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
            [ ( "padding-top", "2rem" )
            , ( "padding-bottom", "3rem" )
            ]
        ]
        [ item ]


spacer : Html Msg -> Html Msg
spacer child =
    div
        [ style [ ( "padding-top", "5rem" ) ] ]
        [ child ]


columns : List (Html Msg) -> Html Msg
columns children =
    div
        [ class "columns" ]
        (List.map column children)


column : Html Msg -> Html Msg
column child =
    div
        [ class "column" ]
        [ child ]


photoBackgroundStyle : String -> Float -> Html.Attribute msg
photoBackgroundStyle url alpha =
    let
        location =
            "url(" ++ url ++ ")"

        rgba =
            "rgba(0, 0, 0, " ++ toString (alpha) ++ ")"
    in
        style
            [ ( "background-image", "linear-gradient(" ++ rgba ++ "," ++ rgba ++ "), " ++ location )
            , ( "background-position", "center" )
            , ( "background-repeat", "no-repeat" )
            , ( "background-size", "cover" )
            ]


boxShadowStyle : Html.Attribute msg
boxShadowStyle =
    style
        [ ( "box-shadow", "0 15px 35px rgba(50, 50, 93, .1)" )
        , ( "box-shadow", "0 5px 15px rgba(0, 0, 0, .07)" )
        ]


accentBorderStyle : String -> String -> Html.Attribute msg
accentBorderStyle direction color =
    style
        [ ( "border-" ++ direction, "5px solid " ++ color )
        , ( "border-radius", "2px" )
        ]


debugBorderStyle : String -> Html.Attribute msg
debugBorderStyle color =
    style
        [ ( "border", "2px solid " ++ color ) ]
