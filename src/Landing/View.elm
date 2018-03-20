module Landing.View exposing (root)

import Html exposing (Html, Attribute, div, text, h1, h2, nav, section, span, a, i, p, img)
import Html.Attributes exposing (class, style, src, href, alt)
import Html.Events exposing (onWithOptions, onClick)
import Json.Decode as Decode
import Landing.Types exposing (Model, Msg(..))

 
root : Model -> Html Msg
root model =
    div 
        []
        [ heroImage
        , heroFeatures
        ]


onLinkClick : Msg -> Attribute Msg
onLinkClick msg =
    let
        options =
            { stopPropagation = False
            , preventDefault = True
            }
    in
        onWithOptions "click" options (Decode.succeed msg)


heroImage : Html Msg
heroImage =
    section
        [ class "hero is-large"
        , style 
            [ ("background-image", "linear-gradient(rgba(0, 0, 0, 0.25), rgba(0, 0, 0, 0.25)), url(herobg2.jpg)")
            , ("background-position", "center")
            , ("background-repeat", "no-repeat")
            , ("background-size", "cover")
            ]
        ]
        [ heroImageBody ]


heroImageBody : Html Msg
heroImageBody =
    div
        [ class "hero-body" ]
        [ div
            [ class "container has-text-centered" ]
            [ titleText "MyFy"
            , subtitleText "Analyze your Spotify data to create personalized summary and instant Discover playlists"
            , spotifyButton "Get Started"
            ]
        ]


titleText : String -> Html Msg
titleText title =
    h1 
        [ class "title is-1 is-spaced has-text-light" ]
        [ text title ]


subtitleText : String -> Html Msg
subtitleText sub = 
    h2
        [ class "subtitle is-3 has-text-light" ]
        [ text sub ] 


spotifyButton : String -> Html Msg
spotifyButton label =
    a 
        [ class "button is-success is-large"
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


heroFeatures : Html Msg
heroFeatures =
    section 
        [ class "hero is-light is-medium"]
        [ div
            [ class "hero-body" ]
            [ div 
                [ class "container" ]
                [ nav 
                    [ class "columns" ]
                    [ iconColumn "far fa-plus-square fa-5x" "Taste Summary" "Analyze weeks, months, or up to years of data and generate playlists that summarize your distinct taste in music"
                    , iconColumn "fas fa-search fa-5x" "Discover Now" "No need to wait a week, get an automatically curated discover playlist right now"
                    , iconColumn "fab fa-spotify fa-5x" "Simple Login" "You have enough accounts to worry about - use your existing Spotify account to log in"
                    , iconColumn "fas fa-unlock-alt fa-5x" "Forever Free" "No ads, no analytics, no subscription - simply share and enjoy"
                    -- , iconColumn "fas fa-mobile-alt fa-5x" "Responsive Design" "Designed for desktop and mobile for those on the go"
                    ]
                ]
            ]
        ]

iconColumn : String -> String -> String -> Html Msg
iconColumn iconLink title sub =
    div
        [ class "column has-text-centered" ]
        [ icon iconLink
        , featureTitle title
        , featureSub sub 
        ]


icon : String -> Html Msg
icon label =
    span
        [ class "icon is-large" ]
        [ i
            [ class label ]
            []
        ]


featureTitle : String -> Html Msg
featureTitle label =
    p
        [ class "title is-4 is-spaced" ]
        [ text label ]


featureSub : String -> Html Msg
featureSub label =
    p
        [ class "subtitle"
        , style [ ("line-height", "1.6") ]
        ]
        [ text label ]
