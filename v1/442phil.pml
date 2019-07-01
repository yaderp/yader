#define wait(s) atomic { s > 0 -> s-- }
#define signal(s) s++

#define N 5

#define right(i) i
#define left(i) (i+1) % 5

byte fork[N] = {1}

active[N-1] proctype Philosopher() {
    byte i = _pid
    do
    ::
        printf("Philosopher%d thinking\n", i)
        wait(fork[right(i)])
        wait(fork[left(i)])
        printf("Philosopher%d eating\n", i)
        signal(fork[right(i)])
        signal(fork[left(i)])
    od
}
active proctype PhilosopherLeftie() {
    byte i = _pid
    do
    ::
        printf("Philosopher%d thinking\n", i)
        wait(fork[left(i)])
        wait(fork[right(i)])
        printf("Philosopher%d eating\n", i)
        signal(fork[left(i)])
        signal(fork[right(i)])
    od
}


