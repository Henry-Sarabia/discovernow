package main

import (
	"encoding/json"
	"github.com/Henry-Sarabia/blank"
	"github.com/Henry-Sarabia/discovernow/views"
	"github.com/pkg/errors"
	"html/template"
	"io/ioutil"
	"log"
	"net/http"
	"net/url"
	"time"
)

const APIURL string = "http://127.0.0.1:8080/api/v1/"

var home *views.View
var results *views.View

func main() {
	home = views.NewView("index", "views/home.gohtml")
	results = views.NewView("index", "views/results.gohtml")

	mux := &http.ServeMux{}

	mux.HandleFunc("/", indexHandler)
	mux.HandleFunc("/results", resultsHandler)
	mux.Handle("/static/", http.StripPrefix("/static/", http.FileServer(http.Dir("static"))))

	srv := &http.Server{
		Handler:      mux,
		Addr:         "127.0.0.1:3000",
		WriteTimeout: 15 * time.Second,
		ReadTimeout:  15 * time.Second,
	}

	log.Fatal(srv.ListenAndServe())
}

type serverError struct {
	Error error
	Message string
	Code int
}

func (e serverError) Log() {
	log.Printf("\n\terror: %v \n\tmessage: %s \n\tcode: %d", e.Error, e.Message, e.Code)
}

type errHandler func(http.ResponseWriter, *http.Request) *serverError

func (fn errHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	if err := fn(w, r); err != nil {
		err.Log()
	}
}

func indexHandler(w http.ResponseWriter, r *http.Request) {
	type auth struct {
		URL string `json:"url"`
	}

	resp, err := http.Get(APIURL + "login")
	if err != nil {
		serverError{
			Error: err,
			Message: "Cannot connect to login endpoint",
			Code: http.StatusBadGateway,
		}.Log()

		home.Render(w, auth{})
		return
	}
	defer resp.Body.Close()

	b, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		serverError{
			Error: err,
			Message: "Invalid response body from login endpoint",
			Code: http.StatusInternalServerError,
		}.Log()

		home.Render(w, auth{})
		return
	}

	au := &auth{}

	err = json.Unmarshal(b, &au)
	if err != nil {
		serverError{
			Error: err,
			Message: "Cannot unmarshal JSON response from login endpoint",
			Code: http.StatusInternalServerError,
		}.Log()

		home.Render(w, auth{})
		return
	}

	home.Render(w, au)
}

func resultsHandler(w http.ResponseWriter, r *http.Request) {
	type playlist struct {
		URI template.URL `json:"uri"`
	}

	q := r.URL.Query()

	code := q.Get("code")
	if blank.Is(code) {
		serverError{
			Error: errors.New("results url is missing code"),
			Message: "Results URL is missing code parameter",
			Code: http.StatusInternalServerError,
		}.Log()

		results.Render(w, nil)
	}

	state := q.Get("state")
	if blank.Is(state) {
		serverError{
			Error: errors.New("results url is missing state"),
			Message: "Results URL is missing state parameter",
			Code: http.StatusInternalServerError,
		}.Log()

		results.Render(w, nil)
	}

	v := url.Values{}
	v.Set("code", code)
	v.Set("state", state)

	resp, err := http.Get(APIURL + "playlist" + "?" + v.Encode())
	if err != nil {
		serverError{
			Error: err,
			Message: "Cannot connect to playlist endpoint",
			Code: http.StatusBadGateway,
		}.Log()

		results.Render(w, nil)
	}
	defer resp.Body.Close()

	b, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		serverError{
			Error: err,
			Message: "Invalid response body from playlist endpoint",
			Code: http.StatusInternalServerError,
		}.Log()

		results.Render(w, nil)
	}

	list := &playlist{}

	err = json.Unmarshal(b, &list)
	if err != nil {
		serverError{
			Error: err,
			Message: "Cannot unmarshal JSON response from playlist endpoint",
			Code: http.StatusInternalServerError,
		}.Log()

		results.Render(w, nil)
	}

	if blank.Is(string(list.URI)) {
		serverError {
			Error: err,
			Message: "URI value is blank",
			Code: http.StatusInternalServerError,
		}.Log()

		results.Render(w, nil)
	}

	results.Render(w, list)
}

