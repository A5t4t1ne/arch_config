package main

import (
	"fmt"
	"time"
)


func main() {

	const count = 10_000
	
	var arr [count]int
	
	start := time.Now()
	for i := 0; i < count; i++ {
		arr[i] = i
	}
	fmt.Println("Setting array:", time.Since(start))

	
	var sl = make([]int, 0)
	start = time.Now()
	for i := 0; i < count; i++ {
		
	}
	fmt.Println("Appending to slice:", time.Since(start))

}