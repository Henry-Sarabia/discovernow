module Views.Landing exposing (root)

import Html exposing (Html, div, text, h1, h2, nav, section, span, a, p, i, hr)
import Html.Attributes exposing (class, style, alt, id, attribute, href)
import Html.Events exposing (onClick)
import Models exposing (Model, Login)
import Msgs exposing (Msg(..))
import RemoteData exposing (WebData)
import Utils exposing (..)
import Views.Common exposing (..)
import Views.Header exposing (heroNavbar)
import Views.Footer exposing (heroFooter)


root : Model -> Html Msg
root model =
    div
        [ id "landing" ]
        [ heroBanner model
        , heroPhases model
        , heroFeatures model
        ]


heroBanner : Model -> Html Msg
heroBanner model =
    section
        [ class "hero is-fullheight"
        , id "heroBanner"
        , photoBackgroundStyle "images/record.jpg" 0.35
        , onWheelScroll "heroBanner"
        ]
        [ heroNavbar
        , heroBannerBody model
        , heroBannerFoot
        ]


heroBannerBody : Model -> Html Msg
heroBannerBody model =
    div
        [ class "hero-body has-text-light" ]
        [ div
            [ class "container has-text-centered" ]
            [ bannerTitle "Discover Now"
            , bannerSub "Don't wait for Monday. Discover new music now."
            , bannerButtons model
            ]
        ]


heroBannerFoot : Html Msg
heroBannerFoot =
    div
        [ class "hero-foot has-text-light has-text-centered" ]
        [ bouncingIcon "fas fa-chevron-down fa-3x" ]


bannerButtons : Model -> Html Msg
bannerButtons model =
    div
        [ style [ ( "padding-top", "5rem" ) ] ]
        [ stack
            [ loginButton (spotifyButton) model.login
            ]
        ]


bannerTitle : String -> Html Msg
bannerTitle title =
    h1
        -- [ class "title is-size-1 is-spaced has-text-light has-text-weight-normal" ]
        [ class "title has-text-light is-spaced"
        , style
            [ ( "font-size", "8em" )
            , ( "font-weight", "200" )
            , ( "font-family", "Quicksand" )
            ]
        ]
        [ text title ]


bannerSub : String -> Html Msg
bannerSub sub =
    h2
        -- [ class "subtitle is-size-3 has-text-light has-text-weight-light" ]
        [ class "subtitle has-text-light"
        , style
            [ ( "font-size", "3em" )
            , ( "font-weight", "200" )

            -- , ( "font-family", "Quicksand" )
            ]
        ]
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
        [ class "button is-primary is-large is-rounded"
        , onClick msg
        ]
        [ icon "fab fa-spotify fa-lg"
        , iconText "Connect to Spotify"
        ]


heroPhases : Model -> Html Msg
heroPhases model =
    section
        [ class "hero is-dark is-fullheight"
        , id "heroPhases"
        , photoBackgroundStyle "images/lights.jpg" 0.3
        , onWheelScroll "heroPhases"
        ]
        [ div
            [ class "hero-head has-text-centered" ]
            [ phaseHeader "How It Works" ]
        , div
            [ class "hero-body has-text-centered" ]
            [ div
                [ class "container" ]
                [ div
                    [ class "columns" ]
                    [ largeIconColumn "pre-anim fade-right-1"
                        ( userIcon
                        , "Connect"
                        , "Connect to your Spotify account using a secure connection provided by Spotify"
                        )
                    , level [ arrowIcon "pre-anim fade-right-2" ]
                    , largeIconColumn "pre-anim fade-right-3"
                        ( dnaIcon
                        , "Analyze"
                        , "Our algorithm will analyze and generate a personal Discover playlist just for you"
                        )
                    , level [ arrowIcon "pre-anim fade-right-4" ]
                    , largeIconColumn "pre-anim fade-right-5"
                        ( playIcon
                        , "Discover"
                        , "Your personalized Discover playlist is ready for you right on your preferred Spotify player"
                        )
                    ]
                , loginButton (subSpotifyButton) model.login
                ]
            ]
        ]


phaseHeader : String -> Html Msg
phaseHeader txt =
    h1
        [ class "title pre-anim fade-in"
        , style
            [ ( "padding-top", "6rem" )
            , ( "font-size", "7em" )
            , ( "font-weight", "200" )
            , ( "font-family", "Quicksand" )
            ]
        ]
        [ text txt ]


largeIconColumn : String -> ( Html Msg, String, String ) -> Html Msg
largeIconColumn classes ( ico, title, sub ) =
    div
        [ class ("column has-text-centered" ++ " " ++ classes)

        -- , style [ ( "font-family", "Quicksand" ) ]
        ]
        [ stack [ ico, phaseTitle title, phaseSub sub ]
        ]


phaseTitle : String -> Html Msg
phaseTitle txt =
    p
        -- [ class "title is-size-1 is-spaced has-text-weight-bold" ]
        [ class "title is-spaced is-paddingless"
        , style
            [ ( "font-size", "4em" )
            , ( "font-weight", "300" )
            , ( "font-family", "Quicksand" )
            ]
        ]
        [ text txt ]


phaseSub : String -> Html Msg
phaseSub txt =
    p
        -- [ class "subtitle is-size-3 has-text-weight-light" ]
        [ class "subtitle"
        , style
            [ ( "font-size", "2em" )
            , ( "font-weight", "300" )

            -- , ( "font-family", "Quicksand" )
            ]
        ]
        [ text txt ]


phaseCall : String -> Html Msg
phaseCall txt =
    h2
        [ class "title"
        , style
            [ ( "font-size", "2.5em" )
            , ( "font-weight", "300" )
            ]
        ]
        [ text txt ]


arrowIcon : String -> Html Msg
arrowIcon classes =
    span
        [ class classes
        , style [ ( "margin-bottom", "2rem" ) ]
        ]
        [ largeIcon "fas fa-arrow-right fa-5x fa-fw" ]


userIcon : Html Msg
userIcon =
    span
        [ class "icon fa-fw fa-10x has-text-primary" ]
        [ span
            [ class "fa-layers fa-fw" ]
            [ i
                [ class "far fa-circle"
                , attribute "data-fa-transform" "left-7"
                ]
                []
            , i
                [ class "fas fa-user"
                , attribute "data-fa-transform" "shrink-8 left-7 up-0.5"
                ]
                []
            ]
        ]


dnaIcon : Html Msg
dnaIcon =
    span
        [ class "icon fa-fw fa-10x has-text-primary" ]
        [ span
            [ class "fa-layers fa-fw" ]
            [ i
                [ class "far fa-circle"
                , attribute "data-fa-transform" "left-7"
                ]
                []
            , i
                [ class "fas fa-dna"
                , attribute "data-fa-transform" "shrink-7 left-6"
                ]
                []
            ]
        ]


playIcon : Html Msg
playIcon =
    icon ("far fa-play-circle fa-10x fa-fw " ++ "has-text-primary")


subSpotifyButton : Msg -> Html Msg
subSpotifyButton msg =
    a
        [ class "button is-primary is-large is-rounded pre-anim fade-in-pop"
        , onClick msg
        ]
        [ icon "fab fa-spotify fa-lg"
        , iconText "Connect to Spotify"
        ]


heroFeatures : Model -> Html Msg
heroFeatures model =
    section
        [ class "hero is-danger is-fullheight has-text-centered"
        , id "heroFeatures"
        , photoBackgroundStyle "images/city.jpg" 0.55
        , onWheelScroll "heroFeatures"
        ]
        [ div
            [ class "hero-head" ]
            [ featureHeader "What's not to love?" ]
        , div
            [ class "hero-body" ]
            [ div
                [ class "container" ]
                [ div
                    [ class "columns" ]
                    [ iconColumn "fab fa-github fa-5x fa-fw has-text-black-ter" "Open Source" "Honest code for honest users. Contributions are always appreciated - explore on GitHub"
                    , iconColumn "fab fa-spotify fa-5x fa-fw has-text-success" "Simple Login" "You have enough accounts to worry about - connect to your existing Spotify account to log in"
                    , iconColumn "fas fa-unlock-alt fa-5x fa-fw has-text-danger" "Forever Free" "No ads, no analytics, no subscription - simply share and enjoy"
                    , iconColumn "fas fa-mobile-alt fa-5x fa-fw has-text-black-bis" "Responsive Design" "Designed for both desktop and mobile - for when you need new music on the go"
                    ]
                , loginButton (outlinedSpotifyButton) model.login
                ]
            ]
        , heroFooter
        ]


iconColumn : String -> String -> String -> Html Msg
iconColumn link title sub =
    div
        [ class "column has-text-centered" ]
        [ largeIcon link
        , featureTitle title
        , featureSub sub
        ]


featureHeader : String -> Html Msg
featureHeader txt =
    h1
        [ class "title"
        , style
            [ ( "padding-top", "6rem" )
            , ( "font-size", "7em" )
            , ( "font-weight", "200" )
            , ( "font-family", "Quicksand" )
            ]
        ]
        [ text txt ]


featureTitle : String -> Html Msg
featureTitle txt =
    p
        -- [ class "title is-size-4 is-spaced" ]
        [ class "title is-spaced"
        , style
            [ ( "font-size", "2em" )
            , ( "font-weight", "bold" )
            , ( "font-family", "Quicksand" )
            ]
        ]
        [ text txt ]


featureSub : String -> Html Msg
featureSub txt =
    p
        [ class "subtitle"

        --"is-5"
        , style
            [ ( "line-height", "1.6" )
            ]
        ]
        [ text txt ]


outlinedSpotifyButton : Msg -> Html Msg
outlinedSpotifyButton msg =
    a
        [ class "button is-primary is-large is-rounded"
        , style [ ( "border", "2px" ) ]
        , onClick msg
        ]
        [ icon "fab fa-spotify fa-lg"
        , iconText "Connect to Spotify"
        ]
