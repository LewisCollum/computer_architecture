#define seriesSize x0
#define seriesPointer x1

#define fibonacciNumber x11
#define count x12
#define backTwo x13
    
    .global fibonacci
fibonacci:
    mov fibonacciNumber, 0
    stur fibonacciNumber, [seriesPointer, #0]    
    add seriesPointer, seriesPointer, #8
    
    mov fibonacciNumber, 1
    stur fibonacciNumber, [seriesPointer, #0]
    add seriesPointer, seriesPointer, #8

    mov count, 2

loop:
    ldur backTwo, [seriesPointer, #-16] 
    add fibonacciNumber, fibonacciNumber, backTwo
    stur fibonacciNumber, [seriesPointer, #0]
    add seriesPointer, seriesPointer, #8
    
    cmp count, seriesSize
    add count, count, #1
    blt loop

    br lr
