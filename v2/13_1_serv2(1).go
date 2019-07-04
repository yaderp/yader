package main

import(
    "fmt"
    "net"
    "bufio"
)

func main() {
    ln, _ := net.Listen("tcp", "localhost:8005")
    defer ln.Close()
    con, _ := ln.Accept()
    defer con.Close()
    r := bufio.NewReader(con)
    msg, _ := r.ReadString('\n')
    fmt.Print("Recibido: ", msg)
}
