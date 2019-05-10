#define wait(s) atomic { s > 0 -> s-- }
#define signal(s) s++

#define N 5

#define right(i) i
#define left(i) (i+1) % 5

byte fork[N] = {1}
byte room = 4

active[N] proctype Philosopher() {
    byte i = _pid
    do
    ::
        printf("Philosopher%d thinking\n", i)
        wait(room)
        wait(fork[right(i)])
        wait(fork[left(i)])
        printf("Philosopher%d eating\n", i)
        signal(fork[right(i)])
        signal(fork[left(i)])
        signal(room)
    od
}


