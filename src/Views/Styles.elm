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


whiteGradient : Attribute msg
whiteGradient =
    style
        [ ( "background", "linear-gradient(45deg, hsl(0, 0%, 100%) 0%, hsla(0, 0%, 100%, 0.738) 19%, hsla(0, 0%, 100%, 0.541) 34%, hsla(0, 0%, 100%, 0.382) 47%, hsla(0, 0%, 100%, 0.278) 56.5%, hsla(0, 0%, 100%, 0.194) 65%, hsla(0, 0%, 100%, 0.126) 73%, hsla(0, 0%, 100%, 0.075) 80.2%, hsla(0, 0%, 100%, 0.042) 86.1%, hsla(0, 0%, 100%, 0.021) 91%, hsla(0, 0%, 100%, 0.008) 95.2%, hsla(0, 0%, 100%, 0.002) 98.2%, hsla(0, 0%, 100%, 0) 100%)" ) ]


cardBoxShadow : Attribute msg
cardBoxShadow =
    style
        [ ( "box-shadow", "0 15px 35px rgba(50, 50, 93, .1)" )
        , ( "box-shadow", "0 5px 15px rgba(0, 0, 0, .07)" )
        ]


borderAccent : String -> String -> Attribute msg
borderAccent direction color =
    style
        [ ( "border-" ++ direction, "4px solid " ++ color ) ]


debugBorderStyle : String -> Attribute msg
debugBorderStyle color =
    style
        [ ( "border", "2px solid " ++ color ) ]


cardPadding : Attribute msg
cardPadding =
    style
        [ ( "padding", "1rem 0.5rem 2rem 0.5rem" )
        , ( "margin-top", "2rem" )
        ]


buttonMargin : Attribute msg
buttonMargin =
    style [ ( "margin", "0.5rem 0.5rem 0.5rem 0.5rem" ) ]


fontQuicksand : Attribute msg
fontQuicksand =
    style [ ( "font-family", "Quicksand" ) ]


fontMarker : Attribute msg
fontMarker =
    style [ ( "font-family", "Permanent Marker" ) ]


underlineFont : Attribute msg
underlineFont =
    style [ ( "text-decoration", "underline" ) ]
