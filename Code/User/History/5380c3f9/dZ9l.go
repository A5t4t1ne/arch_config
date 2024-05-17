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
	for i := 2; i < length; i++ {
		for j := 2; j < i; j++ {
			if (squares[i] % squares[j]) == 0 {
				fmt.Println(squares[i], squares[j])
			}
		}
	}
	// fmt.Println(squares)
}