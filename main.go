package main

import (
	"encoding/json"
	"github.com/Henry-Sarabia/discovernow/views"
	"io/ioutil"
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

type Login struct {
	URL string `json:"url"`
}

func indexHandler(w http.ResponseWriter, r *http.Request) {
	resp, err := http.Get("http://127.0.0.1:8080/api/v1/login")
	if err != nil {
		panic(err)
	}
	defer resp.Body.Close()

	b, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		panic(err)
	}

	login := &Login{}

	err = json.Unmarshal(b, &login)
	if err != nil {
		panic(err)
	}

	landing.Render(w, login)
}

func resultsHandler(w http.ResponseWriter, r *http.Request) {
	results.Render(w, nil)
}