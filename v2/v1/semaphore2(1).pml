#define wait(s) atomic { s > 0 -> s-- }
#define signal(s) s++

#define NUM_PROCS 2

byte s = 1
byte critical = 0

active[NUM_PROCS] proctype P() {
    do
    ::  wait(s)
        critical++
        assert critical <= 1
        critical--
        signal(s)
    od
}
