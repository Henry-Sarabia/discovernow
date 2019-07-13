package main

import (
	"encoding/hex"
	"encoding/json"
	"github.com/Henry-Sarabia/blank"
	"github.com/Henry-Sarabia/discovernow/views"
	spotifyservice "github.com/Henry-Sarabia/refind/spotify"
	"github.com/gorilla/handlers"
	"github.com/gorilla/mux"
	"github.com/gorilla/sessions"
	"github.com/pkg/errors"
	"github.com/zmb3/spotify"
	"html/template"
	"io/ioutil"
	"log"
	"net/http"
	"net/url"
	"os"
	"time"
)

const (
	APIURL          string = "http://127.0.0.1:3000/api/v1/"
	redirectPath    string = "/results"
	state           string = "abc123"
	hashKeyName     string = "DISCOVER_HASH"
	storeAuthName   string = "DISCOVER_AUTH"
	storeCryptName  string = "DISCOVER_CRYPT"
	frontendURIName string = "FRONTEND_URI"
)

var (
	landing  *views.View
	result   *views.View
	notFound *views.View

	hashKey     string
	storeAuth   string
	storeCrypt  string
	store       sessions.CookieStore
	frontendURI string
	auth        *spotify.Authenticator
)

func init() {
	var err error

	hashKey, err = decodeEnv(hashKeyName)
	if err != nil {
		log.Fatal(err)
	}

	storeAuth, err = decodeEnv(storeAuthName)
	if err != nil {
		log.Fatal(err)
	}

	storeCrypt, err = decodeEnv(storeCryptName)
	if err != nil {
		log.Fatal(err)
	}

	frontendURI, err = getEnv(frontendURIName)
	if err != nil {
		log.Fatal(err)
	}

	auth, err = spotifyservice.Authenticator(frontendURI + redirectPath)
	if err != nil {
		log.Fatalf("stack trace:\n%+v\n", err)
	}
}

func decodeEnv(name string) (string, error) {
	env, err := getEnv(name)
	if err != nil {
		return "", err
	}

	d, err := hex.DecodeString(env)
	if err != nil {
		return "", errors.Wrapf(err, "environment variable with name '%s' cannot be decoded from hex", name)
	}

	return string(d), nil
}

func getEnv(name string) (string, error) {
	env, ok := os.LookupEnv(name)
	if !ok {
		return "", errors.Errorf("environment variable with name '%s' cannot be found", name)
	}

	return env, nil
}

func main() {
	landing = views.NewView("index", "views/landing.gohtml")
	result = views.NewView("index", "views/result.gohtml")
	notFound = views.NewView("index", "views/notfound.gohtml")

	r := mux.NewRouter()
	r.Use(handlers.RecoveryHandler())
	r.NotFoundHandler = http.HandlerFunc(notFoundHandler)

	r.Handle("/", errHandler(landingHandler))
	r.Handle("/results", errHandler(resultHandler))
	r.PathPrefix("/static/").Handler(http.StripPrefix("/static/", http.FileServer(http.Dir("static"))))

	api := r.PathPrefix("/api/v1/").Subrouter()
	api.HandleFunc("/login", loginHandler)
	api.Handle("/playlist", errHandler(playlistHandler))

	srv := &http.Server{
		Handler:      handlers.LoggingHandler(os.Stdout, r),
		Addr:         "127.0.0.1:3000",
		WriteTimeout: 15 * time.Second,
		ReadTimeout:  15 * time.Second,
	}

	log.Fatal(srv.ListenAndServe())
}

type serverError struct {
	Error   error
	Message string
	Code    int
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
			Error:   err,
			Message: "Cannot connect to login endpoint",
			Code:    http.StatusBadGateway,
		}
	}
	defer resp.Body.Close()

	b, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		_ = landing.Render(w, auth{})
		return &serverError{
			Error:   err,
			Message: "Invalid response body from login endpoint",
			Code:    http.StatusInternalServerError,
		}
	}

	au := &auth{}

	err = json.Unmarshal(b, &au)
	if err != nil {
		_ = landing.Render(w, auth{})
		return &serverError{
			Error:   err,
			Message: "Cannot unmarshal JSON response from login endpoint",
			Code:    http.StatusInternalServerError,
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
			Error:   errors.New("result url is missing code"),
			Message: "Results URL is missing code parameter",
			Code:    http.StatusInternalServerError,
		}
	}

	state := q.Get("state")
	if blank.Is(state) {
		_ = result.Render(w, playlist{})
		return &serverError{
			Error:   errors.New("result url is missing state"),
			Message: "Results URL is missing state parameter",
			Code:    http.StatusInternalServerError,
		}
	}

	v := url.Values{}
	v.Set("code", code)
	v.Set("state", state)

	resp, err := http.Get(APIURL + "playlist" + "?" + v.Encode())
	if err != nil {
		_ = result.Render(w, playlist{})
		return &serverError{
			Error:   err,
			Message: "Cannot connect to playlist endpoint",
			Code:    http.StatusBadGateway,
		}
	}
	defer resp.Body.Close()

	b, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		_ = result.Render(w, playlist{})
		return &serverError{
			Error:   err,
			Message: "Invalid response body from playlist endpoint",
			Code:    http.StatusInternalServerError,
		}
	}

	list := &playlist{}

	err = json.Unmarshal(b, &list)
	if err != nil {
		_ = result.Render(w, playlist{})
		return &serverError{
			Error:   err,
			Message: "Cannot unmarshal JSON response from playlist endpoint",
			Code:    http.StatusInternalServerError,
		}
	}

	if blank.Is(string(list.URI)) {
		_ = result.Render(w, playlist{})
		return &serverError{
			Error:   err,
			Message: "URI value is blank",
			Code:    http.StatusInternalServerError,
		}
	}

	_ = result.Render(w, list)
	return nil
}

func notFoundHandler(w http.ResponseWriter, r *http.Request) {
	_ = notFound.Render(w, nil)
}
