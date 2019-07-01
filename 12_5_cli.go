package main

import (
    "net"
    "fmt"
)

func main() {
    con, _ := net.Dial("tcp", "localhost:8000")
    defer con.Close()
    fmt.Fprintln(con, "Hola, soy un cliente!")
}
