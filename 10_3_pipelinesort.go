package main

import (
	"fmt"
	"math/rand"
)

func pipesort(in, out chan int, i int, s []int) {
	first := true
	var min int
	for val := range in {
		if first {
			first = false
			min = val
		} else if val < min {
			out <- min
			min = val
		} else {
			out <- val
		}
	}
	s[i] = min
	close(out)
}
func main() {
	n := 20
	ch := make([]chan int, n+1)
	ch[0] = make(chan int)
	go func(ch chan int) {
		rand.Seed(1981)
		for i := 0; i < n; i++ {
			ch <- rand.Intn(100)
		}
		close(ch)
	}(ch[0])
	s := make([]int, n)
	for i := 0; i < n; i++ {
		ch[i+1] = make(chan int)
		go pipesort(ch[i], ch[i+1], i, s)
	}
	for _ = range ch[n] {
	}
	fmt.Println(s)
}
