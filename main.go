package main

import (
	"fmt"
	"net/http"
)

// Функция принимает два int (a и b) и возвращает int
func Add(a int, b int) int {
	return a + b
}

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		// Передаем ровно два аргумента: 2 и 3
		fmt.Fprintf(w, "Hello, CI/CD World! 2+3=%d", Add(2, 3))
	})

	fmt.Println("Server starting on port 8080...")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		panic(err)
	}
}

