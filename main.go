package main

import (
	"github.com/Henry-Sarabia/discovernow/views"
	spotifyservice "github.com/Henry-Sarabia/refind/spotify"
	"github.com/gorilla/handlers"
	"github.com/gorilla/mux"
	"log"
	"net/http"
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

func notFoundHandler(w http.ResponseWriter, r *http.Request) {
	_ = notFound.Render(w, nil)
}
