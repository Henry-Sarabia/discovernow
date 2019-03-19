package main

import (
	"github.com/Henry-Sarabia/discovernow/views"
	"net/http"
)

var landing *views.View
var results *views.View

func main() {
	landing = views.NewView("frame", "views/landing.gohtml")
	results = views.NewView("frame", "views/results.gohtml")

	http.HandleFunc("/", indexHandler)
	http.HandleFunc("/results", resultsHandler)
	http.ListenAndServe(":3000", nil)
}

func indexHandler(w http.ResponseWriter, r *http.Request) {
	landing.Render(w, nil)
}

func resultsHandler(w http.ResponseWriter, r *http.Request) {
	results.Render(w, nil)
}