module Views.About exposing (root)

import Html exposing (Html, div, text)
import Models exposing (Model, Login)
import Msgs exposing (Msg(..))


root : Model -> Html Msg
root model =
    div
        []
        [ text "about meeeeeeeeeeeeee"
        ]
