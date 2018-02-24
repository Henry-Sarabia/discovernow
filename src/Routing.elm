module Routing exposing (..)

import Navigation
import UrlParser exposing (s, top, (<?>), stringParam)

type Route
    = HomeRoute
    | AboutRoute
    | ResultsRoute (Maybe String) (Maybe String)
    | NotFoundRoute
 

matchers : UrlParser.Parser (Route -> a) a
matchers =
    UrlParser.oneOf
        [ UrlParser.map HomeRoute top
        , UrlParser.map AboutRoute (s "about")
        , UrlParser.map ResultsRoute (s "results" <?> stringParam "code" <?> stringParam "state")
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