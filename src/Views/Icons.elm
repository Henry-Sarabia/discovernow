module Views.Icons exposing (..)

import Html
import Svg exposing (svg, path, rect, polygon)
import Svg.Attributes exposing (class, style, width, height, viewBox, d, fillRule, xmlSpace, points, x, y, rx)


fillStyle : String -> Svg.Attribute msg
fillStyle color =
    style ("fill: " ++ color)


lightbulb : String -> Html.Html msg
lightbulb color =
    svg [ xmlSpace "http://www.w3.org/2000/svg", width "100", height "100", viewBox "0 0 100 100", class "heroicon-lightbulb heroicon heroicons-lg" ]
        [ path [ class "heroicon-lightbulb-bulb heroicon-component-fill", d "M40 78h20a2 2 0 0 0 2-2v-6c0-1.63.84-3.67 2-4.83l.33-.33A33.75 33.75 0 0 1 58 67.05V65a31.97 31.97 0 0 0 24-31 32 32 0 1 0-40 31v2.06a33.74 33.74 0 0 1-6.33-2.2l.33.32c1.16 1.16 2 3.2 2 4.84v6c0 1.1.9 1.99 2 1.99z" ]
            []
        , path
            [ class "heroicon-lightbulb-screw heroicon-component-accent heroicon-component-fill"
            , fillStyle color
            , d "M40 79v4a2 2 0 1 0 0 4v2a2 2 0 1 0 0 4v1c0 1.1.8 2.4 1.8 2.9l4.4 2.2c1 .5 2.7.9 3.8.9 1.11 0 2.8-.4 3.8-.9l4.4-2.2c1-.5 1.8-1.8 1.8-2.9v-1a2 2 0 1 0 0-4v-2a2 2 0 1 0 0-4v-4H40z"
            ]
            []
        , path
            [ class "heroicon-lightbulb-source heroicon-component-accent heroicon-component-fill"
            , d "M52 52h.5a1.5 1.5 0 1 0 0-3h-5a1.5 1.5 0 1 0 0 3h.5v8.54A4 4 0 0 0 46 64V79h8V64a4 4 0 0 0-2-3.47V52z"
            , fillStyle color
            ]
            []
        , path [ class "heroicon-shadows", d "M76.35 55.49a34.2 34.2 0 0 1-3.77 3.93l-7.16 7.16A5.57 5.57 0 0 0 64 70.01v.24A27.87 27.87 0 0 1 50 74c-5.1 0-9.88-1.36-14-3.75v-.24c0-1.11-.63-2.64-1.42-3.43l-7.16-7.16a34.2 34.2 0 0 1-3.77-3.93A27.81 27.81 0 0 1 22.28 50a31.99 31.99 0 0 0 55.44 0c-.28 1.89-.74 3.72-1.37 5.48zM42 80h16v2H42v-2zm0 7h16v1H42v-1zm0 6h16v1H42v-1z" ]
            []
        , path [ class "heroicon-outline", fillRule "nonzero", d "M64 70v6a4 4 0 0 1-4 4v3a2 2 0 1 1 0 4v2a2 2 0 1 1 0 4v1c0 1.1-.8 2.4-1.8 2.9l-4.4 2.2c-1 .5-2.69.9-3.8.9-1.1 0-2.8-.4-3.8-.9l-4.4-2.2c-1-.5-1.8-1.8-1.8-2.9v-1a2 2 0 1 1 0-4v-2a2 2 0 1 1 0-4v-3a4 4 0 0 1-4-4v-6c0-1.1-.63-2.63-1.42-3.42l-7.16-7.16a34 34 0 1 1 45.16 0l-7.16 7.16A5.57 5.57 0 0 0 64 70.01zm-24 8h6V68L36 32h3v1h-1.68L46 64.26V64a4 4 0 0 1 2-3.47V52h-.5a1.5 1.5 0 0 1 0-3h5a1.5 1.5 0 0 1 0 3H52v8.54A4 4 0 0 1 54 64v.26L62.68 33H61v-1h3L54 68v10h6a2 2 0 0 0 2-2v-6c0-1.63.84-3.67 2-4.83l.33-.33A33.75 33.75 0 0 1 58 67.05V65a31.97 31.97 0 0 0 24-31 32 32 0 1 0-40 31v2.06a33.74 33.74 0 0 1-6.33-2.2l.33.32c1.16 1.16 2 3.2 2 4.84v6c0 1.1.9 1.99 2 1.99zM24.95 46.52A28 28 0 0 1 50 6v1a27 27 0 0 0-24.15 39.08l-.9.44zM41 33.56c-.28.14-.64.21-.99.21v-1c.2 0 .4-.03.55-.1L43 31.44a2.43 2.43 0 0 1 1.98 0l2.46 1.23c.29.14.81.14 1.1 0L51 31.44a2.43 2.43 0 0 1 1.98 0l2.46 1.23c.29.14.81.14 1.1 0L59 31.44c.28-.14.63-.21.99-.21v1c-.2 0-.4.03-.55.1L57 33.56c-.56.29-1.42.29-1.98 0l-2.46-1.23c-.29-.14-.81-.14-1.1 0L49 33.56c-.56.29-1.42.29-1.98 0l-2.46-1.23c-.29-.14-.81-.14-1.1 0L41 33.56zM39 91a1 1 0 0 0 1 1h20a1 1 0 1 0 0-2H40a1 1 0 0 0-1 1zm0-6a1 1 0 0 0 1 1h20a1 1 0 1 0 0-2H40a1 1 0 0 0-1 1zm3-2h16v-3H42v3zm7-5h2V64a1 1 0 1 0-2 0v14zm4-14a3 3 0 1 0-6 0v14h1V64a2 2 0 1 1 4 0v14h1V64zm-2-3.87V52h-2v8.13a4.01 4.01 0 0 1 2 0zM47.5 50a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zm-.4 47.31c.72.36 2.1.69 2.9.69.8 0 2.18-.33 2.9-.69l.63-.31h-7.06l.63.31zM58 89v-2H42v2h16zm-16 4v1c0 .35.37.95.69 1.1l1.78.9h11.06l1.78-.9c.32-.15.69-.75.69-1.1v-1H42z" ]
            []
        ]


buoy : String -> Html.Html msg
buoy color =
    svg [ xmlSpace "http://www.w3.org/2000/svg", width "100", height "100", viewBox "0 0 100 100", class "heroicon-buoy heroicon heroicons-lg" ]
        [ path
            [ class "heroicon-buoy-markers heroicon-component-accent heroicon-component-fill"
            , fillStyle color
            , d "M50 2c3.83 0 7.46.43 11 1.26l-6.48 23.17A25 25 0 0 0 50 26a25 25 0 0 0-4.52.43L38.99 3.26A47.22 47.22 0 0 1 50 2zM2 50c0-3.83.43-7.46 1.26-11l23.17 6.48A24.98 24.98 0 0 0 26 50c0 1.51.16 3.05.43 4.52L3.26 61.01A47.21 47.21 0 0 1 2 50zm96 0c0 3.83-.43 7.46-1.26 11l-23.17-6.48c.27-1.47.43-3 .43-4.52 0-1.51-.16-3.05-.43-4.52l23.17-6.49A47.21 47.21 0 0 1 98 50zM54.52 73.57l6.49 23.17A47.21 47.21 0 0 1 50 98c-3.83 0-7.46-.43-11-1.26l6.48-23.17A25 25 0 0 0 50 74a25 25 0 0 0 4.52-.43z"
            ]
            []
        , path [ class "heroicon-buoy-floater heroicon-component-fill", d "M57.01 24.96l5.4-19.27a46.1 46.1 0 0 1 31.9 31.9L75.04 43a26.05 26.05 0 0 0-18.03-18.03zm0 50.08a26.05 26.05 0 0 0 18.03-18.03l19.27 5.4a46.1 46.1 0 0 1-31.9 31.9L57 75.04zM24.96 57.01a26.05 26.05 0 0 0 18.03 18.03l-5.4 19.27A46.1 46.1 0 0 1 5.7 62.4L24.96 57zm18.03-32.05a26.05 26.05 0 0 0-18.03 18.03l-19.27-5.4A46.1 46.1 0 0 1 37.6 5.7L43 24.96z" ]
            []
        , path
            [ class "heroicon-buoy-rope heroicon-component-accent heroicon-component-fill"
            , fillStyle color
            , d "M97 36.84l-.77.21a47.6 47.6 0 0 0-.23-.8V22A18 18 0 0 0 78 4H63.76l-.81-.23.21-.77H78a19 19 0 0 1 19 19v14.84zM63.16 97l-.21-.77.8-.23H78a18 18 0 0 0 18-18V63.76l.23-.81.77.21V78a19 19 0 0 1-19 19H63.16zM3 63.16l.77-.21.23.8V78a18 18 0 0 0 18 18h14.24l.81.23-.21.77H22A19 19 0 0 1 3 78V63.16zm34.05-59.4l-.8.24H22A18 18 0 0 0 4 22v14.24l-.23.81-.77-.21V22A19 19 0 0 1 22 3h14.84l.21.77z"
            ]
            []
        , path [ class "heroicon-shadows", d "M93.11 62.07c.24-.62.46-1.25.66-1.89l1.03.29A46.07 46.07 0 0 1 60.47 94.8l-1.06-3.76a46.08 46.08 0 0 0 32.2-25.4l-17.88-5a25.8 25.8 0 0 0 1.31-3.63l18.07 5.06zm-86.22 0c-.24-.62-.46-1.25-.66-1.89l-1.03.29A46.07 46.07 0 0 0 39.53 94.8l1.06-3.76a46.08 46.08 0 0 1-32.2-25.4l17.88-5a25.8 25.8 0 0 1-1.31-3.63L6.89 62.07zM75.97 44.8a26.01 26.01 0 0 0-19.85-24.08l-1.05 3.77A26.03 26.03 0 0 1 75.5 44.93l.46-.13zm-51.94 0a26.01 26.01 0 0 1 19.85-24.08l1.05 3.77A26.03 26.03 0 0 0 24.5 44.93l-.46-.13zm32.09-24.08a26.07 26.07 0 0 0-12.24 0l1.6 5.71A25 25 0 0 1 50 26a25 25 0 0 1 4.52.43l1.6-5.7zm3.3 70.32a46.2 46.2 0 0 1-18.83 0l-1.6 5.7C42.54 97.57 46.17 98 50 98s7.46-.43 11-1.26l-1.59-5.7z" ]
            []
        , path [ class "heroicon-outline", fillRule "nonzero", d "M98 63.44V78a20 20 0 0 1-20 20H63.44l.05.16A49.55 49.55 0 0 1 50 100a50.14 50.14 0 0 1-13.48-1.84l.04-.16H22A20 20 0 0 1 2 78V63.44l-.16.04A49.64 49.64 0 0 1 0 50a50.13 50.13 0 0 1 1.84-13.48l.16.04V22A20 20 0 0 1 22 2h14.56l-.05-.16A49.64 49.64 0 0 1 50 0a50.14 50.14 0 0 1 13.48 1.84l-.04.16H78a20 20 0 0 1 20 20v14.56l.16-.04A49.55 49.55 0 0 1 100 50a50.13 50.13 0 0 1-1.84 13.48l-.16-.04zM50 2c-3.83 0-7.46.43-11 1.26l6.48 23.17A25 25 0 0 1 50 26a25 25 0 0 1 4.52.43l6.49-23.17A47.22 47.22 0 0 0 50 2zm7.01 22.96a26.05 26.05 0 0 1 18.03 18.03l19.27-5.4A46.1 46.1 0 0 0 62.4 5.7L57 24.96zM97 36.84V22A19 19 0 0 0 78 3H63.16l-.21.77.8.23H78a18 18 0 0 1 18 18v14.24l.23.81.77-.21zM95 22A17 17 0 0 0 78 5H66.74A48.15 48.15 0 0 1 95 33.26V22zm-38.53 4.88l-.54 1.93a22.02 22.02 0 0 0-11.86 0l-.54-1.93a24.05 24.05 0 0 0-16.65 16.65l1.93.54a22.02 22.02 0 0 0 0 11.86l-1.93.54a24.05 24.05 0 0 0 16.65 16.65l.54-1.93a22.02 22.02 0 0 0 11.86 0l.54 1.93a24.05 24.05 0 0 0 16.65-16.65l-1.93-.54a22.02 22.02 0 0 0 0-11.86l1.93-.54a24.05 24.05 0 0 0-16.65-16.65zm.54 48.16l5.4 19.27a46.1 46.1 0 0 0 31.9-31.9L75.04 57a26.05 26.05 0 0 1-18.03 18.03zM66.74 95H78a17 17 0 0 0 17-17V66.74A48.15 48.15 0 0 1 66.74 95zm-3.58 2H78a19 19 0 0 0 19-19V63.16l-.77-.21-.23.8V78a18 18 0 0 1-18 18H63.76l-.81.23.21.77zm-38.2-39.99l-19.27 5.4a46.1 46.1 0 0 0 31.9 31.9L43 75.04a26.05 26.05 0 0 1-18.03-18.03zM5 66.74V78a17 17 0 0 0 17 17h11.26A48.15 48.15 0 0 1 5 66.74zm-2-3.58V78a19 19 0 0 0 19 19h14.84l.21-.77-.8-.23H22A18 18 0 0 1 4 78V63.76l-.23-.81-.77.21zm39.99-38.2l-5.4-19.27A46.1 46.1 0 0 0 5.7 37.6L24.96 43a26.05 26.05 0 0 1 18.03-18.03zM33.26 5H22A17 17 0 0 0 5 22v11.26A48.15 48.15 0 0 1 33.26 5zm3.8-1.23L36.83 3H22A19 19 0 0 0 3 22v14.84l.77.21.23-.8V22A18 18 0 0 1 22 4h14.24l.81-.23zM2 50c0 3.83.43 7.46 1.26 11l23.17-6.48A24.98 24.98 0 0 1 26 50c0-1.51.16-3.05.43-4.52L3.26 38.99A47.21 47.21 0 0 0 2 50zm96 0c0-3.83-.43-7.46-1.26-11l-23.17 6.48c.27 1.47.43 3 .43 4.52 0 1.51-.16 3.05-.43 4.52l23.17 6.49A47.21 47.21 0 0 0 98 50zM54.52 73.57A25 25 0 0 1 50 74a25 25 0 0 1-4.52-.43l-6.49 23.17C42.54 97.57 46.17 98 50 98s7.46-.43 11-1.26l-6.48-23.17zM50 6c2.77 0 5.48.26 8.11.75l-.27.96a43.25 43.25 0 0 0-15.68 0l-.27-.96C44.52 6.25 47.23 6 50 6zM7.71 57.84l-.96.27a44.25 44.25 0 0 1 0-16.22l.96.27a43.24 43.24 0 0 0 0 15.68zM92.3 42.16l.96-.27a44.25 44.25 0 0 1 0 16.22l-.96-.27a43.25 43.25 0 0 0 0-15.68zM57.84 92.29l.27.96a44.24 44.24 0 0 1-16.22 0l.27-.96a43.24 43.24 0 0 0 15.68 0z" ]
            []
        ]


announcement : String -> Html.Html msg
announcement color =
    svg [ xmlSpace "http://www.w3.org/2000/svg", width "100", height "100", viewBox "0 0 100 100", class "heroicon-announcement heroicon heroicons-lg" ]
        [ path [ class "heroicon-announcement-bowl heroicon-component-fill", d "M88 9.98A82.6 82.6 0 0 1 46 26.6v28.78a82.6 82.6 0 0 1 42 16.63V9.98z" ]
            []
        , path
            [ class "heroicon-announcement-front heroicon-component-accent heroicon-component-fill"
            , fillStyle color
            , d "M94 36V4a2 2 0 0 0-2-2h-2v78h2a2 2 0 0 0 2-2V46h2a2 2 0 0 0 2-2v-6a2 2 0 0 0-2-2h-2z"
            ]
            []
        , polygon
            [ class "heroicon-announcement-middle heroicon-component-accent heroicon-component-fill"
            , fillStyle color
            , points "11 57 11 25 44 25 44 57 42 57 42 53 18 53 18.4 57"
            ]
            []
        , path
            [ class "heroicon-announcement-handle heroicon-component-accent heroicon-component-fill"
            , fillStyle color
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


maison : String -> Html.Html msg
maison color =
    svg [ xmlSpace "http://www.w3.org/2000/svg", width "100", height "100", viewBox "0 0 100 100", class "heroicon-home heroicon heroicons-lg" ]
        [ path [ class "heroicon-home-wall heroicon-component-fill", d "M8 50L50 8l42 42v48H8V50zm10 7v22h12V57H18zm52 0v22h12V57H70zM50 38a8 8 0 1 0 0-16 8 8 0 0 0 0 16z" ]
            []
        , polygon
            [ class "heroicon-home-roof heroicon-component-accent heroicon-component-fill"
            , fillStyle color
            , points "7 7 44.5 7 50 1.5 55 7 93 7 93 44 99 50 96 53 50 7 4 53 1 50 7 44"
            ]
            []
        , path
            [ class "heroicon-home-frames heroicon-component-accent heroicon-component-fill"
            , fillStyle color
            , d "M84 79h2v4H66v-4h2V55h16v24zm-52 0h2v4H14v-4h2V55h16v24zm8-24h20v36H40V55zm10-16a9 9 0 1 1 0-18 9 9 0 0 1 0 18zm2-12v1h4.71A7.01 7.01 0 0 0 52 23.29V27zm-8.71 1H48v-4.71A7.01 7.01 0 0 0 43.29 28zM48 36.71V32h-4.71A7.01 7.01 0 0 0 48 36.71zM56.71 32H52v4.71A7.01 7.01 0 0 0 56.71 32zM18 57v22h12V57H18zm52 0v22h12V57H70z"
            ]
            []
        , rect
            [ class "heroicon-home-door heroicon-component-accent heroicon-component-fill"
            , fillStyle color
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


ecran : String -> Html.Html msg
ecran color =
    svg [ xmlSpace "http://www.w3.org/2000/svg", width "100", height "100", viewBox "0 0 100 100", class "heroicon-monitor heroicon heroicons-lg" ]
        [ rect
            [ class "heroicon-monitor-edge heroicon-component-accent heroicon-component-fill"
            , fillStyle color
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
