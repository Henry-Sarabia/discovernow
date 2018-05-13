module Views.Landing exposing (root)

import Html exposing (Html, div, text, h1, h2, nav, section, span, a, p, i, hr, article)
import Html.Attributes exposing (class, style, alt, id, attribute, href)
import Html.Events exposing (onClick)
import Models exposing (Model, Login)
import Msgs exposing (Msg(..))
import RemoteData exposing (WebData)
import Utils exposing (..)
import Views.Common exposing (..)
import Views.Header exposing (heroNavbar, navbar)
import Views.Footer exposing (heroFooter)


root : Model -> Html Msg
root model =
    div
        []
        [ banner model
        , features model
        , howto model
        ]


banner : Model -> Html Msg
banner model =
    section
        [ class "hero is-fullheight"
        , id "banner"
        , photoBackgroundStyle "images/cassette.jpg" 0.2

        -- , onWheelScroll "banner"
        ]
        [ desktopBanner model
        , mobileBanner model
        ]


desktopBanner : Model -> Html Msg
desktopBanner model =
    div
        [ class "hero-body is-hidden-touch"
        , style [ ( "margin-top", "-20rem" ) ]
        ]
        [ div
            [ class "container" ]
            [ titleSet model
            ]
        ]


mobileBanner : Model -> Html Msg
mobileBanner model =
    div
        [ class "hero-body is-hidden-desktop" ]
        [ div
            [ class "container" ]
            [ titleSet model
            ]
        ]


titleSet : Model -> Html Msg
titleSet model =
    div
        []
        [ bannerTitle "Discover Now"
        , bannerSub "Don't wait for Monday. Discover new music now."
        , buttonSet model
        , learnButton
        ]


bannerTitle : String -> Html Msg
bannerTitle title =
    h1
        [ class "title has-text-light has-text-weight-normal"
        , style [ ( "font-family", "Quicksand" ), ( "font-size", "4.2rem" ) ]

        -- , style [ ( "font-family", "Permanent Marker" ), ( "font-size", "6rem" ) ]
        ]
        [ text title ]


bannerSub : String -> Html Msg
bannerSub sub =
    h2
        [ class "subtitle is-size-3 has-text-light has-text-weight-light"
        , style [ ( "font-family", "Open Sans" ) ]
        ]
        [ text sub ]


buttonSet : Model -> Html Msg
buttonSet model =
    div
        [ class "buttons" ]
        [ githubButton
        , loginButton (spotifyButton) model.login
        ]


loginButton : (Msg -> Html Msg) -> WebData Login -> Html Msg
loginButton base login =
    case login of
        RemoteData.NotAsked ->
            base ForceFetchLogin

        RemoteData.Loading ->
            base ForceFetchLogin

        RemoteData.Success response ->
            base (LoadLogin response.url)

        RemoteData.Failure err ->
            base ForceFetchLogin


spotifyButton : Msg -> Html Msg
spotifyButton msg =
    a
        [ class "button is-primary is-medium"

        -- , style [ ( "margin-top", "2rem" ) ]
        , onClick msg
        ]
        [ icon "fab fa-spotify fa-lg"
        , iconText "Connect"
        ]


githubButton : Html Msg
githubButton =
    a
        -- [ class "button is-dark is-inverted is outlined" ]
        [ class "button is-medium is-dark is-outlined" ]
        [ icon "fab fa-github fa-lg"
        , iconText "Explore"
        ]


learnButton : Html Msg
learnButton =
    a
        [ class "button is-medium is-text is-paddingless" ]
        [ text "Learn more" ]


features : Model -> Html Msg
features model =
    section
        [ class "hero is-small is-light has-text-centered"
        ]
        [ div
            [ class "hero-body container"
            , style [ ( "padding-top", "4rem" ) ]
            ]
            [ div
                [ class "columns" ]
                [ div
                    -- [ class "column is-three-fifths is-offset-one-fifth" ]
                    [ class "column is-narrow" ]
                    [ boxedHeader "Designed with you in mind" ]
                ]
            , div
                [ class "columns" ]
                [ iconColumn "fab fa-github fa-5x fa-fw has-text-primary" "Open Source" "Honest code for honest users. Contributions are always appreciated - explore on GitHub"
                , iconColumn "fab fa-spotify fa-5x fa-fw has-text-primary" "Simple Login" "You have enough accounts to worry about - connect to your existing Spotify account to log in"
                , iconColumn "fas fa-unlock-alt fa-5x fa-fw has-text-primary" "Forever Free" "No ads, no analytics, no subscription - simply share and enjoy"
                , iconColumn "fas fa-mobile-alt fa-5x fa-fw has-text-primary" "Responsive Design" "Designed for both desktop and mobile - for when you need new music on the go"
                ]
            ]
        ]


iconColumn : String -> String -> String -> Html Msg
iconColumn link title sub =
    div
        [ class "column has-text-centered"
        , style [ ( "margin-top", "2.5rem" ), ( "padding", "1.5rem" ) ]
        ]
        [ largeIcon link
        , columnTitle title
        , columnSub sub
        ]


columnTitle : String -> Html Msg
columnTitle txt =
    p
        [ class "title is-spaced is-size-4 has-text-weight-normal"

        -- , style [ ( "font-family", "Quicksand" ) ]
        ]
        [ text txt ]


columnSub : String -> Html Msg
columnSub txt =
    p
        [ class "subtitle is-size-5"
        , style
            [ ( "line-height", "1.4" )
            , ( "font-family", "Quicksand" )
            ]
        ]
        [ text txt ]


howto : Model -> Html Msg
howto model =
    section
        [ class "hero is-small is-light has-text-centered" ]
        [ div
            [ class "hero-body container"
            , style [ ( "padding-bottom", "4rem" ) ]
            ]
            [ div
                [ class "columns" ]
                [ div
                    -- [ class "column is-three-fifths is-offset-one-fifth" ]
                    [ class "column is-narrow" ]
                    [ boxedHeader "How it all works" ]
                ]
            , div
                [ class "columns" ]
                [ largeIconColumn
                    ( userIcon
                    , "Connect"
                    , "Connect to your Spotify account using a secure connection provided by Spotify"
                    )
                , level [ arrowIcon ]
                , largeIconColumn
                    ( dnaIcon
                    , "Analyze"
                    , "Our algorithm will analyze and generate a personal Discover playlist just for you"
                    )
                , level [ arrowIcon ]
                , largeIconColumn
                    ( playIcon
                    , "Discover"
                    , "Your personalized Discover playlist is ready for you right on your preferred Spotify player"
                    )
                ]
            , loginButton (spotifyButton) model.login
            ]
        , div
            [ style [ ( "background-color", "#F0F0F0" ) ] ]
            [ heroFooter ]
        ]



-- boxedHeader : String -> Html Msg
-- boxedHeader txt =
--     div
--         [ class "title is-size-3 has-text-weight-normal"
--         , style
--             [ ( "border", "2px solid #5ed587" )
--             , ( "border-radius", "3px" )
--             , ( "padding", "0.75rem 1.25rem" )
--             , ( "font-family", "Quicksand" )
--             ]
--         ]
--         [ text txt ]


boxedHeader : String -> Html Msg
boxedHeader txt =
    article
        [ class "message is-dark has-text-left"
        , style [ ( "border-width", "0 0 0 4px" ), ( "border-radius", "4px" ), ( "border-style", "solid" ), ( "border-color", "#363636" ) ]
        ]
        [ div
            [ class "message-body" ]
            [ div
                [ class "title is-size-3 has-text-weight-normal"
                , style [ ( "font-family", "Quicksand" ) ]
                ]
                [ text txt ]
            ]
        ]


largeIconColumn : ( Html Msg, String, String ) -> Html Msg
largeIconColumn ( ico, title, sub ) =
    div
        [ class "column has-text-centered"

        -- , style
        --     [ ( "margin-top", "0rem" )
        --     , ( "border", "2px solid #5ed587" )
        --     , ( "border-radius", "5px" )
        --     ]
        ]
        [ ico
        , columnTitle title
        , columnSub sub
        ]


arrowIcon : Html Msg
arrowIcon =
    span
        []
        [ largeIcon "fas fa-angle-right fa-4x fa-fw" ]


userIcon : Html Msg
userIcon =
    span
        [ class "icon fa-fw fa-5x has-text-primary"
        , style
            [ ( "padding", "2.5rem" )

            -- , ( "border", "2px solid red" )
            ]
        ]
        [ span
            [ class "fa-layers fa-fw" ]
            [ i
                [ class "far fa-circle"
                , attribute "data-fa-transform" "left-7.8"
                ]
                []
            , i
                [ class "fas fa-user"
                , attribute "data-fa-transform" "shrink-8 left-7.8 up-0.5"
                ]
                []
            ]
        ]


dnaIcon : Html Msg
dnaIcon =
    span
        [ class "icon fa-fw fa-5x has-text-primary"
        , style
            [ ( "padding", "2.5rem" )

            -- , ( "border", "2px solid red" )
            ]
        ]
        [ span
            [ class "fa-layers fa-fw" ]
            [ i
                [ class "far fa-circle"
                , attribute "data-fa-transform" "left-7.8"
                ]
                []
            , i
                [ class "fas fa-dna"
                , attribute "data-fa-transform" "shrink-7 left-6.8"
                ]
                []
            ]
        ]


playIcon : Html Msg
playIcon =
    span
        [ class "icon has-text-primary"
        , style
            [ ( "padding", "2.5rem" )

            -- , ( "border", "2px solid red" )
            ]
        ]
        [ icon "far fa-play-circle fa-5x fa-fw "
        ]


subSpotifyButton : Msg -> Html Msg
subSpotifyButton msg =
    a
        [ class "button is-primary is-medium "
        , onClick msg
        ]
        [ icon "fab fa-spotify fa-lg"
        , iconText "Connect to Spotify"
        ]


testFoot : Html Msg
testFoot =
    div
        [ class "hero-foot" ]
        [ text "blah" ]



-- howto : Model -> Html Msg
-- howto model =
--     section
--         [ class "hero is-medium is-light has-text-centered" ]
--         [ div
--             [ class "hero-head container" ]
--             [ boxedHeader "How it all works" ]
--         , div
--             [ class "hero-body container" ]
--             [ div
--                 [ class "columns" ]
--                 [ largeIconColumn "fade-right-1"
--                     ( userIcon
--                     , "Connect"
--                     , "Connect to your Spotify account using a secure connection provided by Spotify"
--                     )
--                 , level [ arrowIcon "fade-right-2" ]
--                 , largeIconColumn "fade-right-3"
--                     ( dnaIcon
--                     , "Analyze"
--                     , "Our algorithm will analyze and generate a personal Discover playlist just for you"
--                     )
--                 , level [ arrowIcon "fade-right-4" ]
--                 , largeIconColumn "fade-right-5"
--                     ( playIcon
--                     , "Discover"
--                     , "Your personalized Discover playlist is ready for you right on your preferred Spotify player"
--                     )
--                 ]
--             , loginButton (subSpotifyButton) model.login
--             ]
--         ]
-- heroPhases : Model -> Html Msg
-- heroPhases model =
--     section
--         [ class "hero is-light is-fullheight"
--         , id "heroPhases"
--         -- , photoBackgroundStyle "images/lights.jpg" 0.3
--         -- , onWheelScroll "heroPhases"
--         ]
--         [ div
--             [ class "hero-head has-text-centered" ]
--             [ phaseHeader "How It Works" ]
--         , div
--             [ class "hero-body has-text-centered" ]
--             [ div
--                 [ class "container" ]
--                 [ div
--                     [ class "columns" ]
--                     [ largeIconColumn "pre-anim fade-right-1"
--                         ( userIcon
--                         , "Connect"
--                         , "Connect to your Spotify account using a secure connection provided by Spotify"
--                         )
--                     , level [ arrowIcon "pre-anim fade-right-2" ]
--                     , largeIconColumn "pre-anim fade-right-3"
--                         ( dnaIcon
--                         , "Analyze"
--                         , "Our algorithm will analyze and generate a personal Discover playlist just for you"
--                         )
--                     , level [ arrowIcon "pre-anim fade-right-4" ]
--                     , largeIconColumn "pre-anim fade-right-5"
--                         ( playIcon
--                         , "Discover"
--                         , "Your personalized Discover playlist is ready for you right on your preferred Spotify player"
--                         )
--                     ]
--                 , loginButton (subSpotifyButton) model.login
--                 ]
--             ]
--         ]
-- phaseHeader : String -> Html Msg
-- phaseHeader txt =
--     h1
--         [ class "title fade-in has-text-weight-light"
--         , style
--             [ ( "padding-top", "6rem" )
--             , ( "font-size", "6rem" )
--             , ( "font-family", "Quicksand" )
--             ]
--         ]
--         [ text txt ]
-- heroFeatures : Model -> Html Msg
-- heroFeatures model =
--     section
--         [ class "hero is-danger is-fullheight has-text-centered"
--         , id "heroFeatures"
--         , photoBackgroundStyle "images/city.jpg" 0.55
--         -- , onWheelScroll "heroFeatures"
--         ]
--         [ div
--             [ class "hero-head" ]
--             [ featureHeader "What's not to love?" ]
--         , div
--             [ class "hero-body" ]
--             [ div
--                 [ class "container" ]
--                 [ div
--                     [ class "columns" ]
--                     [ iconColumn "fab fa-github fa-5x fa-fw has-text-black-ter" "Open Source" "Honest code for honest users. Contributions are always appreciated - explore on GitHub"
--                     , iconColumn "fab fa-spotify fa-5x fa-fw has-text-success" "Simple Login" "You have enough accounts to worry about - connect to your existing Spotify account to log in"
--                     , iconColumn "fas fa-unlock-alt fa-5x fa-fw has-text-danger" "Forever Free" "No ads, no analytics, no subscription - simply share and enjoy"
--                     , iconColumn "fas fa-mobile-alt fa-5x fa-fw has-text-black-bis" "Responsive Design" "Designed for both desktop and mobile - for when you need new music on the go"
--                     ]
--                 , loginButton (spotifyButton) model.login
--                 ]
--             ]
--         , heroFooter
--         ]
