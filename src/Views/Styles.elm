module Views.Styles exposing (..)

import Html exposing (Attribute)
import Html.Attributes exposing (style)


alphaPhotoBackground : String -> Float -> Attribute msg
alphaPhotoBackground url alpha =
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


svgBackground : String -> Attribute msg
svgBackground url =
    let
        location =
            "url(" ++ url ++ ")"
    in
        style
            [ ( "background-image", location ++ ", linear-gradient(to right, hsl(0, 0%, 96%), hsl(0, 0%, 96%))" )
            , ( "background-position", "center" )
            , ( "background-repeat", "no-repeat" )
            , ( "background-size", "cover" )
            ]


borderAccent : String -> String -> Attribute msg
borderAccent direction color =
    style
        [ ( "border-" ++ direction, "4px solid " ++ color ) ]


debugBorderStyle : String -> Attribute msg
debugBorderStyle color =
    style
        [ ( "border", "2px solid " ++ color ) ]
