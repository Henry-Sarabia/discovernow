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

var landing *views.View
var result *views.View

func main() {
	landing = views.NewView("index", "views/landing.gohtml")
	result = views.NewView("index", "views/result.gohtml")

	mux := &http.ServeMux{}

	mux.Handle("/", errHandler(landingHandler))
	mux.Handle("/results", errHandler(resultHandler))
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
	log.Printf("\n\terror: %v \n\tmessage: %s \n\tcode: %d\n\n", e.Error, e.Message, e.Code)
}

type errHandler func(http.ResponseWriter, *http.Request) *serverError

func (fn errHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	if err := fn(w, r); err != nil {
		err.Log()
	}
}

func landingHandler(w http.ResponseWriter, r *http.Request) *serverError {
	type auth struct {
		URL string `json:"url"`
	}

	resp, err := http.Get(APIURL + "login")
	if err != nil {
		_ = landing.Render(w, auth{})
		return &serverError{
			Error: err,
			Message: "Cannot connect to login endpoint",
			Code: http.StatusBadGateway,
		}
	}
	defer resp.Body.Close()

	b, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		_ = landing.Render(w, auth{})
		return &serverError{
			Error: err,
			Message: "Invalid response body from login endpoint",
			Code: http.StatusInternalServerError,
		}
	}

	au := &auth{}

	err = json.Unmarshal(b, &au)
	if err != nil {
		_ = landing.Render(w, auth{})
		return &serverError{
			Error: err,
			Message: "Cannot unmarshal JSON response from login endpoint",
			Code: http.StatusInternalServerError,
		}
	}

	_ = landing.Render(w, au)
	return nil
}

func resultHandler(w http.ResponseWriter, r *http.Request) *serverError {
	type playlist struct {
		URI template.URL `json:"uri"`
	}

	q := r.URL.Query()

	code := q.Get("code")
	if blank.Is(code) {
		_ = result.Render(w, &playlist{})
		return &serverError{
			Error: errors.New("result url is missing code"),
			Message: "Results URL is missing code parameter",
			Code: http.StatusInternalServerError,
		}
	}

	state := q.Get("state")
	if blank.Is(state) {
		_ = result.Render(w, playlist{})
		return &serverError{
			Error: errors.New("result url is missing state"),
			Message: "Results URL is missing state parameter",
			Code: http.StatusInternalServerError,
		}
	}

	v := url.Values{}
	v.Set("code", code)
	v.Set("state", state)

	resp, err := http.Get(APIURL + "playlist" + "?" + v.Encode())
	if err != nil {
		_ = result.Render(w, playlist{})
		return &serverError{
			Error: err,
			Message: "Cannot connect to playlist endpoint",
			Code: http.StatusBadGateway,
		}
	}
	defer resp.Body.Close()

	b, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		_ = result.Render(w, playlist{})
		return &serverError{
			Error: err,
			Message: "Invalid response body from playlist endpoint",
			Code: http.StatusInternalServerError,
		}
	}

	list := &playlist{}

	err = json.Unmarshal(b, &list)
	if err != nil {
		_ = result.Render(w, playlist{})
		return &serverError{
			Error: err,
			Message: "Cannot unmarshal JSON response from playlist endpoint",
			Code: http.StatusInternalServerError,
		}
	}

	if blank.Is(string(list.URI)) {
		_ = result.Render(w, playlist{})
		return &serverError {
			Error: err,
			Message: "URI value is blank",
			Code: http.StatusInternalServerError,
		}
	}

	_ = result.Render(w, list)
	return nil
}

