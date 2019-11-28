package main

import (
    "fmt"
    "net"
)

func main() {
    con, _ := net.Dial("tcp", "localhost:8000")
    defer con.Close()
    fmt.Fprintln(con, "KHDHÑSLKJGSÑLFKHGÑSKFJHGKJDFHGJKLDHGLKJDFgu!")
}
