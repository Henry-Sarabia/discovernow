module View exposing (..)

import Html exposing (Html, Attribute, text, div, h1, h2, h3, img, button, section, footer, span, a, i, iframe, nav, p)
import Html.Attributes exposing (src, style, class, href, height, width, alt)
import Html.Events exposing (onWithOptions, onClick)
import Json.Decode as Decode
import Landing.View as Landing
import Routing exposing (..)
import Types exposing (..)

root : Model -> Html Msg
root model =
    div 
        []
        [ navBar
        , page model
        ]


page : Model -> Html Msg
page model =
    case model.route of
        LandingRoute ->
            landingPage model

        AboutRoute ->
            aboutPage model

        ResultsRoute _ _ ->
            checkResults model

        NotFoundRoute ->
            notFoundPage


landingPage : Model -> Html Msg
landingPage model =
    div
        []
        [ Html.map LandingMsg (Landing.root model.landing) ]


aboutPage : Model -> Html Msg
aboutPage model =
    text "about me"


resultsPage : Model -> Html Msg
resultsPage model =
    div
        []
        [ text "results"]


notFoundPage : Html Msg
notFoundPage =
    div
        []
        [ text "404" ]

checkResults : Model -> Html Msg
checkResults model =
    case model.token of
        Nothing ->
            text "you found an error"
         
        Just token ->
            -- resultsPage token
            resultsPage model


navBar : Html Msg
navBar =
    nav
        [ class "navbar" ]
        [ navBrand
        , navMenu
        ]


navBrand : Html Msg
navBrand =
    div 
        [ class "navbar-brand" ]
        [ a
            [ class "navbar-item" ]
            [ img
                [ src "logoxx.png"
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


onLinkClick : Msg -> Attribute Msg
onLinkClick msg =
    let
        options =
            { stopPropagation = False
            , preventDefault = True
            }
    in
        onWithOptions "click" options (Decode.succeed msg)


-- resultsPage : Token -> Html Msg
-- resultsPage token =
--     hero heroHead (resultsBody token)


-- resultsBody : Token -> Html Msg
-- resultsBody token =
--     div
--         [ class "hero-body" ]
--         [ div
--             [ class "container has-text-centered" ]
--             [ titleText "Hello."
--             , subtitleText "I generate playlists based on what you like to listen to."
--             , subtitleText "How far back would you like me to analyze?"
--             , playlistPicker
--                 [ ("fas fa-hourglass-start", "Just a few weeks", FetchSummary token Short)
--                 , ("fas fa-hourglass-half", "At least a few months", FetchSummary token Medium)
--                 , ("fas fa-hourglass-end", "As far back as you can", FetchSummary token Long)
--                 ]
--             ]
--         ]


-- playlistPicker : List (String, String, Msg) -> Html Msg
-- playlistPicker options =
--     nav
--         [ class "field is-grouped is-grouped-centered" ] 
--         ( List.map playlistButton options )


-- playlistButton : (String, String, Msg) -> Html Msg
-- playlistButton (icon, name, msg) =
--     div
--         [ class "control" ]
--         [ a 
--             [ class "button is-primary is-inverted is-outlined is-large" 
--             , onClick msg
--             ]
--             [ span
--                 [ class "icon" ]
--                 [ i 
--                     [ class icon ]
--                     []
--                 ]
--             , span
--                 []
--                 [ text name ]
--             ]
--         ]


-- homePageTest : Html Msg
-- homePageTest =
--     div
--         []
--         [ navBar
--         , heroImage
--         , featureHero ]


-- heroImage : Html Msg
-- heroImage =
--     section
--         [ class "hero is-large"
--         , style 
--             [ ("background-image", "linear-gradient(rgba(0, 0, 0, 0.25), rgba(0, 0, 0, 0.25)), url(herobg2.jpg)")
--             , ("background-position", "center")
--             , ("background-repeat", "no-repeat")
--             , ("background-size", "cover")
--             ]
--         ]
--         [ homeBody
--         ]


-- homePage : Html Msg
-- homePage =
--     div
--         []
--         [ hero heroHead homeBody
--         , featureHero
--         ]


-- featureHero : Html Msg
-- featureHero =
--     section 
--         [ class "hero is-light"]
--         [ div
--             [ class "hero-body" ]
--             [ div
--                 [ class "container" ]
--                 [ nav 
--                     [ class "columns" ]
--                     [ iconColumn "fab fa-github fa-3x" "Open Source" "Check it out on GitHub"
--                     , iconColumn "fab fa-spotify fa-3x" "Simple Login" "Use your existing Spotify account"
--                     , iconColumn "fas fa-unlock-alt fa-3x" "Forever Free" "No ads, no analytics, no subscription"
--                     , iconColumn "fas fa-mobile-alt fa-3x" "Responsive Design" "Designed for desktop and mobile"
--                     ]
--                 ]
--             ]
--         ]


-- aboutPage : Html Msg
-- aboutPage =
--     hero heroHead homeBody


-- hero : Html Msg -> Html Msg -> Html Msg
-- hero head body=
--     section
--         [ class "hero is-primary is-fullheight" ]   
--         [ head
--         , body
--         ] 


-- heroHead : Html Msg
-- heroHead =
--     div
--         [ class "hero-head" ]
--         [ nav 
--             [ class "navbar has-shadow" ]
--             [ div 
--                 [ class "container" ]
--                 [ navBrand
--                 , navMenu
--                 ]
--             ]
--         ]


-- heroFoot : Html Msg
-- heroFoot =
--     div
--         [ class "hero-foot" ]
--         [ ]
----------------------------------

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