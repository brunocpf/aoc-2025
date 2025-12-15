package main

import (
	"fmt"
	"os"

	"day11/internal/reactor"
)

func main() {
	path := reactor.ResolveInputPath(os.Args[1:])

	if path == "" {
		fmt.Println("Error: Please provide an input file using --input or -i.")
		os.Exit(1)
	}

	contents, err := os.ReadFile(path)

	if err != nil {
		fmt.Printf("Error reading file: %v\n", err)
		os.Exit(1)
	}

	graph := reactor.Parse(string(contents))
	fmt.Printf("Result: %d\n", reactor.CountPathsThrough(graph, "svr", "out", "dac", "fft"))
}
