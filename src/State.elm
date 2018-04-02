module State exposing (..)
 
import Discover.State as Discover
import Landing.State as Landing
import Navigation 
import Routing exposing (..) 
import Spotify.Types exposing (Token)
import Types exposing (..)
 
init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let 
        currentRoute =
            parseLocation location
    in
        ( initialModel currentRoute, initialCommands ) 

 
initialModel : Route -> Model
initialModel route =
    case route of 
        LandingRoute ->
            baseModel route
            
        AboutRoute ->
            baseModel route

        ResultsRoute maybeCode maybeState ->
            case (maybeCode, maybeState) of
                ( Just newCode, Just newState ) ->
                    let
                        newToken = Just (Token newCode newState) 
                    in
                        { route = route
                        , changes = 0 
                        , token = newToken
                        , landing = Landing.initialModel
                        , discover = Discover.initialModel
                        }
                    
                ( Nothing, _ ) ->
                    baseModel route 

                ( _, Nothing ) ->
                    baseModel route

        ErrorRoute ->
            baseModel route

        NotFoundRoute -> 
            baseModel route
 

baseModel : Route -> Model
baseModel route =
    { route = route
    , changes = 0
    , token = Nothing
    , landing = Landing.initialModel
    , discover = Discover.initialModel
    }
 

initialCommands : Cmd Msg 
initialCommands =
    Cmd.batch 
        [ Cmd.map LandingMsg Landing.initialCommands
        , Cmd.map DiscoverMsg Discover.initialCommands
        ] 


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeLocation path ->
            ( { model | changes = model.changes + 1 }, Navigation.newUrl path )

        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )

        LandingMsg subMsg ->
            let
                (newModel, newCmd) = 
                    Landing.update subMsg model.landing
            in
                ( { model | landing = newModel }, Cmd.map LandingMsg newCmd )
                
        DiscoverMsg subMsg ->
            let 
                (newModel, newCmd) =
                    Discover.update subMsg model.discover
            in
                ( { model | discover = newModel }, Cmd.map DiscoverMsg newCmd )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none