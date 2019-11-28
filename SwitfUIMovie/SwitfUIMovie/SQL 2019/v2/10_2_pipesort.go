package main

import (
    "fmt"
    "math/rand"
)

func sort(in, out chan int, i int, s []int) {
    temp := make([]int, 0, 20)
    for v := range in {
        temp = append(temp, v)
    }
    pos := 0
    for i := range temp {
        if temp[i] < temp[pos] {
            pos = i
        }
    }
    for i, v := range temp {
        if i != pos {
            out<- v
        }
    }
    close(out)
    s[i] = temp[pos]
}

func main() {
    n   := 20
    res := make([]int, n)
    ch  := make([]chan int, n+1)
    rand.Seed(1981)
    ch[0] = make(chan int)
    go func(ch chan int) {
        for i := 0; i < n; i++ {
            ch<- rand.Intn(100)
        }
        close(ch)
    }(ch[0])
    for i := 0; i < n; i++ {
        ch[i+1] = make(chan int)
        go sort(ch[i], ch[i+1], i, res)
    }
    for _ = range ch[n] {}
    fmt.Println(res)
}
