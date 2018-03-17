	.section	.text
	.global	main
	.type	main, %function
main:
    MOV r7, #0 @ initialize r7
    MOV r0, #1 @ make r0~r4 small constant 
    MOV r1, #2
    MOV r2, #3
    MOV r3, #4
    MOV r4, #5
    ADD r7, r0, r1
    ADD r7, r7, r2
    ADD r7, r7, r3
    ADD r7, r7, r4

    nop
    .end



