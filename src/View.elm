module View exposing (..)

import Html exposing (Html, Attribute, text, div, h1, h2, h3, img, button, section, footer, span, a, i, iframe, nav)
import Html.Attributes exposing (src, class, href, height, width, alt)
import Html.Events exposing (onWithOptions, onClick)
import Json.Decode as Decode
import Models exposing (Model)
import Msgs exposing (Msg(..))
import Routing exposing (..)

view : Model -> Html Msg
view model =
    div 
        []
        [ page model ]


onLinkClick : Msg -> Attribute Msg
onLinkClick msg =
    let
        options =
            { stopPropagation = False
            , preventDefault = True
            }
    in
        onWithOptions "click" options (Decode.succeed msg)


page : Model -> Html Msg
page model =
    case model.route of
        HomeRoute ->
            homePage

        AboutRoute ->
            text "About Me"

        ResultsRoute maybeCode maybeState ->
            case (maybeCode, maybeState) of
                ( Just code, Just state ) ->
                    playlistButton code state

                ( Nothing, Just state ) ->
                    text "There is no code"

                ( Just code, Nothing ) ->
                    text "There is no state"

                ( Nothing, Nothing ) ->
                    text "There is no code or state"

        NotFoundRoute ->
            text "Not Found" 


playlistButton : String -> String -> Html Msg
playlistButton code state =
    a 
        [ class "button is-primary" 
        , onClick (FetchPlaylist code state)
        ]
        [ span 
            [ class "icon" ]
            [ i
                [ class "fab fa-spotify" ]
                []
            ]
        , span
            []
            [ text "Get Playlist" ]
        ]


homePage : Html Msg
homePage =
    hero

hero : Html Msg
hero =
    section
        [ class "hero is-primary is-fullheight" ]   
        [ heroHead
        , heroBody
        ] 


heroHead : Html Msg
heroHead =
    div
        [ class "hero-head" ]
        [ nav 
            [ class "navbar has-shadow" ]
            [ div 
                [ class "container" ]
                [ navBrand
                , navMenu
                ]
            ]
        ]


navBrand : Html Msg
navBrand =
    div 
        [ class "navbar-brand" ]
        [ a
            [ class "navbar-item" ]
            [ img
                [ src "http://localhost:3000/"
                , alt "Logo"
                ]
                []
            ]
        ]


navMenu : Html Msg
navMenu =
    div
        [ class "navbar-menu" ]
        [ div
            [ class "navbar-end" ]
            [ navItem "Home" homePath
            , navItem "About" aboutPath
            ]
        ]


navItem : String -> String -> Html Msg
navItem label path =
    a
        [ class "navbar-item"
        , href path
        , onLinkClick (ChangeLocation path)
        ]
        [ text label ]


heroBody : Html Msg
heroBody =
    div
        [ class "hero-body" ]
        [ div
            [ class "container has-text-centered" ]
            [ titleText "MyFy"
            , subtitleText "Generate your own personalized Spotify playlist"
            , spotifyButton "Get Started"
            ]
        ]


titleText : String -> Html Msg
titleText title =
    h1 
        [ class "title is-1 is-spaced" ]
        [ text title ]


subtitleText : String -> Html Msg
subtitleText sub =
    h2
        [ class "subtitle is-3" ]
        [ text sub ] 


spotifyButton : String -> Html Msg
spotifyButton label =
    a 
        [ class "button is-primary is-inverted is-outlined" 
        , onClick FetchLogin
        ]
        [ span 
            [ class "icon" ]
            [ i
                [ class "fab fa-spotify" ]
                []
            ]
        , span
            []
            [ text label ]
        ]

heroFoot : Html Msg
heroFoot =
    div
        [ class "hero-foot" ]
        [ ]
----------------------------------

-- header : Html Msg
-- header = 
--     section
--         [ class "hero is-primary is-medium is-bold" ]
--         [ div
--             [ class "hero-body" ]
--             [ div 
--                 [ class "container" ]
--                 [ h1
--                     [ class "title is-1" ]
--                     [text "MyFy" ]
--                 , h2
--                     [ class "subtitle" ]
--                     [text "Personalized Spotify Playlist" ]
--                 ]
--             ]
--         ]


-- body : Html Msg
-- body =
--     section
--         [ class "section " ]
--         [ div 
--             [ class "container" ]
--             [ h1
--                 [ class "title is-2" ]
--                 [ text "Generate your own personalized playlist"]
--             , h2
--                 [ class "subtitle" ]
--                 [text "Simply log in to Spotify"]
--             ]
--         ]



-------------------------------

-- body : Html Msg
-- body =
--     section
--         [ class "section" ]
--         [ div
--             [ class "container" ]
--             [ div
--                 [ class "columns" ]
--                 [ div
--                     [ class "column" ]
--                     [ card "Quote" "Author" ]
--                 , div
--                     [ class "column" ]
--                     [ card "Title" "Subtitle" ]
--                 , div
--                     [ class "column" ]
--                     [ card "H2" "H3" ]
--                 ]
--             ]
--         ]


-- card : String -> String -> Html Msg
-- card title subtitle =
--     div
--         [ class "card" ]
--         [ div
--             [ class "card-content" ]
--             [ h2
--                 [ class "title" ]
--                 [ text title ]
--             , h3
--                 [ class "subtitle" ]
--                 [ text subtitle ]
--             ]
--         , footer
--             [ class "card-footer" ]
--             [ span
--                 [ class "card-footer-item" ]
--                 [ a
--                     [ href "#"
--                     , class "button is-success"
--                     ]
--                     [ i
--                         [ class "fa fa-thumbs-o-up" ]
--                         []
--                     ]
--                 ]
--             , span
--                 [ class "card-footer-item" ]
--                 [ a
--                     [ href "#"
--                     , class "button is-danger"
--                     ]
--                     [ i
--                         [ class "fa fa-thumbs-o-down" ]
--                         []
--                     ]
--                 ]
--             , span
--                 [ class "card-footer-item" ]
--                 [ a
--                     [ href "#"
--                     , class "button is-info"
--                     ]
--                     [ i
--                         [ class "fa fa-retweet" ]
--                         []
--                     ]
--                 ]
--             ]
--         ]


-- playlist : Html Msg
-- playlist =
--     div
--         []
--         [ iframe
--             [ src "https://open.spotify.com/embed?uri=spotify%3Auser%3Aspotify%3Aplaylist%3A2PXdUld4Ueio2pHcB6sM8j"
--             , width 600
--             , height 700
--             ]
--             []
--         ]