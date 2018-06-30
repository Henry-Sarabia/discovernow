module Views.Landing exposing (root)

import Html exposing (Html, div, text, h1, h2, h3, h4, section, span, a, p, i, hr)
import Html.Attributes exposing (class, style, id)
import Html.Events exposing (onClick)
import Models exposing (Model, Login)
import Msgs exposing (Msg(..))
import Utils exposing (..)
import Views.Buttons exposing (spotifyButton, githubButton)
import Views.Footer exposing (simpleFooter)
import Views.Icons exposing (..)
import Views.Colors exposing (..)
import Views.Styles exposing (..)


root : Model -> Html Msg
root model =
    div
        []
        [ splash model
        , backgroundHero model
        , simpleFooter
        ]


backgroundHero : Model -> Html Msg
backgroundHero model =
    div
        [ svgBackground "images/greenTopography.svg" ]
        [ features
        , steps
        , story
        , callToAction model "It's time to discover."
        , emptyHero
        ]


splash : Model -> Html Msg
splash model =
    section
        [ class "hero is-fullheight"
        , id "splash"
        , alphaPhotoBackground "images/cassette.jpg" 0.1
        ]
        [ div
            [ class "hero-body" ]
            [ div
                [ class "container" ]
                [ splashSubheader "Don't wait for Monday."
                , splashHeader "Discover Now"
                , buttonPair model
                , scrollButton "features" "Learn more"
                ]
            ]
        ]


splashHeader : String -> Html Msg
splashHeader txt =
    h1
        []
        [ splashHeaderDesktop txt
        , splashHeaderMobile txt
        ]


splashHeaderDesktop : String -> Html Msg
splashHeaderDesktop txt =
    h1
        [ class "title has-text-grey-darker is-hidden-mobile"
        , fontMarker
        , style [ ( "font-size", "6rem" ), ( "padding-bottom", "0.5rem" ) ]
        ]
        [ text txt ]


splashHeaderMobile : String -> Html Msg
splashHeaderMobile txt =
    h1
        [ class "title has-text-grey-darker has-text-centered is-hidden-tablet"
        , fontMarker
        , style
            [ ( "font-size", "4.5rem" )
            , ( "padding-bottom", "1rem" )
            ]
        ]
        [ text txt ]


splashSubheader : String -> Html Msg
splashSubheader txt =
    h2
        []
        [ splashSubheaderDesktop txt
        , splashSubheaderMobile txt
        ]


splashSubheaderDesktop : String -> Html Msg
splashSubheaderDesktop txt =
    h2
        [ class "subtitle is-size-3 has-text-weight-medium has-text-grey-dark is-hidden-mobile"
        , fontQuicksand
        , style [ ( "margin-bottom", "-1rem" ), ( "margin-top", "-17rem" ) ]
        ]
        [ text txt ]


splashSubheaderMobile : String -> Html Msg
splashSubheaderMobile txt =
    h2
        [ class "subtitle is-size-4 has-text-weight-medium has-text-grey-dark has-text-centered is-hidden-tablet"
        , fontQuicksand
        , style [ ( "margin-bottom", "0.75rem" ) ]
        ]
        [ text txt ]


buttonPair : Model -> Html Msg
buttonPair model =
    div
        []
        [ buttonPairDesktop model
        , buttonPairMobile model
        ]


buttonPairDesktop : Model -> Html Msg
buttonPairDesktop model =
    div
        [ class "buttons is-hidden-mobile"
        , style [ ( "margin-left", "-0.5rem" ) ]
        ]
        [ githubButton
        , spotifyButton
        ]


buttonPairMobile : Model -> Html Msg
buttonPairMobile model =
    div
        [ class "has-text-centered is-hidden-tablet"
        , style
            [ ( "padding", "1rem" ) ]
        ]
        [ githubButton
        , spotifyButton
        ]


scrollButton : String -> String -> Html Msg
scrollButton domId label =
    div
        []
        [ scrollDesktop domId label
        , scrollMobile domId label
        ]


scrollDesktop : String -> String -> Html Msg
scrollDesktop domId label =
    div
        [ class "is-hidden-mobile" ]
        [ scrollButtonElement domId label ]


scrollMobile : String -> String -> Html Msg
scrollMobile domId label =
    div
        [ class "has-text-centered is-hidden-tablet"
        , style [ ( "padding-top", "1rem" ) ]
        ]
        [ scrollButtonElement domId label ]


scrollButtonElement : String -> String -> Html Msg
scrollButtonElement domId label =
    a
        [ class "is-size-5"
        , style
            [ ( "margin-left", "-0.25rem" ) ]
        , underlineFont
        , onClick (ScrollToDomId domId)
        ]
        [ iconText label
        , span
            [ class "icon"
            , style [ ( "position", "relative" ) ]
            ]
            [ i
                [ class "fas fa-angle-down"
                , style
                    [ ( "position", "absolute" )
                    , ( "top", "0.5rem" )
                    , ( "margin-left", "0.5rem" )
                    ]
                ]
                []
            ]
        ]


accentCard : ( String, String ) -> ( String, String ) -> ( String -> String -> Html Msg, String, String ) -> Html Msg
accentCard ( direction, accent ) ( primary, secondary ) ( ico, title, txt ) =
    div
        [ class "card"
        , cardPadding
        , cardBoxShadow
        , borderAccent direction accent
        , style [ ( "border-radius", "14px" ) ]
        ]
        [ div
            [ class "card-image has-text-centered" ]
            [ div
                [ style [ ( "padding-top", "1rem" ) ] ]
                [ ico primary secondary ]
            ]
        , div
            [ class "card-content" ]
            [ cardTitle title
            , cardCopy txt
            ]
        ]


features : Html Msg
features =
    section
        [ class "hero is-large"
        , id "features"
        ]
        [ div
            [ class "hero-body container" ]
            [ bodyHeader "Why you should Discover Now"
            , bodySubheader "We make it simple to find new music you'll love with ease and confidence"
            , columns
                [ featureCard
                    ( secondaryGreen, primaryGreen )
                    ( codeIcon
                    , "Explore the open source code"
                    , "The complete project is hosted on GitHub for your viewing pleasure. Take a quick peek to see what keeps discovery ticking."
                    )
                , featureCard
                    ( secondaryGreen, primaryGreen )
                    ( userLockIcon
                    , "Log in simply and securely"
                    , "You have more than enough accounts to worry about. Simply connect to your existing Spotify account to get started quickly and easily."
                    )
                , featureCard
                    ( secondaryGreen, primaryGreen )
                    ( walletIcon
                    , "Enjoy with no strings attached"
                    , "Discover new music for free. No advertisements. No analytics. No subscriptions. Simply share and enjoy the experience of discovery."
                    )
                , featureCard
                    ( secondaryGreen, primaryGreen )
                    ( devicesIcon
                    , "Discover anytime and anywhere"
                    , "Designed from the ground up to offer a smooth experience for desktop, mobile, and everything in between. We're ready when you are."
                    )
                ]
            ]
        ]


featureCard : ( String, String ) -> ( String -> String -> Html Msg, String, String ) -> Html Msg
featureCard ( primary, secondary ) ( ico, title, txt ) =
    accentCard ( "bottom", "hsl(0,0%,98%)" )
        ( primary, secondary )
        ( ico, title, txt )


bodyHeader : String -> Html Msg
bodyHeader txt =
    h2
        []
        [ bodyHeaderDesktop txt
        , bodyHeaderMobile txt
        ]


bodyHeaderDesktop : String -> Html Msg
bodyHeaderDesktop txt =
    h2
        [ class "title is-size-2 has-text-weight-medium has-text-grey-dark has-text-left is-hidden-mobile"
        , fontQuicksand
        ]
        [ text txt ]


bodyHeaderMobile : String -> Html Msg
bodyHeaderMobile txt =
    h2
        [ class "title is-size-2 has-text-weight-medium has-text-grey-dark has-text-centered is-hidden-tablet"
        , fontQuicksand
        , style
            [ ( "padding", "0rem 0rem 1.5rem 0rem" )
            , ( "margin-top", "-0.75rem" )
            ]
        ]
        [ text txt ]


bodySubheader : String -> Html Msg
bodySubheader txt =
    h3
        []
        [ bodySubheaderDesktop txt
        , bodySubheaderMobile txt
        ]


bodySubheaderDesktop : String -> Html Msg
bodySubheaderDesktop txt =
    h3
        [ class "title is-size-5 has-text-weight-medium has-text-grey-copy has-text-left is-hidden-mobile"
        , style [ ( "padding-bottom", "1.5rem" ) ]
        , fontQuicksand
        ]
        [ text txt ]


bodySubheaderMobile : String -> Html Msg
bodySubheaderMobile txt =
    h3
        [ class "title is-size-5 has-text-weight-medium has-text-grey-copy has-text-centered is-hidden-tablet"
        , fontQuicksand
        ]
        [ text txt ]


cardTitle : String -> Html Msg
cardTitle txt =
    h4
        [ class "title is-size-5 has-text-weight-medium has-text-grey-dark has-text-centered"
        , fontQuicksand
        ]
        [ text txt ]


cardCopy : String -> Html Msg
cardCopy txt =
    p
        [ class "is-size-6 has-text-weight-normal has-text-grey-copy has-text-left"
        , style
            [ ( "line-height", "1.7em" ) ]
        ]
        [ text txt ]


bodyTitle : String -> Html Msg
bodyTitle txt =
    h4
        []
        [ bodyTitleDesktop txt
        , bodyTitleMobile txt
        ]


bodyTitleDesktop : String -> Html Msg
bodyTitleDesktop txt =
    h4
        [ class "title is-size-5 has-text-weight-medium has-text-grey-dark has-text-left is-hidden-mobile"
        , fontQuicksand
        , style [ ( "padding", "1rem 3rem" ) ]
        ]
        [ text txt ]


bodyTitleMobile : String -> Html Msg
bodyTitleMobile txt =
    h4
        [ class "title is-size-5 has-text-weight-medium has-text-grey-dark has-text-left is-hidden-tablet"
        , fontQuicksand
        , style [ ( "padding", "1rem 1rem 1.5rem 1rem" ) ]
        ]
        [ text txt ]


bodyCopy : String -> Html Msg
bodyCopy txt =
    p
        []
        [ bodyCopyDesktop txt
        , bodyCopyMobile txt
        ]


bodyCopyDesktop : String -> Html Msg
bodyCopyDesktop txt =
    p
        [ class "is-size-6 has-text-weight-normal has-text-grey-copy has-text-left is-hidden-mobile"
        , style
            [ ( "line-height", "1.8em" )
            , ( "padding", "0rem 3rem 1rem 3rem" )
            ]
        ]
        [ text txt ]


bodyCopyMobile : String -> Html Msg
bodyCopyMobile txt =
    p
        [ class "is-size-6 has-text-weight-normal has-text-grey-copy has-text-left is-hidden-tablet"
        , style
            [ ( "line-height", "1.8em" )
            , ( "padding", "1rem" )
            ]
        ]
        [ text txt ]


steps : Html Msg
steps =
    section
        [ class "hero is-large"
        , whiteGradient
        ]
        [ div
            [ class "hero-body container" ]
            [ bodyHeader "It only takes seconds"
            , bodySubheader "Faithfully designed to get you listening to new music in as little as a few clicks"
            , columns
                [ stepCard ( secondaryGreen, primaryGreen )
                    ( idIcon
                    , "Connect to Spotify"
                    , "You can rest assured that your information is safe with all authentication being handled directly by Spotify."
                    )
                , stepCard ( secondaryGreen, primaryGreen )
                    ( pieIcon
                    , "Analyze your interests"
                    , "Our algorithm will analyze your playback history to establish your recent musical interests and generate a unique."
                    )
                , stepCard ( secondaryGreen, primaryGreen )
                    ( headphonesIcon
                    , "Discover new music"
                    , "Your discover playlist will be automatically be added to your account for your to enjoy. Enjoy and discover something new."
                    )
                ]
            ]
        ]


stepCard : ( String, String ) -> ( String -> String -> Html Msg, String, String ) -> Html Msg
stepCard ( primary, secondary ) ( ico, title, txt ) =
    accentCard ( "left", shadowGreen )
        ( primary, secondary )
        ( ico, title, txt )


story : Html Msg
story =
    section
        [ class "hero is-medium" ]
        [ div
            [ class "hero-body container" ]
            [ bodyHeader "Made with you in mind"
            , bodySubheader "We take great care in delivering new discoveries while still protecting your privacy"
            , divider
            , columns
                [ accentQuote "left"
                    shadowGreen
                    "Spotify's Discover Weekly is unmatched in personalized music discovery - but sometimes a week is just too long of a wait."
                , storyCard
                    ( "For when you just can't wait for a new discovery"
                    , "We love Spotify's Discover Weekly playlist so much that we made it our goal to create something for those of us who can't even wait until the next Monday. Our personalized Discover Now playlists try to capture your recent interests while still introducing you to something you haven't fallen in love with quite yet. We can't replace Spotify Weekly, but we can hold you over until it's that time of the week again."
                    )
                ]
            , columns
                [ storyCard
                    ( "We make your privacy our priority"
                    , "We designed Discover Now from the ground up with your privacy in mind. You don't need to create an account with us - we let Spotify handle your sensitive data instead. The first time you use Discover Now, we'll ask for permission to use some of your play history so our algorithm can do its magic. That data is then discarded the moment your unique playlist is generated. We don't store your IP, your data, or anything else on our server. Our work begins and ends with connecting you to undiscovered music."
                    )
                , accentQuote "right"
                    shadowGreen
                    "Discover Now was designed with your privacy in mind every step of the way - we strive for a balance of convenience and confidentiality. Secure by design."
                ]
            ]
        ]


divider : Html Msg
divider =
    hr
        [ class "is-hidden-tablet"
        , style
            [ ( "margin", "2.5rem 0rem 0rem" )
            , ( "position", "relative" )
            , ( "width", "40%" )
            , ( "left", "30%" )
            ]
        ]
        []


storyCard : ( String, String ) -> Html Msg
storyCard ( title, txt ) =
    div
        []
        [ bodyTitle title
        , bodyCopy txt
        ]


accentQuote : String -> String -> String -> Html Msg
accentQuote direction color txt =
    p
        [ class "is-size-3 has-text-weight-normal has-text-dark-green has-text-centered is-hidden-mobile"
        , fontQuicksand
        , borderAccent direction color
        , style
            [ ( "line-height", "1.8em" )
            , ( "padding", "0rem 3rem 1rem 3rem" )
            ]
        ]
        [ text ("\"" ++ txt ++ "\"") ]


callToAction : Model -> String -> Html Msg
callToAction model txt =
    section
        [ class "hero is-small is-success" ]
        [ div
            [ class "hero-body container" ]
            [ columns
                [ ctaText txt
                , ctaButton (spotifyButton)
                ]
            ]
        ]


ctaText : String -> Html Msg
ctaText txt =
    h2
        []
        [ ctaTextDesktop txt
        , ctaTextMobile txt
        ]


ctaTextDesktop : String -> Html Msg
ctaTextDesktop txt =
    h2
        [ class "title is-size-2 has-text-weight-medium has-text-grey-dark has-text-right is-hidden-mobile"
        , fontQuicksand
        , style [ ( "margin", "0" ) ]
        ]
        [ text txt ]


ctaTextMobile : String -> Html Msg
ctaTextMobile txt =
    h2
        [ class "title is-size-2 has-text-weight-medium has-text-grey-dark has-text-centered is-hidden-tablet"
        , fontQuicksand
        ]
        [ text txt ]


ctaButton : Html Msg -> Html Msg
ctaButton btn =
    div
        []
        [ ctaButtonDesktop btn
        , ctaButtonMobile btn
        ]


ctaButtonDesktop : Html Msg -> Html Msg
ctaButtonDesktop btn =
    div
        [ class "has-text-left is-hidden-mobile" ]
        [ btn ]


ctaButtonMobile : Html Msg -> Html Msg
ctaButtonMobile btn =
    div
        [ class "has-text-centered is-hidden-tablet" ]
        [ btn ]


emptyHero : Html Msg
emptyHero =
    section
        [ class "hero is-small is-light" ]
        [ div
            [ class "hero-body" ]
            []
        ]
