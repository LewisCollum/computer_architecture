#define n x0
#define return x0
#define recursiveResult x11

    .global mysum
mysum:
	// if n == 1, branch to "baseCase"
	cmp n, 1
	b.eq baseCase

	// push n and lr to stack
	sub sp, sp, #(16*2)
	str n, [sp, #0]
	str x30, [sp, #16]

	// recursive function call
	sub n, n, 1
	bl mysum
	mov recursiveResult, return

	// pop n and lr from stack
	ldr x30, [sp, #16]
	ldr n, [sp, #0]
	add sp, sp, #(16*2)

	// return n + mysum(n-1)
	add return, n, recursiveResult
	ret

baseCase:
	//return 1
	mov return, 1
	ret
