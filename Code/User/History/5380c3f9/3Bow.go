package main

import (
	"fmt"
	"runtime"
	"time"
)

func main() {
	fmt.Println(time.Now().Weekday() - time.Saturday)
	fmt.Print("Go runs on ")
	switch os := runtime.GOOS; os {
	case "darwin":
		fmt.Println("OS X.")
	case "linux":
		fmt.Println("Linux.")
	default:
		// freebsd, openbsd,
		// plan9, windows...
		fmt.Printf("%s.\n", os)
	}
}
