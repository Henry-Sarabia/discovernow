package main

import (
	"fmt"
	"github.com/Henry-Sarabia/discovernow/views"
	spotserv "github.com/Henry-Sarabia/refind/spotify"
	"github.com/gorilla/handlers"
	"github.com/gorilla/mux"
	"github.com/gorilla/sessions"
	"github.com/pkg/errors"
	"log"
	"net/http"
	"os"
	"strconv"
	"strings"
	"time"
)

const (
	apiPath      string = "/api/v1"
	loginPath    string = "/login"
	playlistPath string = "/playlist"
	redirectPath string = "/results"
	sessionName  string = "discover_now"

	indexLayout  string = "index"
	landingView  string = "landing"
	resultView   string = "result"
	notfoundView string = "notfound"

	production  string = "DISCOVER_PRODUCTION"
	hashKey     string = "DISCOVER_HASH"
	storeAuth   string = "DISCOVER_AUTH"
	storeCrypt  string = "DISCOVER_CRYPT"
	frontendURI string = "FRONTEND_URI" //TODO: prepend with 'DISCOVER'
)

func main() {
	prod, err := strconv.ParseBool(mustGetEnv(production))
	if err != nil {
		log.Fatal(err)
	}

	store := sessions.NewCookieStore(mustDecodeHexEnv(storeAuth), mustDecodeHexEnv(storeCrypt))
	store.Options = &sessions.Options{
		Path:     "/",
		HttpOnly: true,
		Secure:   prod,
		MaxAge:   0,
	}

	auth, err := spotserv.Authenticator(mustGetEnv(frontendURI) + redirectPath)
	if err != nil {
		log.Fatalf("stack trace:\n%+v\n", err)
	}

	env := &Env{
		Store: store,
		Auth:  auth,
		Views: map[string]*views.View{
			landingView:  views.NewView(indexLayout, fmt.Sprintf("views/%s.gohtml", landingView)),
			resultView:   views.NewView(indexLayout, fmt.Sprintf("views/%s.gohtml", resultView)),
			notfoundView: views.NewView(indexLayout, fmt.Sprintf("views/%s.gohtml", notfoundView)),
		},
		FrontendURI: mustGetEnv(frontendURI),
		HashKey:     mustDecodeHexEnv(hashKey),
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
		Addr:         strings.TrimPrefix(mustGetEnv(frontendURI), "http://"),
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
