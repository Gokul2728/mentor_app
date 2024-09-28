package functions

import (
	
	"net/http"
)

var Auth bool

func CheckAuth(w http.ResponseWriter, r *http.Request) {
	// Perform header check/authentication here
	authHeader := r.Header.Get("Authorization")
	// API TOKEN are testing not used for this.... Note it
	if authHeader != "AIzaSyCjvJFCQLw7t-bZGX8c3l8i3ptXt_6xu7A" {
		http.Error(w, "Unauthorized", http.StatusUnauthorized)
		Auth = false
		return
	}

	Auth = true
	// Call the next handler
	// http.DefaultServeMux.ServeHTTP(w, r)
}
