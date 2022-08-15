package main

import (
	"fmt"
	"net/http"
	"os"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		u := r.URL.Path[1:]
		fmt.Fprintf(w, `
<meta name="go-import" content="go.flibuste.net/%s git https://github.com/flibustenet/%s">
Hello, you've requested: %s\n
`, u, u, u)
	})
	fmt.Println("Listen on :" + os.Getenv("PORT"))
	http.ListenAndServe(":"+os.Getenv("PORT"), nil)
}
