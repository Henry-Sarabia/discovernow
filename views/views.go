package views

import (
	"github.com/htfy96/reformism"
	"html/template"
	"net/http"
	"path/filepath"
)

const LayoutDir string = "views/layouts"

type View struct {
	Template *template.Template
	Layout   string
}

// NewView uses the provided layout and file names to create a new View.
func NewView(layout string, files ...string) *View {
	t := template.New(layout).Funcs(reformism.FuncsText)
	files = append(files, layoutFiles()...)

	temp, err := t.ParseFiles(files...)
	if err != nil {
		panic(err)
	}

	return &View{
		Template: temp,
		Layout:   layout,
	}
}

// Render executes the view's template with the provided data.
func (v *View) Render(w http.ResponseWriter, data interface{}) error {
	return v.Template.ExecuteTemplate(w, v.Layout, data)
}

//TODO: Return an error instead of panicking.
func layoutFiles() []string {
	files, err := filepath.Glob(LayoutDir + "/*.gohtml")
	if err != nil {
		panic(err)
	}
	return files
}
