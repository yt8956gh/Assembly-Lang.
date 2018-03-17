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
	mov	r3, #99
.L6:
	subs	r3, r3, #1
	movmi	r0, #0
	bpl	.L6
	mov	pc, lr
	.size	main, .-main
	.ident	"GCC: (GNU) 3.3.6"
