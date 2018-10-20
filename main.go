package main

import "os"

func main() {
	os.Exit(_main(os.Args[1:]))
}

func _main(args []string) int {
	_ = args // TODO: Implementation
	return 0
}
