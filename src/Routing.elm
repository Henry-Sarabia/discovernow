module Routing exposing (..)

import Navigation
import UrlParser

type Route
    = HomeRoute
    | AboutRoute
    | ResultsRoute
    | NotFoundRoute
 

matchers : UrlParser.Parser (Route -> a) a
matchers =
    UrlParser.oneOf
        [ UrlParser.map HomeRoute UrlParser.top
        , UrlParser.map AboutRoute (UrlParser.s "about")
        , UrlParser.map ResultsRoute (UrlParser.s "results")
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