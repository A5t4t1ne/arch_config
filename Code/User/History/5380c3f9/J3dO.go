package main

import (
	"fmt"
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
				fmt.Println(squares[i], squares[j], squares[i] - squares[j])
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