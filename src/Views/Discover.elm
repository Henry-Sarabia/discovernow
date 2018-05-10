module Views.Discover exposing (root)

import Http
import Html exposing (Html, div, text, span, a, iframe, p, h1, button)
import Html.Attributes exposing (class, style, id, src, height, width, attribute)
import Html.Events exposing (onClick)
import Models exposing (Model, Token, Playlist)
import Msgs exposing (Msg(..))
import RemoteData exposing (WebData)
import Utils exposing (..)
import Views.Common exposing (..)
import Views.Header exposing (heroNavbar)
import Views.Footer exposing (heroFooter)


root : Model -> Token -> Html Msg
root model token =
    div
        []
        [ hero model token
        , playlistModal model.discover
        ]


hero : Model -> Token -> Html Msg
hero model token =
    div
        [ class "hero is-fullheight is-dark"
        , photoBackgroundStyle "images/albums.jpg" 0.6
        ]
        [ heroNavbar
        , heroBody model
        , heroFooter
        ]


heroBody : Model -> Html Msg
heroBody model =
    div
        [ class "hero-body" ]
        [ div
            [ class "container has-text-centered" ]
            [ phaseHeader "Success!"
            , phaseSub "Something you'll love is waiting for you on your Spotify account."
            , previewButton "playlist-modal"
            ]
        ]


previewButton : String -> Html Msg
previewButton domId =
    a
        [ class "button is-link is-rounded"
        , onClick (ToggleModal domId)
        ]
        [ icon "far fa-play-circle fa-lg"
        , iconText "Preview"
        ]


phaseHeader : String -> Html Msg
phaseHeader txt =
    h1
        [ class "title"
        , style
            [ ( "font-size", "7em" )
            , ( "font-weight", "200" )
            , ( "font-family", "Quicksand" )
            ]
        ]
        [ text txt ]


phaseSub : String -> Html Msg
phaseSub txt =
    p
        [ class "subtitle is-size-3 has-text-weight-light"

        -- , style [ ( "font-family", "Quicksand" ) ]
        ]
        [ text txt ]


playlistModal : WebData Playlist -> Html Msg
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
            [ class "modal-content has-text-centered"

            -- , style [ ( "background-color", "white" ) ]
            ]
            [ playlistResults playlist
            ]
        , button
            [ class "modal-close is-large is-hidden-desktop"
            , onClick (ToggleModal "playlist-modal")
            ]
            []
        ]


playlistResults : WebData Playlist -> Html Msg
playlistResults playlist =
    case playlist of
        RemoteData.NotAsked ->
            text "not asked"

        RemoteData.Loading ->
            text "loading"

        RemoteData.Success response ->
            -- text response.id
            playButton response

        RemoteData.Failure err ->
            -- errorHelp err
            testPlayButton


playButton : Playlist -> Html Msg
playButton playlist =
    div
        []
        [ iframe
            -- [ src "https://open.spotify.com/embed?uri=spotify%3Auser%3Aspotify%3Aplaylist%3A2PXdUld4Ueio2pHcB6sM8j"
            [ src (createPlaylistUri playlist)
            , width 600
            , height 700
            ]
            []
        ]


testPlayButton : Html Msg
testPlayButton =
    div
        []
        [ iframe
            [ src "https://open.spotify.com/embed?uri=spotify%3Auser%3Aspotify%3Aplaylist%3A2PXdUld4Ueio2pHcB6sM8j&theme=white"

            -- , width 300
            , width 640
            , height 380
            , attribute "frameborder" "0"
            , attribute "allowtransparency" "true"
            , attribute "allow" "encrypted-media"
            ]
            []
        ]


createPlaylistUri : Playlist -> String
createPlaylistUri playlist =
    "https://open.spotify.com/embed?uri=" ++ playlist.id


errorHelp : Http.Error -> Html Msg
errorHelp err =
    div
        [ class "message is-warning" ]
        [ div
            [ class "message-header" ]
            [ text "Uh-oh" ]
        , div
            [ class "message-body" ]
            [ text "Seems like you found an error"
            , text (errorToString err)
            ]
        ]



-- spotify:user:blaqkangel:playlist:0MZvTfj3xPcRa7D0LGQeHs
