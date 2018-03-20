module Landing.Types exposing (..)

import RemoteData exposing (WebData)

type alias Model =
    { login : WebData Login }


type Msg 
    = FetchLogin
    | OnFetchLogin (WebData Login)
    | LoadLogin String

type alias Login =
    { url : String } 