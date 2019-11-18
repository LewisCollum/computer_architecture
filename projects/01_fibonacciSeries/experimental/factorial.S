    .global factorial
factorial:
    cmp x0, 0
    bgt L1
    mov x0, 1
    br lr

L1:
    sub sp, sp, #16
    stur lr, [sp, #8]
    stur x0, [sp, #0]

    sub x0, x0, #1
    bl fibonacci

    ldur lr, [sp, #8]
    ldur x1, [sp, #0]
    add sp, sp, #16
    
    mul x0, x0, x1 
    br lr
