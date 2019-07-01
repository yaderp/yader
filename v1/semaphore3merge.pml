#define wait(s) atomic { s > 0 -> s-- }
#define signal(s) s++

#define N 10

byte s1 = 0
byte s2 = 0

byte A[N] = { 9, 4, 1, 7, 3, 2, 8, 6, 10, 5 }

active proctype sort1() {
    byte m = N / 2
    byte i, j, temp
    for (i : 0..m-2) {
        for (j : 0..m-i-2) {
            if
            :: A[j] > A[j+1] ->
                temp = A[j]
                A[j] = A[j+1]
                A[j+1] = temp
            :: else -> skip
            fi
        }
    }
    signal(s1)
}
active proctype sort2() {
    byte m = N / 2
    byte i, j, temp
    for (i : 0..m-2) {
        for (j : 0..m-i-2) {
            if
            :: A[j+m] > A[j+m+1] ->
                temp = A[j+m]
                A[j+m] = A[j+m+1]
                A[j+m+1] = temp
            :: else -> skip
            fi
        }
    }
    signal(s2)
}
active proctype merge() {
    wait(s1)
    wait(s2)
    byte m = N / 2
    byte i0 = 0
    byte i1 = m
    byte temp[N]
    byte i = 0
    do
    :: i < N ->
        if
        :: i1 >= N ->
            temp[i] = A[i0]
            i0++
        :: i0 >= m ->
            temp[i] = A[i1]
            i1++
        :: A[i0] < A[i1] ->
            temp[i] = A[i0]
            i0++
        :: else ->
            temp[i] = A[i1]
            i1++
        fi
        i++
    :: else -> break
    od
    for (i : 0..9) {
        printf(">> %d\n", temp[i]);
    }
    printf("\n")
}
