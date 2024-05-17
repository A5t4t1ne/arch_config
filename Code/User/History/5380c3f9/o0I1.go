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
			if isIntIn((squares[i] - squares[j]), squares){
				fmt.Println(squares[i], squares[j], squares[i] - squares[j])
			}
		}
	}
	fmt.Println(squares)
}

func isIntIn (s int, arr []int) (bool){
	for _, val := range arr {
		if val == s{
			return true
		}
	}
	return false
}