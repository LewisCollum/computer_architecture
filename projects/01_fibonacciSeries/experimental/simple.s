    .text
    .globl _start
_start: 
    ldr r2, str1
    b .

str1:
    .word 0xDEADBEEF
