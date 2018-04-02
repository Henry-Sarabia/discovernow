module Views.Landing exposing (root)

import Html exposing (Html, Attribute, div, text, h1, h2, nav, section, span, a, i, p, img, footer)
import Html.Attributes exposing (class, style, src, href, alt, height, width, attribute)
import Html.Events exposing (onWithOptions, onClick)
import Json.Decode as Decode
import Models exposing (Model, Login)
import Msgs exposing (Msg(..))
import RemoteData exposing (WebData)

 
root : Model -> Html Msg
root model =
    div 
        []
        [ heroImage model
        , heroFeatures
        , footerInfo
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


heroImage : Model -> Html Msg
heroImage model =
    section
        [ class "hero is-large"
        , style 
            [ ("background-image", "linear-gradient(rgba(0, 0, 0, 0.25), rgba(0, 0, 0, 0.25)), url(herobg2.jpg)")
            , ("background-position", "center")
            , ("background-repeat", "no-repeat")
            , ("background-size", "cover")
            ]
        ]
        [ heroImageBody model ]


heroImageBody : Model -> Html Msg
heroImageBody model =
    div
        [ class "hero-body" ]
        [ div
            [ class "container has-text-centered" ]
            [ titleText "Discover your MyFy experience today"
            , subtitleText "Analyze your Spotify data to create personalized summary and instant Discover playlists"
            , spotifyButton model.login "Get Started"
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


spotifyButton : WebData Login -> String -> Html Msg
spotifyButton login label =
    case login of
        RemoteData.NotAsked ->
            a 
                [ class "button is-success is-large"
                , onClick ForceFetchLogin
                ]
                [ icon "fab fa-spotify"
                , spanText label
                ]

        RemoteData.Loading ->
            a 
                [ class "button is-success is-large"
                , onClick ForceFetchLogin
                ]
                [ icon "fab fa-spotify"
                , spanText label
                ]

        RemoteData.Success response ->
            a 
                [ class "button is-success is-large"
                , onClick (LoadLogin response.url)
                ]
                [ icon "fab fa-spotify"
                , spanText label
                ]

        RemoteData.Failure err ->
            a 
                [ class "button is-success is-large"
                , onClick ForceFetchLogin
                ]
                [ icon "fab fa-spotify"
                , spanText label
                ]


icon : String -> Html Msg
icon link =
    span
        [ class "icon" ]
        [ i
            [ class link ]
            []
        ]


spanText : String -> Html Msg
spanText txt =
    span
        []
        [ text txt ]


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
                    [ iconColumn "far fa-address-card fa-5x" "Taste Summary" "Analyze weeks, months, or up to years of data and generate playlists that exemplify your distinct taste in music"
                    , iconColumn "fas fa-search fa-5x" "Discover Now" "No need to wait a week, get an automatically curated discover playlist right now"
                    , iconColumn "fab fa-spotify fa-5x" "Simple Login" "You have enough accounts to worry about - use your existing Spotify account to log in"
                    , iconColumn "fas fa-unlock-alt fa-5x" "Forever Free" "No ads, no analytics, no subscription - simply share and enjoy"
                    ]
                ]
            ]
        ]

iconColumn : String -> String -> String -> Html Msg
iconColumn iconLink title sub =
    div
        [ class "column has-text-centered" ]
        [ largeIcon iconLink
        , featureTitle title
        , featureSub sub 
        ]


largeIcon : String -> Html Msg
largeIcon link =
    span
        [ class "icon is-large" ]
        [ i
            [ class link ]
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


footerInfo : Html Msg
footerInfo =
    footer
        [ class "footer" 
        , style [ ("background-color", "#F0F0F0")] 
        ]
        [ div
            [ class "container" ]
            [ div
                [ class "columns" ] 
                [ footerItem githubInfo
                , footerItem authorInfo
                ]
            ]
        ]


footerItem : Html Msg -> Html Msg
footerItem child =
    div
        [ class "column is-4" ]
        [ child ]


authorInfo : Html Msg
authorInfo =
    div
        [ class "has-text-centered" ]
        [ div
            []
            [ text "Created by Henry Sarabia" ]
        , div
            []
            [ text "Licensed under MIT" ]
        ]


githubInfo : Html Msg
githubInfo =
    div
        [ class "container" ]
        [ followButton
        , starButton ]

followButton : Html Msg
followButton =
    div
        []
        [ a  
            [ class "github-button"
            , href "https://github.com/Henry-Sarabia"
            , attribute "data-size" "large"
            , attribute "aria-label" "Follow @Henry-Sarabia on GitHub"
            ]
            [  span
                []
                [ text "Follow @Henry-Sarabia" ]
            ]
        ]


starButton : Html Msg
starButton =
    div
        []
        [ a
            [ class "github-button" 
            , href "https://github.com/Henry-Sarabia/myfy"
            , attribute "data-icon" "octicon-star"
            , attribute "data-size" "large"
            , attribute "data-show-count" "true"
            , attribute "aria-label" "Star Henry-Sarabia on GitHub"
            ]
            [ span
                []
                [ text "Star" ]
            ]]


bulmaButton : Html Msg
bulmaButton =
    a
        [ href "https://bulma.io" ]
        [ img
            [ src "https://bulma.io/images/made-with-bulma.png" 
            , alt "Made with Bulma"
            , width 128
            , height 24
            ]
            []
        ]

unsplashButton : Html Msg
unsplashButton =
    a
        [ class "button is-small"
        , href "https://unsplash.com/photos/pFqrYbhIAXs?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText" ]
        [ span
            [ class "icon" ]
            [ i
                [ class "fas fa-camera"]
                []
            ]
        , span
            []
            [ text "Photo by Luke Chesser" ]
        ]

container : Html Msg -> Html Msg
container child =
    div
        [ class "container" ]
        [ child ]

