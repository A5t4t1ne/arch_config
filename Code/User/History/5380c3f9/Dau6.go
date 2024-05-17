package main

import (
	"fmt"
)

func main() {
	const length = 11
	var squares [length]int

	for i := 0; i < length; i++ {
		squares[i] = i*i
	}
	fmt.Println(squares)
}