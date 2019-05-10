#define wait(s) atomic { s > 0 -> s-- }
#define signal(s) s++

#define N 5

byte fork[N] = { 1, 1, 1, 1, 1 }
byte room = N-1 

active[N] proctype philosoper() {
    pid i = _pid
    do
    ::  printf("Philosopher%d thiking\n", i)
        wait(room)
        wait(fork[i])
        wait(fork[(i+1)%N])
        printf("Philosopher%d eating\n", i)
        signal(fork[i])
        signal(fork[(i+1)%N])
        signal(room)
    od
}
