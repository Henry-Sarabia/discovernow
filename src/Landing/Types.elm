module Landing.Types exposing (..)

import RemoteData exposing (WebData)

type alias Model =
    { login : WebData Login }


type Msg 
    = FetchLogin
    | OnFetchLogin (WebData Login)
    | LoadLogin String
    | ForceFetchLogin
    | OnForceFetchLogin (WebData Login)

type alias Login =
    { url : String } 