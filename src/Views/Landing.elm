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
            [ bannerTitle "Discover your new obsession"
            , bannerSub "Analyze your Spotify data and create a Discover playlist instantly"
            , stack
                [ loginButton (spotifyButton) model.login
                , scrollButton "heroPhases"
                ]
            ]
        ]


bannerTitle : String -> Html Msg
bannerTitle title =
    h1
        [ class "title is-size-1 is-spaced has-text-light has-text-weight-light" ]
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
        [ spanText "How It Works"
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
                    [ iconColumn "far fa-address-card fa-5x" "Taste Summary" "Analyze weeks, months, or up to years of data and generate playlists that exemplify your distinct taste in music"
                    , iconColumn "fas fa-search fa-5x" "Discover Now" "No need to wait a week, get an automatically curated discover playlist right now"
                    , iconColumn "fab fa-spotify fa-5x" "Simple Login" "You have enough accounts to worry about - use your existing Spotify account to log in"
                    , iconColumn "fas fa-unlock-alt fa-5x" "Forever Free" "No ads, no analytics, no subscription - simply share and enjoy"
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
            [ class "hero-body has-text-centered" ]
            [ div
                [ class "container" ]
                [ phaseTitle "How It Works"
                , spacer (text "")
                , nav
                    [ class "level" ]
                    [ largeIconColumn "fab fa-spotify fa-10x fa-fw" "Connect" "Connect to your Spotify account"
                    , level [ largeIcon "fas fa-arrow-right fa-5x fa-fw" ]
                    , largeIconColumn "fas fa-chart-pie fa-10x fa-fw" "Analyze" "Analyze your preferences"
                    , level [ largeIcon "fas fa-arrow-right fa-5x fa-fw" ]
                    , largeIconColumn "far fa-play-circle fa-10x fa-fw" "Discover" "Discover a new obsession"
                    ]
                , spacer (loginButton (subSpotifyButton) model.login)
                ]
            ]
        ]


largeIconColumn : String -> String -> String -> Html Msg
largeIconColumn link title sub =
    div
        [ class "level-item has-text-centered" ]
        [ stack [ largeIcon link, phaseTitle title, phaseSub sub ]
        ]


phaseTitle : String -> Html Msg
phaseTitle txt =
    p
        [ class "title is-size-2 is-spaced" ]
        [ text txt ]


phaseSub : String -> Html Msg
phaseSub txt =
    p
        [ class "subtitle is-size-4 has-text-weight-light" ]
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
