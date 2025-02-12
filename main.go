package main

import (
	"encoding/json"
	"fmt"
	"net/http"
)

// Response structure
type Response struct {
	Message string `json:"message"`
}

// Serve the HTML page
func homeHandler(w http.ResponseWriter, r *http.Request) {
	http.ServeFile(w, r, "index.html")
}

// API handler for greeting
func greetHandler(w http.ResponseWriter, r *http.Request) {
	name := r.URL.Query().Get("name")
	if name == "" {
		name = "Guest"
	}
	response := Response{Message: fmt.Sprintf("Hello, %s!", name)}
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}

func main() {
	http.HandleFunc("/", homeHandler)
	http.HandleFunc("/greet", greetHandler)

	fmt.Println("Server running on http://localhost:8080")
	http.ListenAndServe(":8080", nil)
}
