module Views.About exposing (root)

import Html exposing (Html, div, text, h1, h2, nav, section, span, a, p, i, hr, article)
import Html.Attributes exposing (class, style, alt, id, attribute, href)
import Html.Events exposing (onClick)
import Models exposing (Model, Login)
import Msgs exposing (Msg(..))
import RemoteData exposing (WebData)
import Routing exposing (aboutPath)
import Utils exposing (..)


root : Model -> Html Msg
root model =
    div
        []
        [ text "about meeeeeeeeeeeeee"
        ]
