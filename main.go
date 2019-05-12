package main

import (
	"encoding/json"
	"github.com/Henry-Sarabia/blank"
	"github.com/Henry-Sarabia/discovernow/views"
	"github.com/pkg/errors"
	"html/template"
	"io/ioutil"
	"net/http"
	"net/url"
)

const APIURL string = "http://127.0.0.1:8080/api/v1/"

var home *views.View
var results *views.View

func main() {
	home = views.NewView("index", "views/home.gohtml")
	results = views.NewView("index", "views/results.gohtml")

	http.Handle("/", errHandler(indexHandler))
	http.Handle("/results", errHandler(resultsHandler))
	http.Handle("/static/", http.StripPrefix("/static/", http.FileServer(http.Dir("static"))))
	http.ListenAndServe(":3000", nil)
}

type serverError struct {
	Error error
	Message string
	Code int
}

type errHandler func(http.ResponseWriter, *http.Request) *serverError

func (fn errHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	if err := fn(w, r); err != nil {
		http.Error(w, err.Message, err.Code)
	}
}

func indexHandler(w http.ResponseWriter, r *http.Request) *serverError {
	type login struct {
		URL string `json:"url"`
	}

	resp, err := http.Get(APIURL + "login")
	if err != nil {
		return &serverError{
			Error: err,
			Message: "Cannot connect to login endpoint",
			Code: http.StatusBadGateway,
		}
	}
	defer resp.Body.Close()

	b, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return &serverError{
			Error: err,
			Message: "Invalid response body from login endpoint",
			Code: http.StatusInternalServerError,
		}
	}

	log := &login{}

	err = json.Unmarshal(b, &log)
	if err != nil {
		return &serverError{
			Error: err,
			Message: "Cannot unmarshal JSON response from login endpoint",
			Code: http.StatusInternalServerError,
		}
	}

	home.Render(w, log)
	//dummy := login{URL: "http://127.0.0.1:3000/results"}
	//home.Render(w, dummy)
	return nil
}

func resultsHandler(w http.ResponseWriter, r *http.Request) *serverError {
	type playlist struct {
		URI template.URL `json:"uri"`
	}

	q := r.URL.Query()

	code := q.Get("code")
	if blank.Is(code) {
		return &serverError{
			Error: errors.New("results url is missing code"),
			Message: "Results URL is missing code parameter",
			Code: http.StatusInternalServerError,
		}
	}

	state := q.Get("state")
	if blank.Is(state) {
		return &serverError{
			Error: errors.New("results url is missing state"),
			Message: "Results URL is missing state parameter",
			Code: http.StatusInternalServerError,
		}
	}

	v := url.Values{}
	v.Set("code", code)
	v.Set("state", state)

	resp, err := http.Get(APIURL + "playlist" + "?" + v.Encode())
	if err != nil {
		return &serverError{
			Error: err,
			Message: "Cannot connect to playlist endpoint",
			Code: http.StatusBadGateway,
		}
	}
	defer resp.Body.Close()

	b, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return &serverError{
			Error: err,
			Message: "Invalid response body from playlist endpoint",
			Code: http.StatusInternalServerError,
		}
	}

	list := &playlist{}

	err = json.Unmarshal(b, &list)
	if err != nil {
		return &serverError{
			Error: err,
			Message: "Cannot unmarshal JSON response from playlist endpoint",
			Code: http.StatusInternalServerError,
		}
	}

	if blank.Is(string(list.URI)) {
		return &serverError {
			Error: err,
			Message: "URI value is blank",
			Code: http.StatusInternalServerError,
		}
	}

	results.Render(w, list)

	//dummy := &playlist{URI: "something"}
	//results.Render(w, dummy)
	return nil
}

