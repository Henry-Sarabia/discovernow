module Views.Discover exposing (root)

import Html exposing (Html, div, section, text, a, iframe, p, i, h1, h2, button)
import Html.Attributes exposing (class, style, id, src, height, width, attribute)
import Html.Events exposing (onClick)
import Models exposing (Model, Login, Playlist)
import Msgs exposing (Msg(..))
import RemoteData exposing (WebData)
import Views.Buttons exposing (loginButton)
import Views.Header exposing (heroNavbar, navbar)
import Views.Icons exposing (..)
import Views.Footer exposing (simpleFooter)
import Views.Styles exposing (..)


root : Model -> Html Msg
root model =
    div
        []
        [ hero model
        , simpleFooter
        ]


hero : Model -> Html Msg
hero model =
    section
        [ class "hero is-fullheight is-light"
        , svgBackground "images/greenTopography.svg"
        ]
        [ heroNavbar model
        , heroBody model
        , heroFoot model
        ]


heroBody : Model -> Html Msg
heroBody model =
    div
        [ class "hero-body" ]
        [ div
            [ class "container has-text-centered" ]
            [ results model ]
        ]


results : Model -> Html Msg
results model =
    case model.discover of
        RemoteData.NotAsked ->
            notAsked model.login

        RemoteData.Loading ->
            loading

        RemoteData.Success response ->
            success response

        RemoteData.Failure err ->
            failure


notAsked : WebData Login -> Html Msg
notAsked login =
    div
        []
        [ header "Oh, hey."
        , subheader "Somehow you got here without asking for a playlist."
        , copy "Let's fix that."
        , loginButton login
        ]


success : Playlist -> Html Msg
success playlist =
    div
        []
        [ header "Success!"
        , subheader "Something you'll love is waiting for you on your preferred Spotify player."
        , previewButton "playlist-modal"
        , playlistModal playlist
        ]


loading : Html Msg
loading =
    i
        [ class "fas fa-spinner fa-pulse fa-5x"
        , style [ ( "margin-top", "-5rem" ) ]
        ]
        []


failure : Html Msg
failure =
    div
        []
        [ header "Uh oh."
        , subheader "We didn't find enough data to generate your playlist."
        , copy "Come back after listening to some more music and give it another try."
        ]


header : String -> Html Msg
header txt =
    h2
        []
        [ headerDesktop txt
        , headerMobile txt
        ]


headerDesktop : String -> Html Msg
headerDesktop txt =
    h2
        [ class "title has-text-weight-normal has-text-grey-darker is-hidden-mobile"
        , fontQuicksand
        , style
            [ ( "font-size", "4em" )
            , ( "margin-top", "-5rem" )
            ]
        ]
        [ text txt ]


headerMobile : String -> Html Msg
headerMobile txt =
    h2
        [ class "title is-size-1 has-text-weight-normal has-text-grey-darker is-hidden-tablet"
        , fontQuicksand
        , style [ ( "padding-bottom", "0.5rem" ) ]
        ]
        [ text txt ]


subheader : String -> Html Msg
subheader txt =
    h1
        []
        [ subheaderDesktop txt
        , subheaderMobile txt
        ]


subheaderDesktop : String -> Html Msg
subheaderDesktop txt =
    h1
        [ class "title is-size-3 has-text-weight-normal has-text-grey-dark is-hidden-mobile"
        , fontQuicksand
        , style [ ( "padding-bottom", "4rem" ) ]
        ]
        [ text txt ]


subheaderMobile : String -> Html Msg
subheaderMobile txt =
    h1
        [ class "title is-size-4 has-text-weight-normal has-text-grey-dark is-hidden-tablet"
        , fontQuicksand
        , style [ ( "padding-bottom", "3rem" ) ]
        ]
        [ text txt ]


copy : String -> Html Msg
copy txt =
    p
        []
        [ copyDesktop txt
        , copyMobile txt
        ]


copyDesktop : String -> Html Msg
copyDesktop txt =
    p
        [ class "is-size-5 has-text-weight-medium has-text-grey-copy is-hidden-mobile"
        , fontQuicksand
        ]
        [ text txt ]


copyMobile : String -> Html Msg
copyMobile txt =
    p
        [ class "is-size-6 has-text-weight-medium has-text-grey-copy is-hidden-tablet"
        , fontQuicksand
        , style [ ( "padding-bottom", "0.5rem" ) ]
        ]
        [ text txt ]


previewButton : String -> Html Msg
previewButton domId =
    a
        []
        [ previewButtonDesktop domId
        , previewButtonMobile domId
        ]


previewButtonDesktop : String -> Html Msg
previewButtonDesktop domId =
    a
        [ class "button is-info is-rounded is-hidden-mobile"
        , style [ ( "margin-top", "-4rem" ) ]
        , onClick (ToggleModal domId)
        ]
        [ icon "far fa-play-circle fa-lg"
        , iconText "Preview"
        ]


previewButtonMobile : String -> Html Msg
previewButtonMobile domId =
    a
        [ class "button is-info is-rounded is-hidden-tablet"
        , onClick (ToggleModal domId)
        ]
        [ icon "far fa-play-circle fa-lg"
        , iconText "Preview"
        ]


heroFoot : Model -> Html Msg
heroFoot model =
    div
        [ class "hero-foot" ]
        [ div
            [ class "container has-text-centered" ]
            [ case model.discover of
                RemoteData.NotAsked ->
                    tip "If you see this, someone really messed up."

                RemoteData.Loading ->
                    div [] []

                RemoteData.Success response ->
                    tip "Come back after you've listened to some more music, we'll have a completely new playlist for you."

                RemoteData.Failure err ->
                    tip "If this problem persists, please contact discovernow@protonmail.com."
            ]
        ]


tip : String -> Html Msg
tip txt =
    p
        []
        [ tipDesktop txt
        , tipMobile txt
        ]


tipDesktop : String -> Html Msg
tipDesktop txt =
    p
        [ class "is-size-5 has-text-weight-medium has-text-grey-copy is-hidden-mobile"
        , fontQuicksand
        , style
            [ ( "padding-bottom", "4rem" ) ]
        ]
        [ p
            [ class "has-text-weight-semibold is-inline" ]
            [ text "Tip: " ]
        , text txt
        ]


tipMobile : String -> Html Msg
tipMobile txt =
    p
        [ class "is-size-6 has-text-weight-medium has-text-grey-copy has-text-left is-hidden-tablet"
        , fontQuicksand
        , style
            [ ( "padding", "1rem 2rem 2rem" ) ]
        ]
        [ p
            [ class "has-text-weight-semibold is-inline" ]
            [ text "Tip: " ]
        , text txt
        ]


playlistModal : Playlist -> Html Msg
playlistModal playlist =
    div
        [ class "modal"
        , id "playlist-modal"
        ]
        [ div
            [ class "modal-background"
            , onClick (ToggleModal "playlist-modal")
            ]
            []
        , div
            [ class "modal-content has-text-centered" ]
            [ spotifyWidget playlist ]
        , button
            [ class "modal-close is-large is-hidden-desktop"
            , onClick (ToggleModal "playlist-modal")
            ]
            []
        ]


spotifyWidget : Playlist -> Html Msg
spotifyWidget playlist =
    div
        []
        [ iframe
            [ src (createPlaylistUri playlist)
            , width 600
            , height 700
            , attribute "frameborder" "0"
            , attribute "allowtransparency" "true"
            , attribute "allow" "encrypted-media"
            ]
            []
        ]


spotifyWidgetMobile : Playlist -> Html Msg
spotifyWidgetMobile playlist =
    div
        []
        [ iframe
            [ src (createPlaylistUri playlist)
            , width 300
            , height 500
            , attribute "frameborder" "0"
            , attribute "allowtransparency" "true"
            , attribute "allow" "encrypted-media"
            ]
            []
        ]


testspotifyWidget : Html Msg
testspotifyWidget =
    div
        []
        [ iframe
            [ src "https://open.spotify.com/embed?uri=spotify%3Auser%3Aspotify%3Aplaylist%3A2PXdUld4Ueio2pHcB6sM8j&theme=white"
            , width 300
            , height 500
            , attribute "frameborder" "0"
            , attribute "allowtransparency" "true"
            , attribute "allow" "encrypted-media"
            ]
            []
        ]


createPlaylistUri : Playlist -> String
createPlaylistUri playlist =
    "https://open.spotify.com/embed?uri=" ++ playlist.id
