package main

import (
	"log"

	"github.com/jjngx/coffeeshop"
)

func main() {
	if err := coffeeshop.Run(); err != nil {
		log.Fatal(err)
	}
}
