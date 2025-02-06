package main

import (
	"flag"
	"fmt"
)

var (
	version     = "dev"
	versionFlag = flag.Bool("v", false, "print version")
)

func main() {
	flag.Parse()

	if *versionFlag {
		fmt.Printf("hello version %s\n", version)

		return
	}

	fmt.Println("Hello, World!")
}
