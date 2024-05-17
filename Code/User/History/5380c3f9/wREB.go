package main

import (
	"fmt"
)

func main() {
	var squares [11]int

	for i := 1; i <= 10; i++ {
		squares[i] = i*i
	}
	fmt.Println(squares)
}