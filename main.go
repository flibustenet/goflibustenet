package main

import (
	"fmt"
	"net/http"
	"os"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		u := r.URL.Path[1:]
		fmt.Fprintf(w, `<meta name="go-import" content="%s/%s git https://github.com/flibustenet/%s">`, r.Host, u, u)
	})
	fmt.Println("Listen on :" + os.Getenv("PORT"))
	http.ListenAndServe(":"+os.Getenv("PORT"), nil)
}
