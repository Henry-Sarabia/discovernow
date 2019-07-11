module Views.Icons exposing (..)

import Html exposing (Html, i, span, text)
import Html.Attributes as Attributes
import Msgs exposing (Msg)
import Svg exposing (svg, path, rect, polygon, circle)
import Svg.Attributes exposing (class, style, width, height, viewBox, d, transform, version, fillRule, fill, xmlSpace, points, x, y, rx, cx, cy, r)
import Views.Colors exposing (..)


-- Styling must stay in-line


icon : String -> Html Msg
icon link =
    span
        [ Attributes.class "icon" ]
        [ i
            [ Attributes.class link ]
            []
        ]


iconText : String -> Html Msg
iconText txt =
    span
        [ Attributes.class "icon-text" ]
        [ text txt ]


fillStyle : String -> Svg.Attribute msg
fillStyle color =
    style ("fill: " ++ color)


lightbulbIcon : String -> String -> Html.Html msg
lightbulbIcon primary secondary =
    svg [ xmlSpace "http://www.w3.org/2000/svg", width "100", height "100", viewBox "0 0 100 100", class "heroicon-lightbulb heroicon heroicons-lg" ]
        [ path [ class "heroicon-lightbulb-bulb heroicon-component-fill", d "M40 78h20a2 2 0 0 0 2-2v-6c0-1.63.84-3.67 2-4.83l.33-.33A33.75 33.75 0 0 1 58 67.05V65a31.97 31.97 0 0 0 24-31 32 32 0 1 0-40 31v2.06a33.74 33.74 0 0 1-6.33-2.2l.33.32c1.16 1.16 2 3.2 2 4.84v6c0 1.1.9 1.99 2 1.99z" ]
            []
        , path
            [ class "heroicon-lightbulb-screw heroicon-component-accent heroicon-component-fill"
            , fillStyle primary
            , d "M40 79v4a2 2 0 1 0 0 4v2a2 2 0 1 0 0 4v1c0 1.1.8 2.4 1.8 2.9l4.4 2.2c1 .5 2.7.9 3.8.9 1.11 0 2.8-.4 3.8-.9l4.4-2.2c1-.5 1.8-1.8 1.8-2.9v-1a2 2 0 1 0 0-4v-2a2 2 0 1 0 0-4v-4H40z"
            ]
            []
        , path
            [ class "heroicon-lightbulb-source heroicon-component-accent heroicon-component-fill"
            , d "M52 52h.5a1.5 1.5 0 1 0 0-3h-5a1.5 1.5 0 1 0 0 3h.5v8.54A4 4 0 0 0 46 64V79h8V64a4 4 0 0 0-2-3.47V52z"
            , fillStyle secondary
            ]
            []
        , path [ class "heroicon-shadows", d "M76.35 55.49a34.2 34.2 0 0 1-3.77 3.93l-7.16 7.16A5.57 5.57 0 0 0 64 70.01v.24A27.87 27.87 0 0 1 50 74c-5.1 0-9.88-1.36-14-3.75v-.24c0-1.11-.63-2.64-1.42-3.43l-7.16-7.16a34.2 34.2 0 0 1-3.77-3.93A27.81 27.81 0 0 1 22.28 50a31.99 31.99 0 0 0 55.44 0c-.28 1.89-.74 3.72-1.37 5.48zM42 80h16v2H42v-2zm0 7h16v1H42v-1zm0 6h16v1H42v-1z" ]
            []
        , path [ class "heroicon-outline", fillRule "nonzero", d "M64 70v6a4 4 0 0 1-4 4v3a2 2 0 1 1 0 4v2a2 2 0 1 1 0 4v1c0 1.1-.8 2.4-1.8 2.9l-4.4 2.2c-1 .5-2.69.9-3.8.9-1.1 0-2.8-.4-3.8-.9l-4.4-2.2c-1-.5-1.8-1.8-1.8-2.9v-1a2 2 0 1 1 0-4v-2a2 2 0 1 1 0-4v-3a4 4 0 0 1-4-4v-6c0-1.1-.63-2.63-1.42-3.42l-7.16-7.16a34 34 0 1 1 45.16 0l-7.16 7.16A5.57 5.57 0 0 0 64 70.01zm-24 8h6V68L36 32h3v1h-1.68L46 64.26V64a4 4 0 0 1 2-3.47V52h-.5a1.5 1.5 0 0 1 0-3h5a1.5 1.5 0 0 1 0 3H52v8.54A4 4 0 0 1 54 64v.26L62.68 33H61v-1h3L54 68v10h6a2 2 0 0 0 2-2v-6c0-1.63.84-3.67 2-4.83l.33-.33A33.75 33.75 0 0 1 58 67.05V65a31.97 31.97 0 0 0 24-31 32 32 0 1 0-40 31v2.06a33.74 33.74 0 0 1-6.33-2.2l.33.32c1.16 1.16 2 3.2 2 4.84v6c0 1.1.9 1.99 2 1.99zM24.95 46.52A28 28 0 0 1 50 6v1a27 27 0 0 0-24.15 39.08l-.9.44zM41 33.56c-.28.14-.64.21-.99.21v-1c.2 0 .4-.03.55-.1L43 31.44a2.43 2.43 0 0 1 1.98 0l2.46 1.23c.29.14.81.14 1.1 0L51 31.44a2.43 2.43 0 0 1 1.98 0l2.46 1.23c.29.14.81.14 1.1 0L59 31.44c.28-.14.63-.21.99-.21v1c-.2 0-.4.03-.55.1L57 33.56c-.56.29-1.42.29-1.98 0l-2.46-1.23c-.29-.14-.81-.14-1.1 0L49 33.56c-.56.29-1.42.29-1.98 0l-2.46-1.23c-.29-.14-.81-.14-1.1 0L41 33.56zM39 91a1 1 0 0 0 1 1h20a1 1 0 1 0 0-2H40a1 1 0 0 0-1 1zm0-6a1 1 0 0 0 1 1h20a1 1 0 1 0 0-2H40a1 1 0 0 0-1 1zm3-2h16v-3H42v3zm7-5h2V64a1 1 0 1 0-2 0v14zm4-14a3 3 0 1 0-6 0v14h1V64a2 2 0 1 1 4 0v14h1V64zm-2-3.87V52h-2v8.13a4.01 4.01 0 0 1 2 0zM47.5 50a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zm-.4 47.31c.72.36 2.1.69 2.9.69.8 0 2.18-.33 2.9-.69l.63-.31h-7.06l.63.31zM58 89v-2H42v2h16zm-16 4v1c0 .35.37.95.69 1.1l1.78.9h11.06l1.78-.9c.32-.15.69-.75.69-1.1v-1H42z" ]
            []
        ]


buoyIcon : String -> String -> Html.Html msg
buoyIcon primary secondary =
    svg [ xmlSpace "http://www.w3.org/2000/svg", width "100", height "100", viewBox "0 0 100 100", class "heroicon-buoy heroicon heroicons-lg" ]
        [ path
            [ class "heroicon-buoy-markers heroicon-component-accent heroicon-component-fill"
            , fillStyle primary
            , d "M50 2c3.83 0 7.46.43 11 1.26l-6.48 23.17A25 25 0 0 0 50 26a25 25 0 0 0-4.52.43L38.99 3.26A47.22 47.22 0 0 1 50 2zM2 50c0-3.83.43-7.46 1.26-11l23.17 6.48A24.98 24.98 0 0 0 26 50c0 1.51.16 3.05.43 4.52L3.26 61.01A47.21 47.21 0 0 1 2 50zm96 0c0 3.83-.43 7.46-1.26 11l-23.17-6.48c.27-1.47.43-3 .43-4.52 0-1.51-.16-3.05-.43-4.52l23.17-6.49A47.21 47.21 0 0 1 98 50zM54.52 73.57l6.49 23.17A47.21 47.21 0 0 1 50 98c-3.83 0-7.46-.43-11-1.26l6.48-23.17A25 25 0 0 0 50 74a25 25 0 0 0 4.52-.43z"
            ]
            []
        , path [ class "heroicon-buoy-floater heroicon-component-fill", d "M57.01 24.96l5.4-19.27a46.1 46.1 0 0 1 31.9 31.9L75.04 43a26.05 26.05 0 0 0-18.03-18.03zm0 50.08a26.05 26.05 0 0 0 18.03-18.03l19.27 5.4a46.1 46.1 0 0 1-31.9 31.9L57 75.04zM24.96 57.01a26.05 26.05 0 0 0 18.03 18.03l-5.4 19.27A46.1 46.1 0 0 1 5.7 62.4L24.96 57zm18.03-32.05a26.05 26.05 0 0 0-18.03 18.03l-19.27-5.4A46.1 46.1 0 0 1 37.6 5.7L43 24.96z" ]
            []
        , path
            [ class "heroicon-buoy-rope heroicon-component-accent heroicon-component-fill"
            , fillStyle secondary
            , d "M97 36.84l-.77.21a47.6 47.6 0 0 0-.23-.8V22A18 18 0 0 0 78 4H63.76l-.81-.23.21-.77H78a19 19 0 0 1 19 19v14.84zM63.16 97l-.21-.77.8-.23H78a18 18 0 0 0 18-18V63.76l.23-.81.77.21V78a19 19 0 0 1-19 19H63.16zM3 63.16l.77-.21.23.8V78a18 18 0 0 0 18 18h14.24l.81.23-.21.77H22A19 19 0 0 1 3 78V63.16zm34.05-59.4l-.8.24H22A18 18 0 0 0 4 22v14.24l-.23.81-.77-.21V22A19 19 0 0 1 22 3h14.84l.21.77z"
            ]
            []
        , path [ class "heroicon-shadows", d "M93.11 62.07c.24-.62.46-1.25.66-1.89l1.03.29A46.07 46.07 0 0 1 60.47 94.8l-1.06-3.76a46.08 46.08 0 0 0 32.2-25.4l-17.88-5a25.8 25.8 0 0 0 1.31-3.63l18.07 5.06zm-86.22 0c-.24-.62-.46-1.25-.66-1.89l-1.03.29A46.07 46.07 0 0 0 39.53 94.8l1.06-3.76a46.08 46.08 0 0 1-32.2-25.4l17.88-5a25.8 25.8 0 0 1-1.31-3.63L6.89 62.07zM75.97 44.8a26.01 26.01 0 0 0-19.85-24.08l-1.05 3.77A26.03 26.03 0 0 1 75.5 44.93l.46-.13zm-51.94 0a26.01 26.01 0 0 1 19.85-24.08l1.05 3.77A26.03 26.03 0 0 0 24.5 44.93l-.46-.13zm32.09-24.08a26.07 26.07 0 0 0-12.24 0l1.6 5.71A25 25 0 0 1 50 26a25 25 0 0 1 4.52.43l1.6-5.7zm3.3 70.32a46.2 46.2 0 0 1-18.83 0l-1.6 5.7C42.54 97.57 46.17 98 50 98s7.46-.43 11-1.26l-1.59-5.7z" ]
            []
        , path [ class "heroicon-outline", fillRule "nonzero", d "M98 63.44V78a20 20 0 0 1-20 20H63.44l.05.16A49.55 49.55 0 0 1 50 100a50.14 50.14 0 0 1-13.48-1.84l.04-.16H22A20 20 0 0 1 2 78V63.44l-.16.04A49.64 49.64 0 0 1 0 50a50.13 50.13 0 0 1 1.84-13.48l.16.04V22A20 20 0 0 1 22 2h14.56l-.05-.16A49.64 49.64 0 0 1 50 0a50.14 50.14 0 0 1 13.48 1.84l-.04.16H78a20 20 0 0 1 20 20v14.56l.16-.04A49.55 49.55 0 0 1 100 50a50.13 50.13 0 0 1-1.84 13.48l-.16-.04zM50 2c-3.83 0-7.46.43-11 1.26l6.48 23.17A25 25 0 0 1 50 26a25 25 0 0 1 4.52.43l6.49-23.17A47.22 47.22 0 0 0 50 2zm7.01 22.96a26.05 26.05 0 0 1 18.03 18.03l19.27-5.4A46.1 46.1 0 0 0 62.4 5.7L57 24.96zM97 36.84V22A19 19 0 0 0 78 3H63.16l-.21.77.8.23H78a18 18 0 0 1 18 18v14.24l.23.81.77-.21zM95 22A17 17 0 0 0 78 5H66.74A48.15 48.15 0 0 1 95 33.26V22zm-38.53 4.88l-.54 1.93a22.02 22.02 0 0 0-11.86 0l-.54-1.93a24.05 24.05 0 0 0-16.65 16.65l1.93.54a22.02 22.02 0 0 0 0 11.86l-1.93.54a24.05 24.05 0 0 0 16.65 16.65l.54-1.93a22.02 22.02 0 0 0 11.86 0l.54 1.93a24.05 24.05 0 0 0 16.65-16.65l-1.93-.54a22.02 22.02 0 0 0 0-11.86l1.93-.54a24.05 24.05 0 0 0-16.65-16.65zm.54 48.16l5.4 19.27a46.1 46.1 0 0 0 31.9-31.9L75.04 57a26.05 26.05 0 0 1-18.03 18.03zM66.74 95H78a17 17 0 0 0 17-17V66.74A48.15 48.15 0 0 1 66.74 95zm-3.58 2H78a19 19 0 0 0 19-19V63.16l-.77-.21-.23.8V78a18 18 0 0 1-18 18H63.76l-.81.23.21.77zm-38.2-39.99l-19.27 5.4a46.1 46.1 0 0 0 31.9 31.9L43 75.04a26.05 26.05 0 0 1-18.03-18.03zM5 66.74V78a17 17 0 0 0 17 17h11.26A48.15 48.15 0 0 1 5 66.74zm-2-3.58V78a19 19 0 0 0 19 19h14.84l.21-.77-.8-.23H22A18 18 0 0 1 4 78V63.76l-.23-.81-.77.21zm39.99-38.2l-5.4-19.27A46.1 46.1 0 0 0 5.7 37.6L24.96 43a26.05 26.05 0 0 1 18.03-18.03zM33.26 5H22A17 17 0 0 0 5 22v11.26A48.15 48.15 0 0 1 33.26 5zm3.8-1.23L36.83 3H22A19 19 0 0 0 3 22v14.84l.77.21.23-.8V22A18 18 0 0 1 22 4h14.24l.81-.23zM2 50c0 3.83.43 7.46 1.26 11l23.17-6.48A24.98 24.98 0 0 1 26 50c0-1.51.16-3.05.43-4.52L3.26 38.99A47.21 47.21 0 0 0 2 50zm96 0c0-3.83-.43-7.46-1.26-11l-23.17 6.48c.27 1.47.43 3 .43 4.52 0 1.51-.16 3.05-.43 4.52l23.17 6.49A47.21 47.21 0 0 0 98 50zM54.52 73.57A25 25 0 0 1 50 74a25 25 0 0 1-4.52-.43l-6.49 23.17C42.54 97.57 46.17 98 50 98s7.46-.43 11-1.26l-6.48-23.17zM50 6c2.77 0 5.48.26 8.11.75l-.27.96a43.25 43.25 0 0 0-15.68 0l-.27-.96C44.52 6.25 47.23 6 50 6zM7.71 57.84l-.96.27a44.25 44.25 0 0 1 0-16.22l.96.27a43.24 43.24 0 0 0 0 15.68zM92.3 42.16l.96-.27a44.25 44.25 0 0 1 0 16.22l-.96-.27a43.25 43.25 0 0 0 0-15.68zM57.84 92.29l.27.96a44.24 44.24 0 0 1-16.22 0l.27-.96a43.24 43.24 0 0 0 15.68 0z" ]
            []
        ]


announcementIcon : String -> String -> Html.Html msg
announcementIcon primary secondary =
    svg [ xmlSpace "http://www.w3.org/2000/svg", width "100", height "100", viewBox "0 0 100 100", class "heroicon-announcement heroicon heroicons-lg" ]
        [ path [ class "heroicon-announcement-bowl heroicon-component-fill", d "M88 9.98A82.6 82.6 0 0 1 46 26.6v28.78a82.6 82.6 0 0 1 42 16.63V9.98z" ]
            []
        , path
            [ class "heroicon-announcement-front heroicon-component-accent heroicon-component-fill"
            , fillStyle primary
            , d "M94 36V4a2 2 0 0 0-2-2h-2v78h2a2 2 0 0 0 2-2V46h2a2 2 0 0 0 2-2v-6a2 2 0 0 0-2-2h-2z"
            ]
            []
        , polygon
            [ class "heroicon-announcement-middle heroicon-component-accent heroicon-component-fill"
            , fillStyle secondary
            , points "11 57 11 25 44 25 44 57 42 57 42 53 18 53 18.4 57"
            ]
            []
        , path
            [ class "heroicon-announcement-handle heroicon-component-accent heroicon-component-fill"
            , fillStyle primary
            , d "M37.55 71h2.54a2 2 0 0 0 1.86-2.74l-1.77-7.43-.18.03V55H20.21l.98 9.84c.14 1.33.63 2.31 1.37 2.9a2.9 2.9 0 0 0 1.64.6l.13.01c.25.01.52 0 .8-.06l6.05 27.4A3.1 3.1 0 0 0 34 98h4.98c1.01 0 1.65-.72 1.53-1.72L37.55 71z"
            ]
            []
        , path [ class "heroicon-announcement-back heroicon-component-fill", d "M3 30H1v22h2v1a3 3 0 0 0 3 3h5V26H6a3 3 0 0 0-3 3v1z" ]
            []
        , path [ class "heroicon-shadows", d "M46 55.4v-14a82.6 82.6 0 0 1 42 16.62v14A82.6 82.6 0 0 0 46 55.4zM26.99 74.72l-1.12-5.58c.33-.1.66-.22 1-.37l9.66-4.4.71 5.7L27 74.72zM10 31v2H8a1 1 0 1 1 0-2h2zm0 6v2H8a1 1 0 1 1 0-2h2zm0 6v2H8a1 1 0 1 1 0-2h2zm0 6v2H8a1 1 0 1 1 0-2h2zm30 8v4H20v-4h-8V41h32v16h-4zm49-16h6v37a3 3 0 0 1-3 3h-3V41z" ]
            []
        , path [ class "heroicon-outline", fillRule "nonzero", d "M88 0h4a4 4 0 0 1 4 4v30a4 4 0 0 1 4 4v6a4 4 0 0 1-4 4v30a4 4 0 0 1-4 4h-4v-7.45A79.62 79.62 0 0 0 46 57.4V59h-4v4l1.8 4.51A4 4 0 0 1 40.1 73h-.48l2.88 23.04A3.44 3.44 0 0 1 39 100h-5a5.09 5.09 0 0 1-4.79-3.93l-5.14-25.73c-2.58-.16-4.55-2.13-4.87-5.3L18.6 59H10v-2H6a4 4 0 0 1-4-4H0V29h2a4 4 0 0 1 4-4h4v-2h36v1.6A79.62 79.62 0 0 0 88 7.46V0zm2 2v78h2a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2h-2zm6 44a2 2 0 0 0 2-2v-6a2 2 0 0 0-2-2v10zM10 27H6a2 2 0 0 0-2 2v24c0 1.1.9 2 2 2h4v-3H8a2 2 0 1 1 0-4h2v-2H8a2 2 0 1 1 0-4h2v-2H8a2 2 0 1 1 0-4h2v-2H8a2 2 0 1 1 0-4h2v-3zm0 4H8a1 1 0 1 0 0 2h2v-2zM88 9.98A82.6 82.6 0 0 1 46 26.6v28.78a82.6 82.6 0 0 1 42 16.63V9.98zm-38 20.7v-1.02a84.98 84.98 0 0 0 34-12.58v1.19a85.96 85.96 0 0 1-34 12.4zM10 37H8a1 1 0 1 0 0 2h2v-2zm0 6H8a1 1 0 1 0 0 2h2v-2zm0 6H8a1 1 0 1 0 0 2h2v-2zm-8 2h1V31H2v20zm10-26v32h2V25h-2zm3 32h3.4l-.4-4h24v4h2V25H15v32zm24.38 14h.71a2 2 0 0 0 1.86-2.74l-1.77-4.43-1.61.73.8 6.44zM24.2 68.35h.13c.64.02 1.36-.13 2.12-.48l9.95-4.52L40 61.7V55H20.21l.98 9.84c.14 1.33.63 2.31 1.37 2.9a2.9 2.9 0 0 0 1.64.6zm6.98 27.33A3.1 3.1 0 0 0 34 98h4.98c1.01 0 1.65-.72 1.53-1.72l-3.99-31.9-9.66 4.4c-.34.15-.67.28-1 .37l5.3 26.53zM23 59a1 1 0 1 1 0-2 1 1 0 0 1 0 2zm15-1a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" ]
            []
        ]


houseIcon : String -> String -> Html.Html msg
houseIcon primary secondary =
    svg [ xmlSpace "http://www.w3.org/2000/svg", width "100", height "100", viewBox "0 0 100 100", class "heroicon-home heroicon heroicons-lg" ]
        [ path [ class "heroicon-home-wall heroicon-component-fill", d "M8 50L50 8l42 42v48H8V50zm10 7v22h12V57H18zm52 0v22h12V57H70zM50 38a8 8 0 1 0 0-16 8 8 0 0 0 0 16z" ]
            []
        , polygon
            [ class "heroicon-home-roof heroicon-component-accent heroicon-component-fill"
            , fillStyle primary
            , points "7 7 44.5 7 50 1.5 55 7 93 7 93 44 99 50 96 53 50 7 4 53 1 50 7 44"
            ]
            []
        , path
            [ class "heroicon-home-frames heroicon-component-accent heroicon-component-fill"
            , fillStyle primary
            , d "M84 79h2v4H66v-4h2V55h16v24zm-52 0h2v4H14v-4h2V55h16v24zm8-24h20v36H40V55zm10-16a9 9 0 1 1 0-18 9 9 0 0 1 0 18zm2-12v1h4.71A7.01 7.01 0 0 0 52 23.29V27zm-8.71 1H48v-4.71A7.01 7.01 0 0 0 43.29 28zM48 36.71V32h-4.71A7.01 7.01 0 0 0 48 36.71zM56.71 32H52v4.71A7.01 7.01 0 0 0 56.71 32zM18 57v22h12V57H18zm52 0v22h12V57H70z"
            ]
            []
        , rect
            [ class "heroicon-home-door heroicon-component-accent heroicon-component-fill"
            , fillStyle secondary
            , width "16"
            , height "34"
            , x "42"
            , y "57"
            ]
            []
        , path [ class "heroicon-home-windows heroicon-component-fill", d "M52 27v-3.71A7.01 7.01 0 0 1 56.71 28H52v-1zm-8.71 1A7.01 7.01 0 0 1 48 23.29V28h-4.71zM48 36.71A7.01 7.01 0 0 1 43.29 32H48v4.71zM56.71 32A7.01 7.01 0 0 1 52 36.71V32h4.71zM18 57h12v22H18V57zm52 0h12v22H70V57z" ]
            []
        , polygon [ class "heroicon-home-parging heroicon-component-fill", points "93 90 7 90 7 99 93 99" ]
            []
        , path [ class "heroicon-shadows", d "M7 50L50 7l43 43v6L50 13 7 56v-6zm7 33h20v2H14v-2zm52 0h20v2H66v-2z" ]
            []
        , path [ class "heroicon-outline", fillRule "nonzero", d "M94 98h6v2H0v-2h6V52l-.59.59L4 54l-1.41-1.41L1.4 51.4 0 50l1.41-1.41L6 44V6h38l4.59-4.59L50 0l1.41 1.41L56 6h38v38l4.59 4.59L100 50l-1.41 1.41-1.18 1.18L96 54l-1.41-1.41L94 52v46zM8 90h32V55h20v35h32V50l-4-4H12l-4 4v40zm6-46l-1 1h74l-1-1H14zm71-1L51.41 9.41 50 8l-1.41 1.41L15 43h70zm-35-3a10 10 0 1 1 0-20 10 10 0 0 1 0 20zm9-10a9 9 0 1 0-18 0 9 9 0 0 0 18 0zm-1 0a8.02 8.02 0 0 1-10 7.75 8.01 8.01 0 0 1 4-15.5A8.01 8.01 0 0 1 58 30zm-10-1h-4.93a7.06 7.06 0 0 0 0 2H49v5.93a7.06 7.06 0 0 0 2 0V31h5.93a7.06 7.06 0 0 0 0-2H51v-5.93a7.06 7.06 0 0 0-2 0V29h-1zm4-2v1h4.71A7.01 7.01 0 0 0 52 23.29V27zm-8.71 1H48v-4.71A7.01 7.01 0 0 0 43.29 28zM48 36.71V32h-4.71A7.01 7.01 0 0 0 48 36.71zM56.71 32H52v4.71A7.01 7.01 0 0 0 56.71 32zM16 56v-1h16v24h2v4H14v-4h2V56zm15 0H17v23h1V57h12v22h1V56zm-2 23V69H19v10h10zM19 68h10V58H19v10zm14 12H15v2h18v-2zm35-24v-1h16v24h2v4H66v-4h2V56zm1 0v23h1V57h12v22h1V56H69zm2 23h10V69H71v10zm10-11V58H71v10h10zM67 80v2h18v-2H67zm-4 11v3h3v4h26v-7H63zM8 98h26v-4h3v-3H8v7zm28 0h28v-2H36v2zm23-8V56H41v34h1V57h16v33h1zm-16 0h14V58H43v32zm2.5-14a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zM49 60v1h-3v10h-1V60h4zm6 0v1h-3v10h-1V60h4zm0 18v1h-9v8h-1v-9h10zm6 16v-2H39v2h22zM58 8l3 3h7V9h1v2h4v1H62l7 7h7v-2h1v2h7v1H70l7 7h7v-2h1v2h2v1h-9l14 14V32h-8v-1h4v-2h1v2h3v-7h-7v-1h3v-2h1v2h3v-7H77v-1h3v-2h1v2h11v-3h-9v-1h1V9h1v2h7V8H58zM8 8v3h3V9h1v2h8v1H8v3h7v-2h1v2h14v1H8v3h11v-2h1v2h4v1H8v3h7v-2h1v3H8v7h7v-2h1v3H8v10l14-14H10v-1h9v-2h1v2h3l15-15h-6v-1h3V9h1v2h3l3-3H8zM4 51.17L48.59 6.6 50 5.17l1.41 1.42L96 51.17 97.17 50 50 2.83 2.83 50 4 51.17z" ]
            []
        ]


monitorIcon : String -> String -> Html.Html msg
monitorIcon primary secondary =
    svg [ xmlSpace "http://www.w3.org/2000/svg", width "100", height "100", viewBox "0 0 100 100", class "heroicon-monitor heroicon heroicons-lg" ]
        [ rect
            [ class "heroicon-monitor-edge heroicon-component-accent heroicon-component-fill"
            , fillStyle primary
            , width "98"
            , height "78"
            , x "1"
            , y "11"
            , rx "5"
            ]
            []
        , rect [ class "heroicon-monitor-screen heroicon-component-fill", width "86", height "66", x "7", y "17" ]
            []
        , rect [ class "heroicon-shadows", width "86", height "5", x "7", y "17" ]
            []
        , path [ class "heroicon-outline", fillRule "nonzero", d "M0 16a6 6 0 0 1 6-6h88a6 6 0 0 1 6 6v68a6 6 0 0 1-6 6H6a6 6 0 0 1-6-6V16zm6-4a4 4 0 0 0-4 4v68a4 4 0 0 0 4 4h88a4 4 0 0 0 4-4V16a4 4 0 0 0-4-4H6zm0 6c0-1.1.9-2 2-2h84a2 2 0 0 1 2 2v64a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2V18zm2 0v31h1V19h15v-1H8zm17 1h16v-1H25v1zm16 1H25v27.59l1-1L28.41 49h2L32 50.59l1.06-1.06L37 23.26l.99 6.6 3 19.98.01.08V20zm1 31.76L43.38 49h3.2L53 42.59l5 5V20H42v31.76zm-1 6.48l-.48.96-.5-3.04-1-6.01L37 36.75l-2.06 13.72L32 53.41 29.59 51h-2L26 49.41l-1 1V80h16V58.24zM42 80h16V50.41l-5-5L47.41 51h-2.8L42 56.24V80zm-1 1H25v1h16v-1zm1 1h16v-1H42v1zm0-63h16v-1H42v1zm17 0h16v-1H59v1zm0 1v28.59l.41.41h4L67 52.59 70.59 49h1.8L75 43.76V20H59zm0 31v29h16V48.24L73.62 51h-2.2L67 55.41 62.59 51H59zm16 30H59v1h16v-1zm1-35.24L77.62 49H90V20H76v25.76zM76 80h14V51H76.38l-.38-.76V80zm0 2h16V51h-1v30H76v1zm0-63h15v30h1V18H76v1zm-66 1v29h13.59l.41-.41V20H10zm0 31v29h14V51H10zm0 30H9V51H8v31h16v-1H10z" ]
            []
        ]


codeIcon : String -> String -> Html.Html msg
codeIcon primary secondary =
    svg [ xmlSpace "http://www.w3.org/2000/svg", width "100", height "100", viewBox "0 0 100 100", class "heroicon-code heroicon heroicon-lg" ]
        [ path
            [ class "heroicon-code-interface heroicon-component-fill"
            , fillStyle white
            , d "M0 18h100v59.997c0 2.21-1.8 4.003-3.997 4.003H3.997C1.79 82 0 80.205 0 77.997V18z"
            ]
            []
        , path [ class "heroicon-code-side heroicon-component-fill", d "M1 17h7v64H4.01C2.346 81 1 79.663 1 78V17z", fillStyle silver ]
            []
        , path
            [ class "heroicon-code-menu-bar heroicon-component-accent heroicon-component-fill"
            , fillStyle primary
            , d "M0 5.996C0 3.79 1.8 2 3.997 2h92.006C98.21 2 100 3.79 100 5.996V18H0V5.996z"
            ]
            []
        , circle
            [ class "heroicon-code-circle heroicon-component-accent heroicon-component-fill"
            , fillStyle secondary
            , cx "82"
            , cy "81"
            , r "18"
            ]
            []
        , path [ class "heroicon-code-symbol heroicon-component-fill", d "M76.707 80.293L76 81l.707.707 3.586 3.586L81 86l-.707.707-1.586 1.586L78 89l-.707-.707-6.586-6.586L70 81l.707-.707 6.586-6.586L78 73l.707.707 1.586 1.586L81 76l-.707.707-3.586 3.586zm7-3.586L83 76l.707-.707 1.586-1.586L86 73l.707.707 6.586 6.586L94 81l-.707.707-6.586 6.586L86 89l-.707-.707-1.586-1.586L83 86l.707-.707 3.586-3.586L88 81l-.707-.707-3.586-3.586z" ]
            []
        , path [ class "heroicon-outline", fillRule "nonzero", d "M3.997 2h92.006C98.21 2 100 3.783 100 5.995v72.01c0 .328-.04.647-.115.952.076.67.115 1.352.115 2.043 0 9.94-8.06 18-18 18-9.606 0-17.454-7.524-17.973-17H3.997C1.79 82 0 80.217 0 78.005V5.995C0 3.788 1.8 2 3.997 2zM82 63c6.966 0 13.007 3.957 16 9.746V18H9v62h55.027c.52-9.476 8.367-17 17.973-17zm16-51V5.995C98 4.89 97.108 4 96.003 4H3.997C2.9 4 2 4.897 2 5.995V12h16l6-6h18l6 6h50zM2 14v2h96v-2H47.172l-6-6H24.828l-6 6H2zm0 4v60.005C2 79.11 2.892 80 3.997 80H7V18H2zm80 79c8.837 0 16-7.163 16-16s-7.163-16-16-16-16 7.163-16 16 7.163 16 16 16zM11 20h4v1h-4v-1zm14 0v1h-8v-1h8zm2 0h6v1h-6v-1zm20 0v1H35v-1h12zm-26 3v1H11v-1h10zm8 0v1h-6v-1h6zm10 0v1h-8v-1h8zm14 1H41v-1h12v1zm2-1h6v1h-6v-1zm-34 4h-8v-1h8v1zm2-1h6v1h-6v-1zm18 0v1H31v-1h10zm2 0h6v1h-6v-1zm16 1h-8v-1h8v1zm-40 2v1h-4v-1h4zm10 1h-8v-1h8v1zm2-1h10v1H31v-1zm24 1H43v-1h12v1zm10-1v1h-8v-1h8zm10 0v1h-8v-1h8zM25 56v1h-8v-1h8zm-4 4h-4v-1h4v1zm10-1v1h-8v-1h8zm12 0v1H33v-1h10zm2 0h10v1H45v-1zm-18-3h10v1H27v-1zm20 0v1h-8v-1h8zm8 0v1h-6v-1h6zm2 0h10v1H57v-1zm18 0v1h-6v-1h6zm2 0h10v1H77v-1zm19 0v1h-7v-1h7zM21 32v1h-6v-1h6zm12 0v1H23v-1h10zm-16 3h7v1h-7v-1zm5 18v1h-7v-1h7zm-7 9h9v1h-9v-1zm5 3v1h-5v-1h5zm-3 3h7v1h-7v-1zm16 0v1h-7v-1h7zm12 0v1H35v-1h10zm8 0v1h-6v-1h6zm-32 3v1h-6v-1h6zm-8 3h6v1h-6v-1zm4 3v1h-6v-1h6zm10 1h-8v-1h8v1zm10-1v1h-8v-1h8zm-9-11h-6v-1h6v1zm2-1h8v1h-8v-1zm0-27v1H19v-1h11zm2 0h8v1h-8v-1zm-7 3v1h-8v-1h8zm-10 3h6v1h-6v-1zm8 6v1h-8v-1h8zm6 0v1h-4v-1h4zm0-6v1h-6v-1h6zm-12 3h10v1H17v-1zm18 0v1h-6v-1h6zm2 0h4v1h-4v-1zm8-15v1H35v-1h10zM6 10c-1.105 0-2-.895-2-2s.895-2 2-2 2 .895 2 2-.895 2-2 2zm7-2c0 1.105-.895 2-2 2s-2-.895-2-2 .895-2 2-2 2 .895 2 2zm3 2c-1.105 0-2-.895-2-2s.895-2 2-2 2 .895 2 2-.895 2-2 2zM4 20h1v1H4v-1zm1 3v1H4v-1h1zm-1 3h1v1H4v-1zm1 3v1H4v-1h1zm-1 3h1v1H4v-1zm1 3v1H4v-1h1zm-1 3h1v1H4v-1zm1 3v1H4v-1h1zm-1 3h1v1H4v-1zm1 3v1H4v-1h1zm-1 3h1v1H4v-1zm1 3v1H4v-1h1zm-1 3h1v1H4v-1zm1 3v1H4v-1h1zm-1 3h1v1H4v-1zm1 3v1H4v-1h1zm-1 3h1v1H4v-1zm1 3v1H4v-1h1zm-1 3h1v1H4v-1zm1 3v1H4v-1h1zm63 4c0-7.732 6.268-14 14-14v1c-7.18 0-13 5.82-13 13 0 1.652.308 3.232.87 4.686l-.908.425C68.342 84.53 68 82.805 68 81zm8.707-.707L76 81l.707.707 3.586 3.586L81 86l-.707.707-1.586 1.586L78 89l-.707-.707-6.586-6.586L70 81l.707-.707 6.586-6.586L78 73l.707.707 1.586 1.586L81 76l-.707.707-3.586 3.586zM79.587 86l-4.294-4.293-.707-.707.707-.707L79.586 76 78 74.414 71.414 81 78 87.586 79.586 86zm4.12-9.293L83 76l.707-.707 1.586-1.586L86 73l.707.707 6.586 6.586L94 81l-.707.707-6.586 6.586L86 89l-.707-.707-1.586-1.586L83 86l.707-.707 3.586-3.586L88 81l-.707-.707-3.586-3.586zm5 5L84.414 86 86 87.586 92.586 81 86 74.414 84.414 76l4.293 4.293.707.707-.707.707z" ]
            []
        ]


coupleIcon : String -> String -> Html.Html msg
coupleIcon primary secondary =
    svg [ xmlSpace "http://www.w3.org/2000/svg", width "100", height "100", viewBox "0 0 100 100", class "heroicon-couple1 heroicon heroicons-lg" ]
        [ path
            [ class "heroicon-couple1-male-top heroicon-component-accent heroicon-component-fill"
            , fillStyle primary
            , d "M55.94 69.03c-.4-3.07-2.63-6.37-5.3-7.71L36 54v4a8 8 0 1 1-16 0v-4L5.37 61.32C2.4 62.79 0 66.68 0 70v25h50-6V81c0-3.31 2.41-7.2 5.37-8.68l6.57-3.29z"
            ]
            []
        , path
            [ class "heroicon-couple1-male-collar heroicon-component-accent heroicon-component-fill"
            , fillStyle primary
            , d "M18 57.24l2-1V58a8 8 0 1 0 16 0v-1.76l2 1V58a10 10 0 1 1-20 0v-.76z"
            ]
            []
        , path [ class "heroicon-couple1-male-face heroicon-component-fill", d "M41 35v3c0 5.02-2.84 9.37-7 11.54V58a6 6 0 0 1-12 0v-8.46c-4.16-2.17-7-6.52-7-11.53V35h-2a3 3 0 1 1 0-6h2v-7.34a5.99 5.99 0 0 0 6.42-1.6 5.48 5.48 0 0 0 6.28-.09 7.47 7.47 0 0 0 6.66.46A5 5 0 0 0 41 21v8h2a3 3 0 1 1 0 6h-2z" ]
            []
        , path [ class "heroicon-couple1-male-mouth heroicon-component-fill", d "M24 44a5 5 0 0 0 8 0h-8z" ]
            []
        , path [ class "heroicon-couple1-male-teeth heroicon-component-fill", d "M23.42 43a4.96 4.96 0 0 1-.32-1h9.8c-.07.35-.18.68-.32 1h-9.16z" ]
            []
        , path
            [ class "heroicon-couple1-male-hair heroicon-component-fill"
            , fillStyle "#d5875e"
            , d "M41.08 13.92l-.1-.76a2.5 2.5 0 0 0-2.24-2.15l-.64-.06-.21-.6a2 2 0 0 0-2.46-1.27l-.45.13-.4-.26a5.47 5.47 0 0 0-5.55-.37l-.55.28-.5-.37a2.48 2.48 0 0 0-3.54.6l-.51.74-.79-.42a3.5 3.5 0 0 0-4.94 1.93l-.25.7-.75-.03L17 12a4 4 0 0 0-3.94 3.32l-.1.6-.58.18a2 2 0 1 0 1.77 3.54l.5-.35.53.27a3.98 3.98 0 0 0 5.23-1.46l.67-1.1.9.93a3.49 3.49 0 0 0 4.96.08l.6-.6.7.51a5.47 5.47 0 0 0 5.92.4l.82-.46.5.78a3 3 0 0 0 4.57.55l.39-.36.51.11A2.51 2.51 0 0 0 44 16.5a2.5 2.5 0 0 0-2.16-2.48l-.76-.1z"
            ]
            []
        , path
            [ class "heroicon-couple1-female-top heroicon-component-accent heroicon-component-fill"
            , fillStyle secondary
            , d "M64.83 64.58l-15.46 7.74C46.4 73.79 44 77.69 44 81v14h56V81c0-3.32-2.4-7.2-5.37-8.68l-14.37-7.19c-.72.4-1.47.74-2.26 1.02v9.84c0 1.44-1.06 4-2.08 5.01L73 83.93 70.08 81A9.08 9.08 0 0 1 68 76v-9.85c-1.12-.4-2.18-.93-3.17-1.57z"
            ]
            []
        , path
            [ class "heroicon-couple1-female-collar heroicon-component-accent heroicon-component-fill"
            , fillStyle secondary
            , d "M64 67.24l.5-.25c.5-.02 1-.08 1.5-.17v9.17c0 1.98 1.27 5.03 2.66 6.43L73 86.76l4.34-4.34c1.4-1.4 2.66-4.46 2.66-6.43v-8.75l2 1v7.75c0 2.5-1.48 6.08-3.25 7.84L73 89.6l-5.75-5.76A12.88 12.88 0 0 1 64 76v-8.75z"
            ]
            []
        , path [ class "heroicon-couple1-female-face heroicon-component-fill", d "M60 51v1a13 13 0 0 0 8 12v12c0 1.44 1.05 3.98 2.08 5L73 83.93 75.92 81A9.11 9.11 0 0 0 78 76V64a13 13 0 0 0 8-12v-1h2a3 3 0 1 0 0-6h-2v-5h-8c-5.4 0-10.32-2.04-14.03-5.38a22.28 22.28 0 0 1-3.97 3.6V45h-2a3 3 0 1 0 0 6h2z" ]
            []
        , path [ class "heroicon-couple1-female-mouth heroicon-component-fill", d "M73 60a3.99 3.99 0 0 1-2.65-1h5.3c-.71.62-1.64 1-2.65 1z" ]
            []
        , path [ class "heroicon-couple1-female-hair heroicon-component-fill", d "M88 38H78a18.93 18.93 0 0 1-14.23-6.4A19.09 19.09 0 0 1 58 37.15V44c-.73 0-1.41.2-2 .54V36a16 16 0 0 1 32 0v2zm0 14a4 4 0 1 0 0-8v-4a8 8 0 0 1 4.8 14.4l-.8.6v1a9 9 0 0 1-11.1 8.75A14.99 14.99 0 0 0 88 52zm-30 0c0 5.27 2.72 9.9 6.83 12.58L64 65a9 9 0 0 1-7.83-13.44c.55.28 1.17.44 1.83.44z" ]
            []
        , path [ class "heroicon-shadows", d "M60 46.11v-7.88a22.28 22.28 0 0 0 3.97-3.6A20.93 20.93 0 0 0 78 40h8v7-5h-8c-5.4 0-10.32-2.04-14.03-5.38a22.28 22.28 0 0 1-3.97 3.6v5.9zM15 21.66a5.99 5.99 0 0 0 6.42-1.6 5.48 5.48 0 0 0 6.28-.09 7.47 7.47 0 0 0 6.66.46A5 5 0 0 0 41 21v2a4.98 4.98 0 0 1-6.64-.57 7.48 7.48 0 0 1-6.66-.46 5.48 5.48 0 0 1-6.28.09 5.99 5.99 0 0 1-6.42 1.6v-2zm65.26 43.47A15 15 0 0 0 88 52c.73 0 1.41-.2 2-.53V52c0 5.93-3.03 11.14-7.63 14.19l3.38 1.68A20.92 20.92 0 0 1 72 73a20.92 20.92 0 0 1-13.75-5.13l4.55-2.27A16.97 16.97 0 0 1 56 52v-.53c.59.34 1.27.53 2 .53a15 15 0 0 0 14.5 15c2.64-.1 5.1-.86 7.22-2.14l.54.27zM36 50.69V54l3.35 1.67A20.9 20.9 0 0 1 28 59a20.9 20.9 0 0 1-11.35-3.33L20 54v-3.3a14.93 14.93 0 0 0 8 2.3c2.94 0 5.68-.85 8-2.3z" ]
            []
        , path [ class "heroicon-outline", fillRule "nonzero", d "M36 7a4 4 0 0 1 3.53 2.12 4.5 4.5 0 0 1 3.28 3.07 4.5 4.5 0 0 1 .19 8.55V28a4 4 0 1 1 0 8v2c0 5.35-2.8 10.04-7 12.7V54l3 1.5 11.63 5.82c2.68 1.34 4.9 4.64 5.3 7.71l4.96-2.48a11 11 0 0 1-6.23-16.36A3.98 3.98 0 0 1 54 48V36a18 18 0 0 1 36 0v2.2A10 10 0 0 1 94 56a11 11 0 0 1-10.08 10.96l10.71 5.36C97.6 73.8 100 77.68 100 81v14H0V70c0-3.32 2.41-7.2 5.37-8.68L17 55.5l3-1.5v-3.3c-4.2-2.66-7-7.35-7-12.7v-2a4 4 0 1 1 0-8v-6a4 4 0 0 1-1.79-7.58 6 6 0 0 1 5.38-4.4 5.5 5.5 0 0 1 6.74-2.71 4.5 4.5 0 0 1 5.34-.76 7.48 7.48 0 0 1 6.67.5c.21-.03.44-.05.66-.05zm52 31v-2a16 16 0 0 0-32 0v8.54a3.98 3.98 0 0 1 2-.54v-6.84a19.1 19.1 0 0 0 5.77-5.57A18.93 18.93 0 0 0 78 38l8 .01h2zM38 22a5 5 0 0 1-3.64-1.57 7.48 7.48 0 0 1-6.66-.46 5.48 5.48 0 0 1-6.28.09 5.99 5.99 0 0 1-6.42 1.6V38a13 13 0 0 0 26 0V21c-.85.64-1.9 1-3 1zm3.08-8.08l-.1-.76a2.5 2.5 0 0 0-2.24-2.15l-.64-.06-.21-.6a2 2 0 0 0-2.46-1.27l-.45.13-.4-.26a5.47 5.47 0 0 0-5.55-.37l-.55.28-.5-.37a2.48 2.48 0 0 0-3.54.6l-.51.74-.79-.42a3.5 3.5 0 0 0-4.94 1.93l-.25.7-.75-.03L17 12a4 4 0 0 0-3.94 3.32l-.1.6-.58.18a2 2 0 1 0 1.77 3.54l.5-.35.53.27a3.98 3.98 0 0 0 5.23-1.46l.67-1.1.9.93a3.49 3.49 0 0 0 4.96.08l.6-.6.7.51a5.47 5.47 0 0 0 5.92.4l.82-.46.5.78a3 3 0 0 0 4.57.55l.39-.36.51.11A2.51 2.51 0 0 0 44 16.5a2.5 2.5 0 0 0-2.16-2.48l-.76-.1zM60 44v8a13 13 0 0 0 26 0V40h-8c-5.4 0-10.32-2.04-14.03-5.38a22.28 22.28 0 0 1-3.97 3.6V44zm28 6a2 2 0 1 0 0-4v4zm0 2c0 5.39-2.84 10.1-7.1 12.75A9.02 9.02 0 0 0 92 56v-1l.8-.6A7.98 7.98 0 0 0 88 40v4a4 4 0 1 1 0 8zm-30-6a2 2 0 1 0 0 4v-4zm0 6c-.66 0-1.28-.16-1.83-.44A9 9 0 0 0 64 65l.83-.42A14.99 14.99 0 0 1 58 52zm6 15.24v8.75c0 2.51 1.48 6.07 3.25 7.84L73 89.6l5.75-5.76A12.9 12.9 0 0 0 82 76v-7.75l-2-1v8.75c0 1.97-1.27 5.04-2.66 6.43L73 86.76l-4.34-4.34A10.95 10.95 0 0 1 66 75.99v-9.17c-.5.09-1 .15-1.5.17l-.5.25zm4 8.75c0 1.45 1.05 4 2.08 5.01L73 83.93 75.92 81A9.11 9.11 0 0 0 78 76v-9.76l-.1-.06a14.98 14.98 0 0 1-9.76.01l-.14.06v9.74zM44 93V81c0-1.3.37-2.69 1-3.98V72h1v3.33a9.53 9.53 0 0 1 3.37-3.01L54 70c0-2.56-1.97-5.75-4.26-6.9L39 57.75V58a11 11 0 0 1-22 0v-.26L6.26 63.1C3.98 64.25 2 67.45 2 70v23h8V72h1v21h33zm2-12v12h6v-7h1v7h38v-7h1v7h6V81a8.64 8.64 0 0 0-4.26-6.9L83 68.75v7.25c0 2.77-1.58 6.6-3.54 8.55L73 91l-6.46-6.46A13.85 13.85 0 0 1 63 75.99v-8.25L50.26 74.1C47.98 75.25 46 78.45 46 81zM13 30a2 2 0 1 0 0 4v-4zm30 4a2 2 0 1 0 0-4v4zM22 51.75V58a6 6 0 0 0 12 0v-6.25a14.96 14.96 0 0 1-12 0zm-4 5.49V58a10 10 0 1 0 20 0v-.76l-2-1V58a8 8 0 1 1-16 0v-1.76l-2 1zm7.17-20.41l.7-.7a3 3 0 0 0 4.25 0l.7.7a3.99 3.99 0 0 1-5.65 0zM23 32a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm.58-4.74l-.31.94a4 4 0 0 0-4.85 2.01l-.9-.45a5 5 0 0 1 6.06-2.5zM34 27a5 5 0 0 1 4.47 2.76l-.9.45a4 4 0 0 0-4.84-2l-.31-.95A5 5 0 0 1 34 27zm0 6a1 1 0 1 1 0-2 1 1 0 0 1 0 2zm-11.92 9a6.05 6.05 0 0 1-.08-1h12a6 6 0 0 1-11.92 1zM24 44a5 5 0 0 0 8 0h-8zm-.58-1h9.16c.14-.32.25-.65.32-1h-9.8c.07.35.18.68.32 1zm47.36 11.33l.56-.83a2.99 2.99 0 0 0 3.32 0l.56.83a3.98 3.98 0 0 1-4.44 0zM68 48a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm-1-5v1a4 4 0 0 0-3.58 2.21l-.9-.45A5 5 0 0 1 67 43zm12 0a5 5 0 0 1 4.47 2.76l-.9.45A4 4 0 0 0 79 44v-1zm0 6a1 1 0 1 1 0-2 1 1 0 0 1 0 2zm-10.58 9h9.16a5 5 0 0 1-9.16 0zM73 60c1.01 0 1.94-.38 2.65-1h-5.3c.71.62 1.64 1 2.65 1z" ]
            []
        ]


walletIcon : String -> String -> Html.Html msg
walletIcon primary secondary =
    svg [ xmlSpace "http://www.w3.org/2000/svg", width "100", height "100", viewBox "0 0 100 100", class "heroicon-wallet heroicon heroicons-lg" ]
        [ path
            [ class "heroicon-wallet-cover heroicon-component-fill"
            , fillStyle brown
            , d "M98 66v20a4 4 0 0 1-4 4H8.5A8.5 8.5 0 0 1 0 81.5v-63C0 13.8 3.8 10 8.5 10H82a4 4 0 0 1 4 4h4v3h4v4a4 4 0 0 1 4 4v21a2 2 0 0 1 2 2v16a2 2 0 0 1-2 2z"
            ]
            []
        , path
            [ class "heroicon-wallet-strap heroicon-component-accent heroicon-component-fill"
            , fillStyle brown
            , d "M70 56a10 10 0 0 1 10-10h18a2 2 0 0 1 2 2v16a2 2 0 0 1-2 2H80a10 10 0 0 1-10-10z"
            ]
            []
        , circle
            [ class "heroicon-wallet-snap heroicon-component-fill"
            , fillStyle secondary
            , cx "80"
            , cy "56"
            , r "5"
            ]
            []
        , path
            [ class "heroicon-wallet-cash heroicon-component-accent heroicon-component-fill"
            , fillStyle primary
            , d "M8.5 16H88v3h4v2H8.5a2.5 2.5 0 0 1 0-5z"
            ]
            []
        , path [ class "heroicon-shadows", d "M2 80H0v2a8 8 0 0 0 8 8h86a4 4 0 0 0 4-4v-6h-2v4a2 2 0 0 1-2 2H8a6 6 0 0 1-6-6zm98-21v-2 2zm-2 9H80a10 10 0 0 1-9.95-11A10 10 0 0 0 80 66h18v2z" ]
            []
        , path [ class "heroicon-outline", fillRule "nonzero", d "M98 66v20a4 4 0 0 1-4 4H8.5A8.5 8.5 0 0 1 0 81.5v-63C0 13.8 3.8 10 8.5 10H82a4 4 0 0 1 4 4h4v3h4v4a4 4 0 0 1 4 4v21a2 2 0 0 1 2 2v16a2 2 0 0 1-2 2zM2 18.5A6.5 6.5 0 0 0 8.5 25H94v1H8.5A7.5 7.5 0 0 1 2 22.24V81.5A6.5 6.5 0 0 0 8.5 88H94a2 2 0 0 0 2-2V66H80a10 10 0 1 1 0-20h16V25a2 2 0 0 0-2-2H8.5a4.5 4.5 0 1 1 0-9H84a2 2 0 0 0-2-2H8.5A6.5 6.5 0 0 0 2 18.5zM8.5 16a2.5 2.5 0 0 0 0 5H92v-2H8.5a.5.5 0 1 1 0-1H88v-2H8.5zM80 48a8 8 0 1 0 0 16h18V48H80zM8.5 29c-1.69 0-3.28-.4-4.7-1.1l.45-.9c1.28.64 2.72 1 4.25 1v1zm3.5-1h4v1h-4v-1zm12 0v1h-4v-1h4zm4 0h4v1h-4v-1zm12 0v1h-4v-1h4zm4 0h4v1h-4v-1zm12 0v1h-4v-1h4zm4 0h4v1h-4v-1zm12 0v1h-4v-1h4zm4 0h4v1h-4v-1zm8 0h4v1h-4v-1zm1 57h4v1h-4v-1zm-4 0v1h-4v-1h4zm-12 0h4v1h-4v-1zm-4 0v1h-4v-1h4zm-12 0h4v1h-4v-1zm-4 0v1h-4v-1h4zm-12 0h4v1h-4v-1zm-4 0v1h-4v-1h4zm-12 0h4v1h-4v-1zm-4 0v1h-4v-1h4zM8 38v24H7V38h1zm77 18a5 5 0 1 1-10 0 5 5 0 0 1 10 0zm-5 4a4 4 0 1 0 0-8 4 4 0 0 0 0 8z" ]
            []
        ]


devicesIcon : String -> String -> Html.Html msg
devicesIcon primary secondary =
    svg [ xmlSpace "http://www.w3.org/2000/svg", width "100", height "100", viewBox "0 0 100 100", class "heroicon-devices heroicon heroicons-lg" ]
        [ path
            [ class "heroicon-devices-tablet-edge-outer heroicon-component-accent heroicon-component-fill"
            , fillStyle primary
            , d "M6 2h68a4 4 0 0 1 4 4v22h-1V6a3 3 0 0 0-3-3H6a3 3 0 0 0-3 3v88a3 3 0 0 0 3 3h52.8c.21.36.45.7.73 1H6a4 4 0 0 1-4-4V6a4 4 0 0 1 4-4z"
            ]
            []
        , path
            [ class "heroicon-devices-tablet-edge-inner heroicon-component-accent heroicon-component-fill"
            , fillStyle primary
            , d "M58.34 96a5.99 5.99 0 0 1-.34-2v-5H7V11h66v17h3V6a2 2 0 0 0-2-2H6a2 2 0 0 0-2 2v88c0 1.1.9 2 2 2h52.34z"
            ]
            []
        , path
            [ class "heroicon-devices-tablet-screen heroicon-component-fill"
            , fillStyle white
            , d "M72 28V12H8v76h50V34a6 6 0 0 1 6-6h8z"
            ]
            []
        , path [ class "heroicon-devices-tablet-button heroicon-component-fill", d "M43.5 92h-7a.5.5 0 0 0 0 1h7a.5.5 0 0 0 0-1z" ]
            []
        , path
            [ class "heroicon-devices-phone-edge-outer heroicon-component-accent heroicon-component-fill"
            , fillStyle secondary
            , d "M64 30h30a4 4 0 0 1 4 4v60a4 4 0 0 1-4 4H64a4 4 0 0 1-4-4V34a4 4 0 0 1 4-4z"
            ]
            []
        , path
            [ class "heroicon-devices-phone-edge-inner heroicon-component-accent heroicon-component-fill"
            , fillStyle secondary
            , d "M94 32H64a2 2 0 0 0-2 2v60c0 1.1.9 2 2 2h30a2 2 0 0 0 2-2V34a2 2 0 0 0-2-2z"
            ]
            []
        , polygon
            [ class "heroicon-devices-phone-screen heroicon-component-fill"
            , fillStyle white
            , points "64 40 94 40 94 88 64 88"
            ]
            []
        , path [ class "heroicon-devices-phone-button heroicon-component-fill", d "M75.5 92h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1 0-1z" ]
            []
        , path [ class "heroicon-shadows", d "M64 28h-5a6 6 0 0 0-6 6v66h11v-.08A6 6 0 0 1 59 94V34a6 6 0 0 1 5-5.92V28z" ]
            []
        , path [ class "heroicon-outline", fillRule "nonzero", d "M64 100H6a6 6 0 0 1-6-6V6a6 6 0 0 1 6-6h68a6 6 0 0 1 6 6v22h14a6 6 0 0 1 6 6v60a6 6 0 0 1-6 6H64zM6 2a4 4 0 0 0-4 4v88a4 4 0 0 0 4 4h53.53c-.28-.3-.52-.64-.73-1H6a3 3 0 0 1-3-3V6a3 3 0 0 1 3-3h68a3 3 0 0 1 3 3v22h1V6a4 4 0 0 0-4-4H6zm52.34 94a5.99 5.99 0 0 1-.34-2v-5H7V11h66v17h3V6a2 2 0 0 0-2-2H6a2 2 0 0 0-2 2v88c0 1.1.9 2 2 2h52.34zM72 28V12H8v76h50V34a6 6 0 0 1 6-6h8zm-8 2a4 4 0 0 0-4 4v60a4 4 0 0 0 4 4h30a4 4 0 0 0 4-4V34a4 4 0 0 0-4-4H64zm0 1h30a3 3 0 0 1 3 3v60a3 3 0 0 1-3 3H64a3 3 0 0 1-3-3V34a3 3 0 0 1 3-3zm30 1H64a2 2 0 0 0-2 2v60c0 1.1.9 2 2 2h30a2 2 0 0 0 2-2V34a2 2 0 0 0-2-2zm-31 7h32v50H63V39zm1 1v48h30V40H64zM37 7h6v1h-6V7zm-.5 84h7a1.5 1.5 0 0 1 0 3h-7a1.5 1.5 0 0 1 0-3zm7 1h-7a.5.5 0 0 0 0 1h7a.5.5 0 0 0 0-1zm.95-54.78l-10 20-.9-.44 10-20 .9.44zm1 6l-6 12-.9-.44 6-12 .9.44zm27.1 28.56l10-20 .9.44-10 20-.9-.44zm5.9-1.56l-.9-.44 6-12 .9.44-6 12zM74 92.5c0-.83.67-1.5 1.5-1.5h7a1.5 1.5 0 0 1 0 3h-7a1.5 1.5 0 0 1-1.5-1.5zm1.5-.5a.5.5 0 0 0 0 1h7a.5.5 0 0 0 0-1h-7zM82 35v1h-6v-1h6z" ]
            []
        ]


userLockIcon : String -> String -> Html.Html msg
userLockIcon primary secondary =
    svg [ xmlSpace "http://www.w3.org/2000/svg", width "100", height "100", viewBox "0 0 100 100", class "heroicon-user-lock heroicon heroicons-lg" ]
        [ path
            [ class "heroicon-user-lock-top heroicon-component-accent heroicon-component-fill"
            , fillStyle primary
            , d "M66.11 73.8L51 66.23V72a10 10 0 1 1-20 0v-5.76L7.27 78.1A8.65 8.65 0 0 0 3 85v13h72.24a17 17 0 0 1-9.13-24.2z"
            ]
            []
        , path
            [ class "heroicon-user-lock-face heroicon-component-fill"
            , fillStyle rose
            , d "M33 60.5V72a8 8 0 1 0 16 0V60.5A22 22 0 0 0 63 40V24a22 22 0 0 0-44 0v16a22 22 0 0 0 14 20.5z"
            ]
            []
        , circle
            [ class "heroicon-user-lock-circle heroicon-component-accent heroicon-component-fill"
            , fillStyle secondary
            , cx "81"
            , cy "82"
            , r "17"
            ]
            []
        , path [ class "heroicon-user-lock-symbol heroicon-component-fill", d "M87 80h3v10H72V80h3v-2a6 6 0 0 1 12 0v2zm-4 0v-2a2 2 0 1 0-4 0v2h4z" ]
            []
        , path [ class "heroicon-shadows", d "M31 61.82V64l-8.74 4.37A33.84 33.84 0 0 0 41 74c6.93 0 13.37-2.07 18.74-5.63L51 64v-2.18A23.91 23.91 0 0 1 41 64c-3.57 0-6.96-.78-10-2.18z" ]
            []
        , path [ class "heroicon-outline", fillRule "nonzero", d "M66.28 71.64A18 18 0 1 1 81 100H1V85c0-3.31 2.4-7.2 5.37-8.69L31 64v-2.18a24 24 0 0 1-14-21.81V23.99a24 24 0 0 1 48 0v16.02a24 24 0 0 1-14 21.82V64l15.28 7.64zM72.75 98c-.6-.31-1.19-.66-1.75-1.03V98h1.75zM70 96.25a17.97 17.97 0 0 1-4.79-22.9L51 66.23V72a10 10 0 1 1-20 0v-5.76L7.27 78.1A8.65 8.65 0 0 0 3 85v13h8v-6h1v6h58v-1.75zM33 62.63V72a8 8 0 1 0 16 0v-9.36a23.97 23.97 0 0 1-16 0zM19 24v16.02a22 22 0 0 0 44 0V23.99a22 22 0 0 0-44 0zm5.9-8.04A18 18 0 0 1 41 6v1a17 17 0 0 0-15.2 9.4l-.9-.45zM81 98a16 16 0 1 0 0-32 16 16 0 0 0 0 32zM67.96 87.11A14 14 0 0 1 81 68v1a13 13 0 0 0-12.13 17.69l-.9.42zM87 80h3v10H72V80h3v-2a6 6 0 0 1 12 0v2zm-14 9h16v-6H73v6zm16-8H73v1h16v-1zm-3-1v-2a5 5 0 1 0-10 0v2h2v-2a3 3 0 1 1 6 0v2h2zm-3 0v-2a2 2 0 1 0-4 0v2h4z" ]
            []
        ]


mediaIcon : String -> String -> Html.Html msg
mediaIcon primary secondary =
    svg [ xmlSpace "http://www.w3.org/2000/svg", width "100", height "100", viewBox "0 0 100 100", class "heroicon-media-buttons heroicon heroicons-lg" ]
        [ path [ class "heroicon-media-buttons-play-circle heroicon-component-fill", d "M24 46a22 22 0 1 0 0-44 22 22 0 0 0 0 44z" ]
            []
        , path [ class "heroicon-media-buttons-pause-circle heroicon-component-fill", d "M76 46a22 22 0 1 0 0-44 22 22 0 0 0 0 44z" ]
            []
        , path [ class "heroicon-media-buttons-back-circle heroicon-component-fill", d "M24 98a22 22 0 1 0 0-44 22 22 0 0 0 0 44z" ]
            []
        , path [ class "heroicon-media-buttons-forward-circle heroicon-component-fill", d "M98 76a22 22 0 1 1-44 0 22 22 0 0 1 44 0z" ]
            []
        , polygon
            [ class "heroicon-media-buttons-play-symbol heroicon-component-accent heroicon-component-fill"
            , fillStyle primary
            , points "17 15.144 17 14 18 14.556 33.97 23.428 35 24 33.97 24.572 18 33.444 17 34 17 32.856"
            ]
            []
        , path
            [ class "heroicon-media-buttons-pause-symbol heroicon-component-accent heroicon-component-fill"
            , fillStyle primary
            , d "M69 14h5v20h-6V14h1zm9 0h6v20h-6V14z"
            ]
            []
        , path
            [ class "heroicon-media-buttons-back-symbol heroicon-component-accent heroicon-component-fill"
            , fillStyle secondary
            , d "M19 76.56V84h-4V68h4v8.56zm1.95.03L20 76l.95-.59L32 68.61l1-.61v16l-1-.62-11.05-6.8z"
            ]
            []
        , path
            [ class "heroicon-media-buttons-forward-symbol heroicon-component-accent heroicon-component-fill"
            , fillStyle secondary
            , d "M80 76l-.95.59L68 83.39 67 84V68l1 .62 11.05 6.8.95.58zm1 7V68h4v16h-4v-1z"
            ]
            []
        , path [ class "heroicon-shadows", d "M45.91 22a22 22 0 1 1-43.82 0 22 22 0 0 0 43.82 0zm52 0a22 22 0 1 1-43.82 0 22 22 0 0 0 43.82 0zm-52 52a22 22 0 1 1-43.82 0 22 22 0 0 0 43.82 0zm8.18 0a22 22 0 0 0 43.82 0 22 22 0 1 1-43.82 0z" ]
            []
        , path [ class "heroicon-outline", fillRule "nonzero", d "M48 24a24 24 0 1 1-48 0 24 24 0 0 1 48 0zM24 46a22 22 0 1 0 0-44 22 22 0 0 0 0 44zm0-40v1A17 17 0 0 0 8.8 31.6l-.9.45A18 18 0 0 1 24 6zm-7 9.14V14l1 .56 15.97 8.87L35 24l-1.03.57L18 33.44 17 34V15.14zM32.94 24L18 15.7v16.6L32.94 24zM100 24a24 24 0 1 1-48 0 24 24 0 0 1 48 0zM76 46a22 22 0 1 0 0-44 22 22 0 0 0 0 44zM58 24A18 18 0 0 1 76 6v1a17 17 0 0 0-15.2 24.6l-.9.45A17.93 17.93 0 0 1 58 24zm11-10h5v20h-6V14h1zm4 1h-4v18h4V15zm5-1h6v20h-6V14zm1 1v18h4V15h-4zM48 76a24 24 0 1 1-48 0 24 24 0 0 1 48 0zM24 98a22 22 0 1 0 0-44 22 22 0 0 0 0 44zM6 76a18 18 0 0 1 18-18v1A17 17 0 0 0 8.8 83.6l-.9.45A17.93 17.93 0 0 1 6 76zm13 .56V84h-4V68h4v8.56zM18 69h-2v14h2V69zm2.95 7.59L20 76l.95-.59L32 68.61l1-.61v16l-1-.62-11.05-6.8zm.96-.59L32 82.21V69.79L21.9 76zM76 100a24 24 0 1 1 0-48 24 24 0 0 1 0 48zm22-24a22 22 0 1 0-44 0 22 22 0 0 0 44 0zM76 58v1a17 17 0 0 0-15.2 24.6l-.9.45A18 18 0 0 1 76 58zm4 18l-.95.59L68 83.39 67 84V68l1 .62 11.05 6.8.95.58zm-12-6.21v12.42L78.1 76 68 69.79zM81 83V68h4v16h-4v-1zm1 0h2V69h-2v14z" ]
            []
        ]


headphonesIcon : String -> String -> Html.Html msg
headphonesIcon primary secondary =
    svg [ xmlSpace "http://www.w3.org/2000/svg", width "100", height "100", viewBox "0 0 100 100", class "heroicon-headphones heroicon heroicons-lg" ]
        [ path
            [ class "heroicon-headphones-strap heroicon-component-fill"
            , fillStyle secondary
            , d "M50 2a38 38 0 0 1 38 38v13.1a5.02 5.02 0 0 0-2 0V40a36 36 0 1 0-72 0v13.1a5.02 5.02 0 0 0-2 0V40A38 38 0 0 1 50 2zm33.68 59.74a5 5 0 0 0 1.74 1L80 72.12v-4l1.73-3 1.95-3.38zM20 72.12l-5.42-9.38a5 5 0 0 0 1.74-1l1.95 3.38 1.73 3v4z"
            ]
            []
        , path
            [ class "heroicon-headphones-strap-cushion heroicon-component-accent heroicon-component-fill"
            , fillStyle grey
            , d "M79.9 23.81a34 34 0 0 0-59.8 0l1.78.9a32 32 0 0 1 56.24 0l1.79-.9z"
            ]
            []
        , path
            [ class "heroicon-headphones-hinges heroicon-component-accent heroicon-component-fill"
            , fillStyle yellow
            , d "M13 62a4 4 0 1 1 0-8 4 4 0 0 1 0 8zm74 0a4 4 0 1 1 0-8 4 4 0 0 1 0 8z"
            ]
            []
        , path
            [ class "heroicon-headphones-ear-covers heroicon-component-fill"
            , fillStyle primary
            , d "M21 93V63h3l4-8h7v1h3a3 3 0 0 1 3 3v36a3 3 0 0 1-3 3h-3v1h-7l-4-6h-3zm58 0h-3l-4 6h-7v-1h-3a3 3 0 0 1-3-3V59a3 3 0 0 1 3-3h3v-1h7l4 8h3v30z"
            ]
            []
        , path
            [ class "heroicon-headphones-muffs heroicon-component-accent heroicon-component-fill"
            , fillStyle grey
            , d "M35 56h3a3 3 0 0 1 3 3v36a3 3 0 0 1-3 3h-3V56zm30 0v42h-3a3 3 0 0 1-3-3V59a3 3 0 0 1 3-3h3z"
            ]
            []
        , path [ class "heroicon-shadows", d "M30 80v-2h11v17a3 3 0 0 1-3 3h-3v1h-6.5L25 94v-1h-4V78h4v-3l5 5zm40 0l5-5v3h4v15h-4v1l-3.5 5H65v-1h-3a3 3 0 0 1-3-3V78h11v2zm9.9-56.19l-1.78.9a32 32 0 0 0-56.24 0l-1.79-.9-.05.1a34 34 0 0 1 59.87-.1z" ]
            []
        , path [ class "heroicon-outline", fillRule "nonzero", d "M90 40v14a5 5 0 0 1-2.4 8.96L80 76.12V94h-4l-3.4 5.1a2 2 0 0 1-1.67.9H65a1 1 0 0 1-1-1h-2a4 4 0 0 1-4-4V59a4 4 0 0 1 4-4h2a1 1 0 0 1 1-1h5.76a2 2 0 0 1 1.8 1.1L76 62h4v2.12L81.23 62l.77-1.34.4-.7A4.98 4.98 0 0 1 84 54V40c0-5.15-1.14-10.03-3.2-14.4l-1.78.9-1.8.89a30 30 0 0 0-54.45 0l-1.79-.9-1.79-.9A33.87 33.87 0 0 0 16 40v14a5 5 0 0 1 1.6 5.97l.4.69.77 1.34L20 64.12V62h4l3.45-6.9a2 2 0 0 1 1.79-1.1H35a1 1 0 0 1 1 1h2a4 4 0 0 1 4 4v36a4 4 0 0 1-4 4h-2a1 1 0 0 1-1 1h-5.93a2 2 0 0 1-1.66-.9L24 94h-4V76.12l-7.6-13.16A5 5 0 0 1 10 54V40a40 40 0 1 1 80 0zM50 2a38 38 0 0 0-38 38v13.1a5.02 5.02 0 0 1 2 0V40a36 36 0 1 1 72 0v13.1a5.02 5.02 0 0 1 2 0V40A38 38 0 0 0 50 2zm33.68 59.74l-1.95 3.38-1.73 3v4l5.42-9.38a5 5 0 0 1-1.74-1zm-3.77-37.93a34 34 0 0 0-59.82 0l1.8.9a32 32 0 0 1 56.23 0l1.79-.9zM30 56h-.76L26 62.47V93.4L29.07 98H30V56zm1 42h3V56h-3v42zM20 72.12v-4l-1.73-3-1.95-3.38a5 5 0 0 1-1.74 1L20 72.12zM36 57v40h2a2 2 0 0 0 2-2V59a2 2 0 0 0-2-2h-2zm-12 7h-2v28h2V64zm38-7a2 2 0 0 0-2 2v36c0 1.1.9 2 2 2h2V57h-2zm4 0v41h3V56h-3v1zm4 41h.93L74 93.4V62.46L70.76 56H70v42zm8-6V64h-2v28h2zM13 61a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm74 0a3 3 0 1 0 0-6 3 3 0 0 0 0 6z" ]
            []
        ]


pieIcon : String -> String -> Html.Html msg
pieIcon primary secondary =
    svg [ xmlSpace "http://www.w3.org/2000/svg", width "100", height "100", viewBox "0 0 100 100", class "heroicon-pie-chart heroicon heroicons-lg" ]
        [ path
            [ class "heroicon-pie-chart-slice-1 heroicon-component-fill"
            , fillStyle primary
            , d "M89.96 56H44V10.04A44 44 0 1 0 89.96 56z"
            ]
            []
        , path
            [ class "heroicon-pie-chart-slice-2 heroicon-component-accent heroicon-component-fill"
            , fillStyle yellow
            , d "M67.88 5.78L52 37.53V2.03a42.77 42.77 0 0 1 15.88 3.75z"
            ]
            []
        , path
            [ class "heroicon-pie-chart-slice-3 heroicon-component-accent heroicon-component-fill"
            , fillStyle secondary
            , d "M97.96 48a44 44 0 0 0-22.51-36.43L57.24 48h40.72z"
            ]
            []
        , path [ class "heroicon-shadows", d "M.01 55h.52a46.01 46.01 0 0 0 90.94 0H92A46 46 0 0 1 0 55zm59.23-11h38.35c.18 1.32.3 2.65.37 4H57.24l2-4z" ]
            []
        , path [ class "heroicon-outline", fillRule "nonzero", d "M92 54A46 46 0 1 1 46 8v46h46zM70.51 4.82l.07.03L52 42l-2 4V0a45.77 45.77 0 0 1 20.51 4.82zM99.96 48c.03.66.04 1.33.04 2H54l1-2 18.68-37.36.9-1.8c.6.3 1.18.62 1.77.94A46 46 0 0 1 99.94 48zm-10 8H44V10.04A44 44 0 1 0 89.96 56zM67.88 5.78A42.77 42.77 0 0 0 52 2.04v35.49L67.88 5.78zM97.96 48a44 44 0 0 0-22.51-36.43L57.24 48h40.72zM28.1 18.22l.44.89a39.17 39.17 0 0 0-17.44 17.44l-.9-.44a40.17 40.17 0 0 1 17.9-17.9zM6.16 50.38c.32-3.5 1.08-6.87 2.24-10.05l.94.34a38.79 38.79 0 0 0-2.18 9.8l-1-.1zm-.12 5.44l1-.05c.05 1.18.16 2.35.31 3.5l-.99.14a40.23 40.23 0 0 1-.32-3.6zM92 43v1H73v-1h19z" ]
            []
        ]


formIcon : String -> String -> Html.Html msg
formIcon primary secondary =
    svg [ xmlSpace "http://www.w3.org/2000/svg", width "100", height "100", viewBox "0 0 100 100", class "heroicon-form heroicon heroicons-lg" ]
        [ path
            [ class "heroicon-form-clipboard heroicon-component-accent heroicon-component-fill"
            , fillStyle brown
            , d "M0 16.01A6 6 0 0 1 6 10h66a6 6 0 0 1 6 6.01v77.98a6 6 0 0 1-6 6.01H6a6 6 0 0 1-6-6.01V16.01z"
            ]
            []
        , polygon [ class "heroicon-form-pages heroicon-component-fill", points "7 14 7 90 71 90 71 14" ]
            []
        , path
            [ class "heroicon-form-clip heroicon-component-accent heroicon-component-fill"
            , fillStyle silver
            , d "M24 8.9a39.7 39.7 0 0 1 7.1-2.12 8 8 0 0 1 15.8 0c2.46.5 4.83 1.2 7.1 2.13V19H24V8.9zM39 11a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"
            ]
            []
        , polygon [ class "heroicon-form-pen-housing heroicon-component-fill", points "90 22 99 22 99 25 96 25 96 79 93 90 90 79" ]
            []
        , path
            [ class "heroicon-form-pen-button heroicon-component-accent heroicon-component-fill"
            , fillStyle secondary
            , d "M90 15h5v7s4-.24 4 0v3h-9V15z"
            ]
            []
        , rect
            [ class "heroicon-form-pen-grip heroicon-component-accent heroicon-component-fill"
            , fillStyle primary
            , width "6"
            , height "24"
            , x "90"
            , y "55"
            ]
            []
        , path [ class "heroicon-shadows", d "M23 20h32v2H23v-2zM9 85h60v3H9v-3zM6 98a3.99 3.99 0 0 1-3.55-2.16c1 .73 2.22 1.16 3.54 1.16h66.02c1.32 0 2.55-.43 3.54-1.16A4 4 0 0 1 72.01 98H5.99z" ]
            []
        , path [ class "heroicon-outline", fillRule "nonzero", d "M55 9.33V10h17.16A6 6 0 0 1 78 16V93.99a6 6 0 0 1-6 6.01H6a6 6 0 0 1-6-6.01V16a6 6 0 0 1 6-6h17v-.67a39.7 39.7 0 0 1 8.1-2.55 8 8 0 0 1 15.8 0A39.7 39.7 0 0 1 55 9.33zM55 14h16v76H7V14h16v-2H6a4 4 0 0 0-4 4.01V94c.91 1.22 2.36 2 4 2h66c1.64 0 3.09-.78 4-2V16.01A4 4 0 0 0 72 12H55v2zM9 16v67h60V16H55v4H23v-4H9zm10.5 47a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5zm1.5-2.5a1.5 1.5 0 1 0-3 0 1.5 1.5 0 0 0 3 0zm5-.5h24v1H26v-1zm35 7v1H17v-1h44zm-20 6v1H17v-1h24zm-24-3h40v1H17v-1zm40-41v1H17v-1h40zm-40 3h42v1H17v-1zm24 3v1H17v-1h24zM25 17v1h28v-1H25zm0-1h28v-5.34a37.7 37.7 0 0 0-6.49-1.92l-1.37-.27-.2-1.39a6 6 0 0 0-11.87 0l-.21 1.39-1.37.27A37.7 37.7 0 0 0 25 10.66V16zm14-5a3 3 0 1 1 0-6 3 3 0 0 1 0 6zm2-3a2 2 0 1 0-4 0 2 2 0 0 0 4 0zM6 98h66a4 4 0 0 0 3.55-2.16A5.96 5.96 0 0 1 72.01 97H5.99a5.96 5.96 0 0 1-3.54-1.16c.67 1.28 2 2.16 3.54 2.16zm63-13H9v1h35v1H9v1h60v-1h-6v-1h6v-1zm21-69v-2h6v7h2a2 2 0 0 1 2 2v18a1 1 0 1 1-2 0V26h-1v53l-3 12h-2l-3-12V21h1v-5zm4 0h-2v5h2v-5zm-3 8h7v-1h-7v1zm4 1h-4v30h4V25zm-4 32h4v-1h-4v1zm4 20h-4v1h4v-1zm-2 9.75L94.94 79h-3.88L93 86.75zM95 76V58h-4v18h4zM26 54h24v1H26v-1zm-6.5 3a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5zm1.5-2.5a1.5 1.5 0 1 0-3 0 1.5 1.5 0 0 0 3 0zm5-6.5h24v1H26v-1zm-6.5 3a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5zm1.5-2.5a1.5 1.5 0 1 0-3 0 1.5 1.5 0 0 0 3 0zm5-6.5h24v1H26v-1zm-4 .5a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0zM19.5 44a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3zM17 26h44v1H17v-1z" ]
            []
        ]


idIcon : String -> String -> Html.Html msg
idIcon primary secondary =
    svg [ xmlSpace "http://www.w3.org/2000/svg", width "100", height "100", viewBox "0 0 100 100", class "heroicon-identification heroicon heroicons-lg" ]
        [ path
            [ class "heroicon-identification-top heroicon-component-accent heroicon-component-fill"
            , fillStyle secondary
            , d "M44 21H6a6 6 0 0 0-6 6v13h100V27a6 6 0 0 0-6-6H56v4a4 4 0 0 1 0 8H44a4 4 0 0 1 0-8v-4z"
            ]
            []
        , path
            [ class "heroicon-identification-clip heroicon-component-fill"
            , fillStyle silver
            , d "M44 11h12v18H44V11zm6 9a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"
            ]
            []
        , path
            [ class "heroicon-identification-card heroicon-component-fill"
            , fillStyle white
            , d "M0 40h100v43a6 6 0 0 1-6 6H6a6 6 0 0 1-6-6V40z"
            ]
            []
        , path
            [ class "heroicon-identification-photo-background heroicon-component-accent heroicon-component-fill"
            , fillStyle primary
            , d "M7 45v37h2v-8c0-1.1.8-2.4 1.8-2.9L17 68v-1.25A7 7 0 0 1 14 61v-4a7 7 0 1 1 14 0v4a7 7 0 0 1-3 5.75V68l6.2 3.1c1 .5 1.8 1.8 1.8 2.9v8h2V45H7z"
            ]
            []
        , path
            [ class "heroicon-identification-photo-user-top heroicon-component-fill"
            , fillStyle yellow
            , d "M17 68l-6.2 3.1C9.8 71.6 9 72.9 9 74v9h24v-9c0-1.1-.8-2.4-1.8-2.9L25 68v1a4 4 0 0 1-8 0v-1z"
            ]
            []
        , path
            [ class "heroicon-identification-photo-user-face heroicon-component-fill"
            , fillStyle rose
            , d "M25 66.74V69a4 4 0 0 1-8 0v-2.25A7 7 0 0 1 14 61v-4a7 7 0 0 1 14 0v4a7 7 0 0 1-3 5.74z"
            ]
            []
        , path [ class "heroicon-outline", fillRule "nonzero", d "M44 11h12v10h38a6 6 0 0 1 6 6v56a6 6 0 0 1-6 6H6a6 6 0 0 1-6-6V27a6 6 0 0 1 6-6h38V11zm2 2v14h8V13h-8zm-2 10H6a4 4 0 0 0-4 4v12h96V27a4 4 0 0 0-4-4H56v2a4 4 0 1 1 0 8H44a4 4 0 1 1 0-8v-2zm0 4a2 2 0 1 0 0 4h12a2 2 0 1 0 0-4v2H44v-2zm54 13H2v43a4 4 0 0 0 4 4h88a4 4 0 0 0 4-4V40zm-12 8v2H40v-2h46zm-10-4v2H40v-2h36zM40 82h10v1H40v-1zm12-2H40v-1h12v1zm0-4v1H40v-1h12zm16-12H40v-1h28v1zm-28-4h48v1H40v-1zm40-2H40v-1h40v1zm-4-4v1H40v-1h36zm-2 21h20v8H74v-8zm-45 8H6V44h30v39h-7zm18-66a3 3 0 1 1 6 0 3 3 0 0 1-6 0zm28 59v6h18v-6H75zm-57-8.67V69a3 3 0 0 0 6 0v-1.67c-1.9.9-4.1.9-6 0zM7 45v37h2v-8c0-1.1.8-2.4 1.8-2.9L17 68v-1.25A7 7 0 0 1 14 61v-4a7 7 0 1 1 14 0v4a7 7 0 0 1-3 5.75V68l6.2 3.1c1 .5 1.8 1.8 1.8 2.9v8h2V45H7zm45-28a2 2 0 1 0-4 0 2 2 0 0 0 4 0zM21 73a4 4 0 0 1-4-4v.12L11.24 72A2.56 2.56 0 0 0 10 74v8h2v-6h1v6h16v-6h1v6h2v-8c0-.72-.6-1.68-1.24-2L25 69.12V69a4 4 0 0 1-4 4zm6-16a6 6 0 1 0-12 0v4a6 6 0 1 0 12 0v-4z" ]
            []
        ]


compassIcon : Html.Html msg
compassIcon =
    svg [ xmlSpace "http://www.w3.org/2000/svg", width "150", height "150", viewBox "0 0 100 100", class "heroicon-compass heroicon heroicons-lg" ]
        [ path
            [ class "heroicon-compass-edge heroicon-component-accent heroicon-component-fill"
            , fillStyle gold
            , d "M50 99a49 49 0 1 1 0-98 49 49 0 0 1 0 98zm0-8a41 41 0 1 0 0-82 41 41 0 0 0 0 82z"
            ]
            []
        , circle
            [ class "heroicon-compass-background heroicon-component-fill"
            , fillStyle rose
            , cx "50"
            , cy "50"
            , r "40"
            ]
            []
        , path
            [ class "heroicon-compass-direction heroicon-component-fill"
            , fillStyle silver
            , d "M50 22.12l4.56 18.23-8.1 6.11-6.11 8.1L22.12 50l19.82-4.95-3.62-6.73 6.73 3.62L50 22.12zm3.54 31.42l6.11-8.1L77.88 50l-19.82 4.95 3.62 6.73-6.73-3.62L50 77.88l-4.56-18.23 8.1-6.11z"
            ]
            []
        , polygon
            [ class "heroicon-compass-needle heroicon-component-accent heroicon-component-fill"
            , fillStyle gold
            , points "47.892 47.892 34.824 65.176 52.108 52.108 65.176 34.824"
            ]
            []
        , path [ class "heroicon-shadows", d "M98.91 47a49 49 0 1 1-97.82 0 49 49 0 0 0 97.82 0zm-4.98 5.5a44 44 0 0 0-87.86 0 44 44 0 1 1 87.86 0z" ]
            []
        , path [ class "heroicon-outline", fillRule "nonzero", d "M50 100A50 50 0 1 1 50 0a50 50 0 0 1 0 100zm48-50a48 48 0 1 0-96 0 48 48 0 0 0 96 0zM50 94a44 44 0 1 1 0-88 44 44 0 0 1 0 88zm43-44a43 43 0 1 0-86 0 43 43 0 0 0 86 0zm-2 0a41 41 0 1 1-82 0 41 41 0 0 1 82 0zM50 89a39 39 0 1 0 0-78 39 39 0 0 0 0 78zm5.42-49.3l20.04-15.16L60.3 44.58 82 50l-22.45 5.61 4.6 8.53-8.54-4.6L50 82l-5.42-21.7-20.04 15.16L39.7 55.42 18 50l22.45-5.61-4.6-8.53 8.54 4.6L50 18l5.42 21.7zM50 22.11l-4.95 19.82-6.73-3.62 3.62 6.73L22.12 50l18.23 4.56 6.11-8.1 8.1-6.11L50 22.12zm3.54 31.42l-8.1 6.11L50 77.88l4.95-19.82 6.73 3.62-3.62-6.73L77.88 50l-18.23-4.56-6.11 8.1zm-5.65-5.65L34.82 65.18 52.11 52.1l13.07-17.29L47.89 47.9zM52 50a2 2 0 1 1-4 0 2 2 0 0 1 4 0z" ]
            []
        ]
