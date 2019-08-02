package main

import (
	"encoding/json"
	"github.com/Henry-Sarabia/blank"
	"github.com/Henry-Sarabia/discovernow/views"
	spotifyservice "github.com/Henry-Sarabia/refind/spotify"
	"github.com/gorilla/handlers"
	"github.com/gorilla/mux"
	"github.com/pkg/errors"
	"io/ioutil"
	"log"
	"net/http"
	"net/url"
	"os"
	"strings"
	"time"
)

const (
	apiPath      string = "/api/v1/"
	loginPath    string = "login"
	playlistPath string = "playlist"
	redirectPath string = "/results"
	state        string = "abc123"

	hashKeyName     string = "DISCOVER_HASH"
	storeAuthName   string = "DISCOVER_AUTH"
	storeCryptName  string = "DISCOVER_CRYPT"
	frontendURIName string = "FRONTEND_URI"
)

var (
	landing  *views.View
	result   *views.View
	notFound *views.View

	hashKey    string
	storeAuth  string
	storeCrypt string
	//store       sessions.CookieStore
	frontendURI string
)

func main() {
	landing = views.NewView("index", "views/landing.gohtml")
	result = views.NewView("index", "views/result.gohtml")
	notFound = views.NewView("index", "views/notfound.gohtml")

	auth, err := spotifyservice.Authenticator(frontendURI + redirectPath)
	if err != nil {
		log.Fatalf("stack trace:\n%+v\n", err)
	}

	env := &Env{
		Auth: auth,
	}

	r := mux.NewRouter()

	r.Use(handlers.RecoveryHandler())
	r.NotFoundHandler = http.HandlerFunc(notFoundHandler)

	r.Handle("/", Handler{env, landingHandler})
	r.Handle(redirectPath, Handler{env, resultHandler})
	r.PathPrefix("/static/").Handler(http.StripPrefix("/static/", http.FileServer(http.Dir("static"))))

	api := r.PathPrefix(apiPath).Subrouter()
	api.Handle("/"+loginPath, Handler{env, loginHandler})
	api.Handle("/"+playlistPath, Handler{env, playlistHandler})

	srv := &http.Server{
		Handler:      handlers.LoggingHandler(os.Stdout, r),
		Addr:         strings.TrimPrefix(frontendURI, "http://"),
		WriteTimeout: 15 * time.Second,
		ReadTimeout:  15 * time.Second,
	}

	log.Fatal(srv.ListenAndServe())
}

func landingHandler(env *Env, w http.ResponseWriter, r *http.Request) error {
	resp, err := http.Get(frontendURI + apiPath + loginPath)
	if err != nil {
		_ = landing.Render(w, login{})
		return StatusError{http.StatusBadGateway, err}
	}
	defer resp.Body.Close()

	b, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		_ = landing.Render(w, login{})
		return StatusError{http.StatusInternalServerError, err}
	}

	l := &login{}

	err = json.Unmarshal(b, &l)
	if err != nil {
		_ = landing.Render(w, login{})
		return StatusError{http.StatusInternalServerError, err}
	}

	_ = landing.Render(w, l) //TODO: check if returning this function is enough; renderTemplate
	return nil
}

func resultHandler(env *Env, w http.ResponseWriter, r *http.Request) error {
	q := r.URL.Query()

	code := q.Get("code")
	if blank.Is(code) {
		_ = result.Render(w, &playlist{})
		return StatusError{http.StatusInternalServerError, errors.New("result url is missing code")}
	}

	state := q.Get("state")
	if blank.Is(state) {
		_ = result.Render(w, playlist{})
		return StatusError{http.StatusInternalServerError, errors.New("result url is missing state")}
	}

	v := url.Values{}
	v.Set("code", code)
	v.Set("state", state)

	resp, err := http.Get(frontendURI + apiPath + playlistPath + "?" + v.Encode())
	if err != nil {
		_ = result.Render(w, playlist{})
		return StatusError{http.StatusBadGateway, err}
	}
	defer resp.Body.Close()

	b, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		_ = result.Render(w, playlist{})
		return StatusError{http.StatusInternalServerError, errors.Wrap(err, "invalid response body from playlist endpoint")}
	}

	play := &playlist{}

	err = json.Unmarshal(b, &play)
	if err != nil {
		_ = result.Render(w, playlist{})
		return StatusError{http.StatusInternalServerError, errors.Wrap(err, "cannot unmarshal JSON response from playlist endpoint")}
	}

	if blank.Is(string(play.URI)) {
		_ = result.Render(w, playlist{})
		return StatusError{http.StatusInternalServerError, errors.Wrap(err, "URI value is blank")}
	}

	_ = result.Render(w, play)
	return nil
}

func notFoundHandler(w http.ResponseWriter, r *http.Request) {
	_ = notFound.Render(w, nil)
}
