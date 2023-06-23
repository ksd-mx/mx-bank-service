package main

import (
	"log"
	"net/http"
	"os"
)

func helloHandler(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Hello, World!"))

	// TODO: to be removed
	log.Println("DB_HOST: ", os.Getenv("DB_HOST"))
	log.Println("DB_USER: ", os.Getenv("DB_USER"))
	log.Println("DB_PASSWORD: ", os.Getenv("DB_PASSWORD"))
}

func main() {
	http.HandleFunc("/", helloHandler)

	log.Println("Starting server on :9000")
	err := http.ListenAndServe(":9000", nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}
