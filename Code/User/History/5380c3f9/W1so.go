package main

import (
	"fmt"
	"math"
)

func main() {
	const length = 13
	var squares []int

	for i := 0; i < length; i++ {
		squares = append(squares, i*i)
	}
	for i := 2; i < length; i++ {
		for j := 2; j < i; j++ {
			if isIntIn((squares[i] - squares[j]), squares){
				fmt.Println(math.Sqrt(float64(squares[j])), math.Sqrt(float64(squares[i]) - float64(squares[j])), 
				fmt.Sprintf("-> %d (%d)", i, squares[i]))
				break
			}
		}
	}
	fmt.Println(squares)
}

func isIntIn(element int, array []int) bool {
    for _, value := range array {
        if value == element {
            return true
        }
    }
    return false
}