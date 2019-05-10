package main

import (
    "fmt"
)

var wantp = false
var wantq = false

func p() {
    for {
        fmt.Println("P non critical section")
        wantp = true
        for wantq {
        }
        fmt.Println("P CRITICAL SECTION")
        wantp = false
    }
}

func q() {
    for {
        fmt.Println("P non critical section")
        wantq = true
        for wantp {
        }
        fmt.Println("P CRITICAL SECTION")
        wantq = false
    }
}

func main() {
    go p()
    q()
}
