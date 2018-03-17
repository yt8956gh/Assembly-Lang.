	.file	"sample.c"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	@ lr needed for prologue
	mov	r3, #1
.L6:
	add	r3, r3, #1
	cmp	r3, #100
	movgt	r0, #0
	movgt	pc, lr
	b	.L6
	.size	main, .-main
	.ident	"GCC: (GNU) 3.3.6"
