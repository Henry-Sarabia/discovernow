package main

import (
	"fmt"
	"github.com/Henry-Sarabia/discovernow/views"
	spotserv "github.com/Henry-Sarabia/refind/spotify"
	envvar "github.com/caarlos0/env"
	"github.com/gorilla/handlers"
	"github.com/gorilla/mux"
	"github.com/pkg/errors"
	"log"
	"net/http"
	"os"
	"strings"
	"time"
)

const (
	apiPath      string = "/api/v1"
	loginPath    string = "/login"
	playlistPath string = "/playlist"
	redirectPath string = "/results"
	state        string = "abc123"

	indexLayout  string = "index"
	landingView  string = "landing"
	resultView   string = "result"
	notfoundView string = "notfound"
)

func main() {
	cfg := config{}
	if err := envvar.Parse(&cfg); err != nil {
		log.Fatalf("%+v\n", err)
	}

	auth, err := spotserv.Authenticator(cfg.FrontendURI + redirectPath)
	if err != nil {
		log.Fatalf("stack trace:\n%+v\n", err)
	}

	env := &Env{
		Auth: auth,
		Views: map[string]*views.View{
			landingView:  views.NewView(indexLayout, fmt.Sprintf("views/%s.gohtml", landingView)),
			resultView:   views.NewView(indexLayout, fmt.Sprintf("views/%s.gohtml", resultView)),
			notfoundView: views.NewView(indexLayout, fmt.Sprintf("views/%s.gohtml", notfoundView)),
		},
		FrontendURI: cfg.FrontendURI,
	}

	r := mux.NewRouter()

	r.Use(handlers.RecoveryHandler())
	r.NotFoundHandler = Handler{env, notFoundHandler}

	r.Handle("/", Handler{env, landingHandler})
	r.Handle(redirectPath, Handler{env, resultHandler})
	r.PathPrefix("/static/").Handler(http.StripPrefix("/static/", http.FileServer(http.Dir("static"))))

	api := r.PathPrefix(apiPath + "/").Subrouter()
	api.Handle(loginPath, Handler{env, loginHandler})
	api.Handle(playlistPath, Handler{env, playlistHandler})

	srv := &http.Server{
		Handler:      handlers.LoggingHandler(os.Stdout, r),
		Addr:         strings.TrimPrefix(cfg.FrontendURI, "http://"),
		WriteTimeout: 15 * time.Second,
		ReadTimeout:  15 * time.Second,
	}

	log.Fatal(srv.ListenAndServe())
}

func notFoundHandler(env *Env, w http.ResponseWriter, r *http.Request) error {
	v, ok := env.Views[notfoundView]
	if !ok {
		return errors.Errorf("cannot find '%s' view", notfoundView)
	}
	return v.Render(w, nil)
}
