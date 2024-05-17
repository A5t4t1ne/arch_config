package main

import (
	"fmt"
	"time"
)


func main() {

	start := time.Now()

	for i := 0; i < 10000; i++ {
			fmt.Print("no way")
	}

	fmt.Println(time.Since(start))
}