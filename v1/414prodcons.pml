#define wait(s) atomic { s > 0 -> s-- }
#define signal(s) s++

#define MAX 10

byte notEmpty = 0
byte notFull = MAX
byte mutex = 1

int buffer[MAX]
int pos = 0

active proctype Consumer() {
    int event
    do
    ::
        wait(notEmpty)
        wait(mutex)
        pos--
        event = buffer[pos]
        signal(mutex)
        signal(notFull)
        printf("EH%d handling %d\n", _pid, event)
    od
}
active[20] proctype Producer() {
    int event
    int c = 0
    do
    ::
        event = _pid * 1000 + c
        c++
        wait(notFull)
        wait(mutex)
        buffer[pos] = event
        pos++
        signal(mutex)
        signal(notEmpty)
    od
}
