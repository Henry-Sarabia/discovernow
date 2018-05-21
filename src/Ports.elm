port module Ports exposing (..)


port scrollIdIntoView : String -> Cmd msg


port scrollNextSibling : String -> Cmd msg


port scrollPrevSibling : String -> Cmd msg


port toggleModal : String -> Cmd msg
