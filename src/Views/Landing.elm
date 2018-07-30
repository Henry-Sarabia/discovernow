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
        [ svgBackground model.flags.bodyBG ]
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
        , alphaPhotoBackground model.flags.splashBG 0.1
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
        [ class "header-desktop title is-hidden-mobile" ]
        [ text txt ]


splashHeaderMobile : String -> Html Msg
splashHeaderMobile txt =
    h1
        [ class "header-mobile title has-text-centered is-hidden-tablet" ]
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
        [ class "subheader-desktop has-text-weight-medium is-size-3 is-hidden-mobile" ]
        [ text txt ]


splashSubheaderMobile : String -> Html Msg
splashSubheaderMobile txt =
    h2
        [ class "subheader-mobile has-text-weight-medium is-size-4 has-text-centered is-hidden-tablet" ]
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
        [ class "buttonpair-desktop buttons is-hidden-mobile" ]
        [ githubButton
        , spotifyButton
        ]


buttonPairMobile : Model -> Html Msg
buttonPairMobile model =
    div
        [ class "buttonpair-mobile has-text-centered is-hidden-tablet" ]
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
        [ class "scroll-mobile has-text-centered is-hidden-tablet" ]
        [ scrollButtonElement domId label ]


scrollButtonElement : String -> String -> Html Msg
scrollButtonElement domId label =
    -- Keep styling local
    a
        [ class "is-size-5"
        , style
            [ ( "margin-left", "-0.25rem" )
            , ( "text-decoration", "underline" )
            ]
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
        , borderAccent direction accent
        ]
        [ div
            [ class "card-image has-text-centered" ]
            [ div
                []
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
            [ heroTitle "Why you should Discover Now"
            , heroSubtitle "We make it simple to find new music you'll love with ease and confidence"
            , columns
                [ featureCard
                    ( secondaryGreen, primaryGreen )
                    ( userLockIcon
                    , "Log in simply and securely"
                    , "You have more than enough accounts and passwords to worry about. Simply connect to your existing Spotify account and we'll take care of the rest."
                    )
                , featureCard
                    ( secondaryGreen, primaryGreen )
                    ( walletIcon
                    , "Enjoy with no strings attached"
                    , "Discover new music for free. We don't advertise, analyze, or as for a subscription. All we ask is for you to share and enjoy your experience of discovery."
                    )
                , featureCard
                    ( secondaryGreen, primaryGreen )
                    ( devicesIcon
                    , "Discover anytime and anywhere"
                    , "Designed from the ground up to offer a polished experience for desktop, mobile, and everything in between. Discovery is only a tap or click away."
                    )
                , featureCard
                    ( secondaryGreen, primaryGreen )
                    ( codeIcon
                    , "Explore the open source code"
                    , "The complete project is hosted on GitHub for your viewing pleasure. Take a quick peek to see how we handle your data and keep discovery ticking."
                    )
                ]
            ]
        ]


featureCard : ( String, String ) -> ( String -> String -> Html Msg, String, String ) -> Html Msg
featureCard ( primary, secondary ) ( ico, title, txt ) =
    accentCard ( "bottom", "hsl(0,0%,98%)" )
        ( primary, secondary )
        ( ico, title, txt )


heroTitle : String -> Html Msg
heroTitle txt =
    h2
        []
        [ heroTitleDesktop txt
        , heroTitleMobile txt
        ]


heroTitleDesktop : String -> Html Msg
heroTitleDesktop txt =
    h2
        [ class "title is-size-2 is-hidden-mobile" ]
        [ text txt ]


heroTitleMobile : String -> Html Msg
heroTitleMobile txt =
    h2
        [ class "hero-title-mobile title is-size-2 has-text-centered is-hidden-tablet" ]
        [ text txt ]


heroSubtitle : String -> Html Msg
heroSubtitle txt =
    h3
        []
        [ heroSubtitleDesktop txt
        , heroSubtitleMobile txt
        ]


heroSubtitleDesktop : String -> Html Msg
heroSubtitleDesktop txt =
    h3
        [ class "hero-subtitle-desktop subtitle has-text-grey-copy is-hidden-mobile" ]
        [ text txt ]


heroSubtitleMobile : String -> Html Msg
heroSubtitleMobile txt =
    h3
        [ class "subtitle has-text-grey-copy has-text-centered is-hidden-tablet" ]
        [ text txt ]


cardTitle : String -> Html Msg
cardTitle txt =
    h4
        [ class "title is-size-5 has-text-grey-dark has-text-centered" ]
        [ text txt ]


cardCopy : String -> Html Msg
cardCopy txt =
    p
        [ class "card-copy is-size-6 has-text-grey-copy" ]
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
        [ class "body-title-desktop title is-size-5 is-hidden-mobile" ]
        [ text txt ]


bodyTitleMobile : String -> Html Msg
bodyTitleMobile txt =
    h4
        [ class "body-title-mobile title is-size-5 is-hidden-tablet" ]
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
        [ class "body-copy-desktop is-size-6 has-text-grey-copy is-hidden-mobile" ]
        [ text txt ]


bodyCopyMobile : String -> Html Msg
bodyCopyMobile txt =
    p
        [ class "body-copy-mobile is-size-6 has-text-grey-copy is-hidden-tablet" ]
        [ text txt ]


steps : Html Msg
steps =
    section
        [ class "hero is-large gradient" ]
        [ div
            [ class "hero-body container" ]
            [ heroTitle "It only takes seconds"
            , heroSubtitle "Faithfully designed to get you listening to new music in as little as a few clicks"
            , columns
                [ stepCard ( secondaryGreen, primaryGreen )
                    ( idIcon
                    , "Connect to Spotify"
                    , "When you're ready to give Discover Now a try, you'll be redirected to Spotify where you can log into your account. Once you're logged in, we'll take care of the rest."
                    )
                , stepCard ( secondaryGreen, primaryGreen )
                    ( pieIcon
                    , "Analyze your interests"
                    , "Our algorithm will analyze your listening habits to generate your personalized playlist. Inside, you'll find artists we think you'll love but just haven't connected with yet."
                    )
                , stepCard ( secondaryGreen, primaryGreen )
                    ( headphonesIcon
                    , "Discover new music"
                    , "Your Discover Now playlist is then added to your Spotify profile. All that's left is to enjoy your new discovery. If we miss our mark, you can always try again."
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
            [ heroTitle "Made with you in mind"
            , heroSubtitle "We take great care in delivering new discoveries while still protecting your privacy"
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
                    "Discover Now was designed with your privacy in mind every step of the way - we strive for a balance of convenience and confidentiality."
                ]
            ]
        ]


divider : Html Msg
divider =
    hr
        [ class "divider is-hidden-tablet" ]
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
    h2
        [ class "quote-body is-size-3 has-text-weight-normal has-text-dark-green has-text-centered is-hidden-mobile"
        , borderAccent direction color
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
        [ class "title is-size-2 has-text-right is-marginless is-hidden-mobile" ]
        [ text txt ]


ctaTextMobile : String -> Html Msg
ctaTextMobile txt =
    h2
        [ class "title is-size-2 has-text-grey-dark has-text-centered is-hidden-tablet" ]
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
