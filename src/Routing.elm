module Routing exposing (..)

import Navigation
import UrlParser exposing (s, top, (<?>), stringParam)


type Route
    = LandingRoute
    | AboutRoute
    | ResultsRoute (Maybe String) (Maybe String)
    | ErrorRoute
    | NotFoundRoute


matchers : UrlParser.Parser (Route -> a) a
matchers =
    UrlParser.oneOf
        [ UrlParser.map LandingRoute top
        , UrlParser.map AboutRoute (s "about")
        , UrlParser.map ResultsRoute (s "results" <?> stringParam "code" <?> stringParam "state")
        , UrlParser.map ErrorRoute (s "error")
        ]


parseLocation : Navigation.Location -> Route
parseLocation location =
    case (UrlParser.parsePath matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


homePath : String
homePath =
    "/"


aboutPath : String
aboutPath =
    "/about"


resultsPath : String
resultsPath =
    "/results"


errorPath : String
errorPath =
    "/error"
