module Views.Landing exposing (root)

import Html exposing (Html, div, text, h1, h2, nav, section, span, a, p, i, hr, article, figure, img)
import Html.Attributes exposing (class, style, alt, id, attribute, href, src)
import Html.Events exposing (onClick)
import Models exposing (Model, Login)
import Msgs exposing (Msg(..))
import RemoteData exposing (WebData)
import Routing exposing (aboutPath)
import Utils exposing (..)
import Views.Common exposing (..)
import Views.Header exposing (heroNavbar, navbar)
import Views.Footer exposing (heroFooter, simpleFooter)
import Views.Icons exposing (..)


root : Model -> Html Msg
root model =
    div
        []
        [ splash model
        , features model
        , callToActionTop model "Ready to get started?"
        , summary model
        , origin
        , callToActionBot model "It's time to discover."
        , emptyHero
        , simpleFooter
        ]


emptyHero : Html Msg
emptyHero =
    section
        [ class "hero is-small is-light" ]
        [ div
            [ class "hero-body" ]
            []
        ]


splash : Model -> Html Msg
splash model =
    section
        [ class "hero is-fullheight"
        , id "splash"
        , photoBackgroundStyle "images/cassette.jpg" 0.2

        -- , onWheelScroll "splash"
        ]
        [ desktopSplash model
        , mobileSplash model
        ]


desktopSplash : Model -> Html Msg
desktopSplash model =
    div
        [ class "hero-body is-hidden-touch"
        , style [ ( "margin-top", "-20rem" ) ]
        ]
        [ div
            [ class "container" ]
            [ titleSet model ]
        ]


mobileSplash : Model -> Html Msg
mobileSplash model =
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
        [ splashSub "Don't wait for Monday."
        , splashTitle "Discover Now"
        , buttonSet model
        , scrollButton "features" "Learn more"
        ]


splashTitle : String -> Html Msg
splashTitle txt =
    h1
        [ class "title has-text-grey-darker"
        , style [ ( "font-family", "Permanent Marker" ), ( "font-size", "6rem" ), ( "padding-bottom", "1rem" ) ]
        ]
        [ text txt ]


splashSub : String -> Html Msg
splashSub txt =
    h2
        [ class "subtitle is-size-3  has-text-grey-dark"
        , style [ ( "margin-bottom", "0.75rem" ), ( "font-family", "Quicksand" ), ( "font-weight", "500" ) ]
        ]
        [ text txt ]


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
        [ class "button is-medium is-dark is-outlined"
        , href "https://github.com/Henry-Sarabia/myfy"
        ]
        [ icon "fab fa-github fa-lg"
        , iconText "Explore"
        ]


scrollButton : String -> String -> Html Msg
scrollButton domId label =
    a
        [ class "button is-medium is-text is-paddingless"
        , onClick (ScrollToDomId domId)
        ]
        [ text label ]



-- TODO add github link


features : Model -> Html Msg
features model =
    section
        [ class "hero is-small is-light"
        , id "features"

        -- , style [ ( "border", "2px solid red" ) ]
        ]
        [ div
            [ class "hero-body container"
            , style [ ( "padding-top", "2rem" ), ( "padding-bottom", "4rem" ) ]
            ]
            [ bodyHeader "Features"
            , columns
                [ verticalCard green
                    ( lightbulb
                    , "Explore the open source code"
                    , "The complete project is hosted on GitHub for your viewing pleasure. Take a quick peek to see what keeps discovery ticking."
                    )
                , verticalCard blue
                    ( buoy
                    , "Log in with ease and confidence"
                    , "You have enough accounts to worry about. Simply connect to your existing Spotify account to get started quickly and easily."
                    )
                , verticalCard red
                    ( announcement
                    , "Enjoy with no strings attached"
                    , "Discover new music for free. No advertisements. No analytics. No subscriptions. Simply share and enjoy the discovery."
                    )
                , verticalCard yellow
                    ( maison
                    , "Discover anytime and anywhere"
                    , "Designed from the ground up to offer a smooth experience for desktop, mobile, and everything in between. We're ready when you are."
                    )
                ]
            ]
        ]


verticalCard : String -> ( String -> Html Msg, String, String ) -> Html Msg
verticalCard color ( ico, title, txt ) =
    div
        [ class "card"
        , style
            [ ( "padding", "1rem" ) ]
        , boxShadowStyle
        , accentBorderStyle "top" color
        ]
        [ div
            [ class "card-image has-text-centered" ]
            [ div
                [ style [ ( "padding-top", "1rem" ) ] ]
                [ ico color ]
            ]
        , div
            [ class "card-content" ]
            [ bodyTitle title
            , bodyText txt
            ]
        ]


bodyHeader : String -> Html Msg
bodyHeader txt =
    h2
        [ class "title is-size-3  has-text-grey-dark"
        , style
            [ ( "margin-bottom", "0.75rem" )
            , ( "font-family", "Quicksand" )
            , ( "font-weight", "500" )
            , ( "padding", "1rem 1rem 1rem 0" )
            ]
        ]
        [ text txt ]


bodyTitle : String -> Html Msg
bodyTitle txt =
    p
        [ class "title is-size-5 has-text-grey-dark"

        -- , style [ ( "font-family", "Roboto" ) ]
        , style [ ( "font-family", "Quicksand" ), ( "font-weight", "500" ) ]
        ]
        [ text txt ]


bodyText : String -> Html Msg
bodyText txt =
    p
        [ class "is-size-6 has-text-left has-text-weight-normal"
        , style
            [ ( "line-height", "1.6em" )
            , ( "color", "#707070" )

            -- , ( "font-family", "Quicksand" )
            ]
        ]
        [ text txt ]


summary : Model -> Html Msg
summary model =
    section
        [ class "hero is-small is-white" ]
        [ div
            [ class "hero-body container" ]
            [ bodyHeader "How it works"
            , columns
                [ accentCard red
                    ( lightbulb
                    , "1. Connect to Spotify"
                    , "You can rest assured that your information is safe with all authentication being handled directly by Spotify."
                    )
                , accentCard yellow
                    ( ecran
                    , "2. Analyze your interests"
                    , "Our algorithm will analyze your playback history to establish your recent musical interests and generate a unique playlist just for you."
                    )
                , accentCard green
                    ( announcement
                    , "3. Discover new music"
                    , "Your discover playlist will be automatically be added to your account for your to enjoy. Enjoy and discover something new."
                    )
                ]
            ]
        ]


accentCard : String -> ( String -> Html Msg, String, String ) -> Html Msg
accentCard color ( ico, title, txt ) =
    div
        []
        [ div
            [ class "card"
            , style
                [ ( "padding", "1rem" )
                , ( "box-shadow", "0 0 0 0" )
                ]
            , accentBorderStyle "left" color
            ]
            [ bodyTitle title ]
        , div
            [ class "card"
            , style
                [ ( "padding", "1rem" )
                , ( "box-shadow", "0 0 0 0" )
                ]
            ]
            [ bodyText txt ]
        ]


horizontalCard : ( Html Msg, String, String ) -> Html Msg
horizontalCard ( ico, title, txt ) =
    div
        [ class "card"
        , style
            [ ( "margin-bottom", "2rem" )

            -- , ( "padding", "1rem" )
            ]
        , accentBorderStyle "left" green
        , boxShadowStyle
        ]
        [ div
            [ class "card-content" ]
            [ stepMedia ( ico, title, txt )
            ]
        ]


stepMedia : ( Html Msg, String, String ) -> Html Msg
stepMedia ( ico, title, txt ) =
    article
        [ class "media" ]
        [ div
            [ class "media-left" ]
            [ div
                [ style [ ( "padding-top", "1rem" ) ] ]
                [ ico ]
            ]
        , div
            [ class "media-content" ]
            [ bodyTitle title
            , bodyText txt
            ]
        ]


origin : Html Msg
origin =
    section
        [ class "hero is-small is-light" ]
        [ div
            [ class "hero-body container" ]
            [ bodyHeader "A few words"
            , columns
                [ verticalCard grey
                    ( lightbulb
                    , "Don't take privacy for granted"
                    , "We live in a world that is driven inexorably forward by promises of innovation and the fruits it may bear. Now more than ever we need to truly think about what we sacrifice in return for a few seconds saved and products that fill the niche for our interests. Don't put a price on your privacy, take control of it."
                    )
                , verticalCard green
                    ( ecran
                    , "Why I built this"
                    , "If you're anything like me, you can never truly settle on what you want to listen to. I have numerous playlists with old favorites, up and coming contenders, and the songs that don't let you just quite hit next. Sooner or later, I'm hitting next. And next. And next. You hear the same songs enough times and it's bound to turn anyone away from hitting play. With Discover Now, I set out to create a streamlined and private experience for anyone who is in search of something new to love. It isn't perfect, but it definitely beats wracking your brain for long forgotten bands or trawling through community playlists that either have everything you've listened to, or tracks that just don't quite sound right to you. So this is for you."
                    )
                ]
            ]
        ]


callToActionTop : Model -> String -> Html Msg
callToActionTop model txt =
    section
        [ class "hero is-small is-info" ]
        [ div
            [ class "hero-body container" ]
            [ columns
                [ div
                    [ class "has-text-right" ]
                    [ ctaText txt ]
                , div
                    [ class "has-text-left" ]
                    [ loginButton (spotifyButton) model.login ]
                ]
            ]
        ]


callToActionBot : Model -> String -> Html Msg
callToActionBot model txt =
    section
        [ class "hero is-small is-info" ]
        [ div
            [ class "hero-body container" ]
            [ columns
                [ div
                    [ class "has-text-right" ]
                    [ ctaText txt ]
                , div
                    [ class "level has-text-left" ]
                    [ div
                        [ class "level-left" ]
                        [ loginButton (spotifyButton) model.login ]
                    , div
                        [ class "level-right" ]
                        [ scrollButton "splash" "Back to top" ]
                    ]
                ]
            ]
        ]


ctaText : String -> Html Msg
ctaText txt =
    h2
        [ class "subtitle is-size-3 has-text-grey-dark"
        , style
            [ ( "font-family", "Quicksand" )
            , ( "font-weight", "500" )
            ]
        ]
        [ text txt ]



-- arrowIcon : Html Msg
-- arrowIcon =
--     span
--         []
--         [ largeIcon "fas fa-angle-right fa-4x fa-fw" ]
-- userIcon : Html Msg
-- userIcon =
--     span
--         [ class "icon fa-fw fa-5x has-text-primary"
--         , style
--             [ ( "padding", "2.5rem" )
--             -- , ( "border", "2px solid red" )
--             ]
--         ]
--         [ span
--             [ class "fa-layers fa-fw" ]
--             [ i
--                 [ class "far fa-circle"
--                 , attribute "data-fa-transform" "left-7.8"
--                 ]
--                 []
--             , i
--                 [ class "fas fa-user"
--                 , attribute "data-fa-transform" "shrink-8 left-7.8 up-0.5"
--                 ]
--                 []
--             ]
--         ]
-- dnaIcon : Html Msg
-- dnaIcon =
--     span
--         [ class "icon fa-fw fa-5x has-text-primary"
--         , style
--             [ ( "padding", "2.5rem" )
--             -- , ( "border", "2px solid red" )
--             ]
--         ]
--         [ span
--             [ class "fa-layers fa-fw" ]
--             [ i
--                 [ class "far fa-circle"
--                 , attribute "data-fa-transform" "left-7.8"
--                 ]
--                 []
--             , i
--                 [ class "fas fa-dna"
--                 , attribute "data-fa-transform" "shrink-7 left-6.8"
--                 ]
--                 []
--             ]
--         ]
-- playIcon : Html Msg
-- playIcon =
--     span
--         [ class "icon has-text-primary"
--         , style
--             [ ( "padding", "2.5rem" )
--             -- , ( "border", "2px solid red" )
--             ]
--         ]
--         [ icon "far fa-play-circle fa-5x fa-fw "
--         ]
-- summary : Model -> Html Msg
-- summary model =
--     section
--         [ class "hero is-small is-light has-text-centered" ]
--         [ div
--             [ class "hero-body container"
--             , style [ ( "padding-bottom", "4rem" ) ]
--             ]
--             [ div
--                 [ class "columns" ]
--                 [ div
--                     -- [ class "column is-three-fifths is-offset-one-fifth" ]
--                     [ class "column is-narrow" ]
--                     [ boxedHeader "How it all works" ]
--                 ]
--             , div
--                 [ class "columns" ]
--                 [ largeIconColumn
--                     ( userIcon
--                     , "Connect"
--                     , "Connect to your Spotify account using a secure connection provided by Spotify"
--                     )
--                 , level [ arrowIcon ]
--                 , largeIconColumn
--                     ( dnaIcon
--                     , "Analyze"
--                     , "Our algorithm will analyze and generate a personal Discover playlist just for you"
--                     )
--                 , level [ arrowIcon ]
--                 , largeIconColumn
--                     ( playIcon
--                     , "Discover"
--                     , "Your personalized Discover playlist is ready for you right on your preferred Spotify player"
--                     )
--                 ]
--             , loginButton (spotifyButton) model.login
--             ]
--         , div
--             [ style [ ( "background-color", "#F0F0F0" ) ] ]
--             [ heroFooter ]
--         ]
