module Views.Landing exposing (root)

import Html exposing (Html, div, text, h1, h2, nav, section, span, a, p)
import Html.Attributes exposing (class, style, alt, id)
import Html.Events exposing (onClick)
import Models exposing (Model, Login)
import Msgs exposing (Msg(..))
import RemoteData exposing (WebData)
import Views.Common exposing (..)


root : Model -> Html Msg
root model =
    div
        []
        [ heroBanner model
        , heroFeatures
        , heroPhases model
        ]


heroBanner : Model -> Html Msg
heroBanner model =
    section
        [ class "hero is-large"
        , style
            [ ( "background-image", "linear-gradient(rgba(0, 0, 0, 0.25), rgba(0, 0, 0, 0.25)), url(herobg2.jpg)" )
            , ( "background-position", "center" )
            , ( "background-repeat", "no-repeat" )
            , ( "background-size", "cover" )
            ]
        ]
        [ heroBannerBody model ]


heroBannerBody : Model -> Html Msg
heroBannerBody model =
    div
        [ class "hero-body" ]
        [ div
            [ class "container has-text-centered" ]
            -- [ bannerTitle "Discover your new obsession"
            [ bannerTitle "Discover Now"

            -- , bannerSub "Analyze your Spotify data and create a Discover playlist instantly"
            , bannerSub "Don't wait for Monday. Discover new music now."
            , stack
                [ loginButton (spotifyButton) model.login
                , scrollButton "heroPhases"
                ]
            ]
        ]


bannerTitle : String -> Html Msg
bannerTitle title =
    h1
        [ class "title is-size-1 is-spaced has-text-light has-text-weight-normal" ]
        [ text title ]


bannerSub : String -> Html Msg
bannerSub sub =
    h2
        [ class "subtitle is-size-3 has-text-light has-text-weight-light" ]
        [ text sub ]


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
        [ class "button is-success is-large"
        , onClick msg
        ]
        [ icon "fab fa-spotify fa-lg"
        , iconText "Connect to Spotify"
        ]


iconText : String -> Html Msg
iconText txt =
    span
        [ style
            [ ( "padding-left", "0.33em" ) ]
        ]
        [ text txt ]


scrollButton : String -> Html Msg
scrollButton domId =
    a
        [ class "button is-info is-rounded is-inverted is-outlined"
        , onClick (ScrollToDomId domId)
        ]
        [ spanText "Learn more"
        ]


heroFeatures : Html Msg
heroFeatures =
    section
        [ class "hero is-warning is-medium" ]
        [ div
            [ class "hero-body" ]
            [ div
                [ class "container" ]
                [ nav
                    [ class "columns" ]
                    [ iconColumn "fab fa-github fa-5x fa-fw" "Open Source" "Honest code for honest users. Contributions are always appreciated - explore on GitHub"
                    , iconColumn "fab fa-spotify fa-5x fa-fw" "Simple Login" "You have enough accounts to worry about - connect to your existing Spotify account to log in"
                    , iconColumn "fas fa-unlock-alt fa-5x fa-fw" "Forever Free" "No ads, no analytics, no subscription - simply share and enjoy"
                    , iconColumn "fas fa-mobile-alt fa-5x fa-fw" "Responsive Design" "Designed for both desktop and mobile - for when you need new music on the go"
                    ]
                ]
            ]
        ]


iconColumn : String -> String -> String -> Html Msg
iconColumn link title sub =
    div
        [ class "column has-text-centered" ]
        [ largeIcon link
        , featureTitle title
        , featureSub sub
        ]


featureTitle : String -> Html Msg
featureTitle txt =
    p
        [ class "title is-size-4 is-spaced" ]
        [ text txt ]


featureSub : String -> Html Msg
featureSub txt =
    p
        [ class "subtitle"
        , style [ ( "line-height", "1.6" ) ]
        ]
        [ text txt ]


heroPhases : Model -> Html Msg
heroPhases model =
    section
        [ class "hero is-primary is-medium"
        , id "heroPhases"
        ]
        [ div
            [ class "hero-head has-text-centered" ]
            [ phaseHeader "How It Works" ]
        , div
            [ class "hero-body has-text-centered" ]
            [ div
                [ class "container" ]
                [ nav
                    [ class "columns" ]
                    [ largeIconColumn "fab fa-spotify fa-10x fa-fw" "Connect" "Connect to your Spotify account using a secure connection provided by Spotify"
                    , level [ largeIcon "fas fa-arrow-right fa-5x fa-fw" ]
                    , largeIconColumn "fas fa-chart-pie fa-10x fa-fw" "Analyze" "Our algorithm will analyze and generate a personal Discover playlist just for you"
                    , level [ largeIcon "fas fa-arrow-right fa-5x fa-fw" ]
                    , largeIconColumn "far fa-play-circle fa-10x fa-fw" "Discover" "Your personalized Discover playlist is ready for you right on your preferred Spotify player"
                    ]
                , stack
                    [ bouncingIcon "fas fa-chevron-down fa-5x"
                    , loginButton (subSpotifyButton) model.login
                    ]
                ]
            ]
        ]


phaseHeader : String -> Html Msg
phaseHeader txt =
    h1
        [ class "title is-size-1 has-text-weight-normal"
        , style [ ( "padding-top", "6rem" ) ]
        ]
        [ text txt ]


largeIconColumn : String -> String -> String -> Html Msg
largeIconColumn link title sub =
    div
        [ class "column has-text-centered" ]
        [ stack [ largeIcon link, phaseTitle title, phaseSub sub ]
        ]


phaseTitle : String -> Html Msg
phaseTitle txt =
    p
        [ class "title is-size-1 is-spaced has-text-weight-normal" ]
        [ text txt ]


phaseSub : String -> Html Msg
phaseSub txt =
    p
        [ class "subtitle is-size-3 has-text-weight-light" ]
        [ text txt ]


subSpotifyButton : Msg -> Html Msg
subSpotifyButton msg =
    a
        [ class "button is-success is-large is-inverted is-outlined"
        , onClick msg
        ]
        [ icon "fab fa-spotify fa-lg"
        , iconText "Connect to Spotify"
        ]
