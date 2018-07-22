module Utils exposing (..)

import Html exposing (Html, Attribute, div)
import Html.Attributes exposing (class)
import Html.Events exposing (onWithOptions)
import Json.Decode as Decode
import Msgs exposing (Msg(..))


onLinkClick : Msg -> Attribute Msg
onLinkClick msg =
    let
        options =
            { stopPropagation = False
            , preventDefault = True
            }
    in
        onWithOptions "click" options (Decode.succeed msg)


columns : List (Html Msg) -> Html Msg
columns children =
    div
        [ class "columns" ]
        (List.map column children)


column : Html Msg -> Html Msg
column child =
    div
        [ class "column" ]
        [ child ]
