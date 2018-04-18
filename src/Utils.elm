module Utils exposing (..)

import Http
import Html exposing (Attribute)
import Html.Events exposing (onWithOptions)
import Json.Decode as Decode
import Models exposing (Direction(..))
import Msgs exposing (Msg(..))
import Wheel


onLinkClick : Msg -> Attribute Msg
onLinkClick msg =
    let
        options =
            { stopPropagation = False
            , preventDefault = True
            }
    in
        onWithOptions "click" options (Decode.succeed msg)


siblingScroll : String -> (Wheel.Event -> Msg)
siblingScroll domId =
    \event ->
        if event.deltaY > 0 then
            OnScroll Up domId
        else
            OnScroll Down domId


onWheelScroll : String -> Attribute Msg
onWheelScroll domId =
    Wheel.onWheel (siblingScroll domId)


errorToString : Http.Error -> String
errorToString err =
    case err of
        Http.BadUrl url ->
            "Bad URL: " ++ url

        Http.Timeout ->
            "HTTP Timeout"

        Http.NetworkError ->
            "Network Error"

        Http.BadStatus resp ->
            "Bad Status: " ++ toString resp.status.code ++ " (" ++ toString resp.body ++ ")"

        -- toString resp.body
        Http.BadPayload message resp ->
            "Bad Payload: " ++ toString message ++ " (" ++ toString resp.status.code ++ ")"
