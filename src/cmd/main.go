package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"os"

	_ "github.com/lib/pq"
)

var db *sql.DB

func helloHandler(w http.ResponseWriter, r *http.Request) {
	// Query the table for the hello world record
	var greeting string
	err := db.QueryRow("SELECT greeting FROM hello_table").Scan(&greeting)
	if err != nil {
		log.Println("Failed to execute query: ", err)
		return
	}

	w.Write([]byte(greeting))
}

func healthHandler(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	w.Write([]byte("Healthy"))
}

func readyHandler(w http.ResponseWriter, r *http.Request) {
	// TODO: Add any logic needed to check if the service is ready to handle requests.
	// For example, if your service depends on a database or another service,
	// we will check if a connection can be established.
	status := true
	if status {
		w.WriteHeader(http.StatusOK)
	} else {
		w.WriteHeader(http.StatusInternalServerError)
	}

	w.Write([]byte("Ready"))
}

func main() {
	connStr := fmt.Sprintf("host=%s user=%s password=%s dbname=%s sslmode=disable",
		os.Getenv("DB_HOST"), os.Getenv("DB_USER"), os.Getenv("DB_PASSWORD"), os.Getenv("DB_NAME"))
	var err error
	db, err = sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	// Create the table if it doesn't exist
	_, err = db.Exec(`CREATE TABLE IF NOT EXISTS hello_table (id SERIAL PRIMARY KEY, greeting TEXT)`)
	if err != nil {
		log.Fatal(err)
	}

	// Insert a hello world record
	_, err = db.Exec(`INSERT INTO hello_table (greeting) VALUES ('Hello, World!') ON CONFLICT (greeting) DO NOTHING`)
	if err != nil {
		log.Fatal(err)
	}

	http.HandleFunc("/", helloHandler)
	http.HandleFunc("/healthz", healthHandler)
	http.HandleFunc("/readyz", readyHandler)

	log.Println("Starting server on :9000")
	err = http.ListenAndServe(":9000", nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}
