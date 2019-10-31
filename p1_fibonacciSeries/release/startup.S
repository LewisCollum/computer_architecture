    .text
    .globl _start
_start:
	;; configure stack
	adrp x0, stacktop
	mov sp, x0

	b main
