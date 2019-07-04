package main

import (
    "fmt"
    "time"
)

func producer(id int, ch chan string) {
    c := 0
    for {
        c++
        ch <- fmt.Sprintf("Prod%d by P%d", c, id)
    }
}
func consumer(id int, ch chan string) {
    for {
        fmt.Printf("Cli%d using %s\n", id, <-ch)
    }
}
func main() {
    ch := make(chan string)
    for i := 0; i < 5; i++ {
        go producer(i*2, ch)
        go consumer(i*2+1, ch)
    }
    time.Sleep(time.Second)
}
