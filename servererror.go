package main

import (
	"log"
)

type serverError struct {
	Error   error
	Message string
	Code    int
}

func (e serverError) Log() {
	log.Printf("\n\terror: %v \n\tmessage: %s \n\tcode: %d\n\n", e.Error, e.Message, e.Code)
}