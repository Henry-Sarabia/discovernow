module Views.Landing exposing (root)

import Html exposing (Html, div, text, h1, h2, nav, section, span, a, p, i)
import Html.Attributes exposing (class, style, alt, id, attribute)
import Html.Events exposing (onClick)
import Models exposing (Model, Login)
import Msgs exposing (Msg(..))
import RemoteData exposing (WebData)
import Views.Common exposing (..)


root : Model -> Html Msg
root model =
    div
        [ id "landing" ]
        [ heroBanner model
        , heroPhases model
        , heroFeatures
        ]


heroBanner : Model -> Html Msg
heroBanner model =
    section
        [ class "hero is-fullheight"
        , id "heroBanner"
        , style
            [ ( "background-image", "linear-gradient(rgba(0, 0, 0, 0.25), rgba(0, 0, 0, 0.25)), url(herobg2.jpg)" )
            , ( "background-position", "center" )
            , ( "background-repeat", "no-repeat" )
            , ( "background-size", "cover" )
            ]
        , onWheelScroll "heroBanner"
        ]
        [ heroBannerBody model
        , heroBannerFoot
        ]


heroBannerBody : Model -> Html Msg
heroBannerBody model =
    div
        [ class "hero-body" ]
        [ div
            [ class "container has-text-centered" ]
            [ bannerTitle "Discover Now"
            , bannerSub "Don't wait for Monday. Discover new music now."

            -- , stack
            --     [ loginButton (spotifyButton) model.login
            --     , scrollButton "heroPhases"
            --     ]
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

            -- , scrollButton "heroPhases"
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
        [ class "button is-info is-large is-rounded"

        -- , style [ ( "margin-top", "2rem" ) ]
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
        [ class "button is-medium is-link is-rounded is-inverted is-outlined"
        , onClick (ScrollToDomId domId)
        ]
        [ spanText "Learn more"
        ]


heroFeatures : Html Msg
heroFeatures =
    section
        [ class "hero is-warning is-medium"
        , id "heroFeatures"
        , onWheelScroll "heroFeatures"
        ]
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
        -- [ class "title is-size-4 is-spaced" ]
        [ class "title is-spaced"
        , style
            [ ( "font-size", "2em" )
            , ( "font-weight", "400" )
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


heroPhases : Model -> Html Msg
heroPhases model =
    section
        [ class "hero is-link is-fullheight"
        , id "heroPhases"
        , onWheelScroll "heroPhases"
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
                    [ largeIconColumn "animated wow fade-right-1"
                        ( userIcon
                        , "Connect"
                        , "Connect to your Spotify account using a secure connection provided by Spotify"
                        )
                    , level [ arrowIcon "animated wow fade-right-2" ]
                    , largeIconColumn "animated wow fade-right-3"
                        ( dnaIcon
                        , "Analyze"
                        , "Our algorithm will analyze and generate a personal Discover playlist just for you"
                        )
                    , level [ arrowIcon "animated wow fade-right-4" ]
                    , largeIconColumn "animated wow fade-right-5"
                        ( largeColorIcon "far fa-play-circle fa-10x fa-fw" "has-text-danger"
                        , "Discover"
                        , "Your personalized Discover playlist is ready for you right on your preferred Spotify player"
                        )
                    ]
                , loginButton (subSpotifyButton) model.login

                -- , stack
                --     [ phaseCall "Why wait? Discover now."
                --     , bouncingIcon "fas fa-chevron-down fa-5x"
                --     , loginButton (subSpotifyButton) model.login
                --     ]
                ]
            ]
        ]


phaseHeader : String -> Html Msg
phaseHeader txt =
    h1
        [ class "title animated wow fade-in"
        , attribute "data-wow-offset" "6"
        , style
            [ ( "padding-top", "6rem" )
            , ( "font-size", "7em" )
            , ( "font-weight", "200" )
            ]
        ]
        [ text txt ]


largeIconColumn : String -> ( Html Msg, String, String ) -> Html Msg
largeIconColumn classes ( ico, title, sub ) =
    div
        [ class ("column has-text-centered" ++ " " ++ classes)
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


dnaIcon : Html Msg
dnaIcon =
    span
        [ class "icon fa-fw fa-10x has-text-danger" ]
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


userIcon : Html Msg
userIcon =
    span
        [ class "icon fa-fw fa-10x has-text-danger" ]
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


subSpotifyButton : Msg -> Html Msg
subSpotifyButton msg =
    a
        -- [ class "button is-info is-large is-rounded"
        [ class "button is-info is-large is-rounded animated wow fade-in-pop"
        , onClick msg

        -- , id "call-to-action"
        ]
        [ icon "fab fa-spotify fa-lg"
        , iconText "Connect to Spotify"
        ]
