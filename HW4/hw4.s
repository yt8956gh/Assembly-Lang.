/* ========================= */
/*       DATA section        */
/* ========================= */
	.data
	.align 4

/* --- variable a --- */
	.type a, %object
	.size a, 24
a:
	.word 1
	.word 2
	.word 3
	.word 4
	.word 5
	.word 6

/* --- variable b --- */
	.type b, %object
	.size b, 24
b:
	.word 7
	.word 8
	.word 9
	.word 10
	.word 11
	.word 12

/* --- variable c --- */
	.type d, %object
	.size d, 16
d:
	.word 13
	.word 14
	.word 15
	.word 16

c:
	.space 16, 0
	

	.section .text
	.global main
	.type main,%function
.matrix:
	.word a
	.word b
	.word d
	.word c
main:
	ldr r8, .matrix + 8	/*d matrix*/

	ldr r0, .matrix
	ldr r2, .matrix + 4
	bl loop

	ldr r9,[r8]
	add r9, r9, r6
	str r9,[r8], #4

	/* finish two lines mult in a&b matrix ,and add result with a element of matrix c */

	ldr r0, .matrix
	ldr r2, .matrix + 4
	add r2, r2, #4
	bl loop

	ldr r9,[r8]
	add r9, r9, r6
	str r9,[r8], #4

	/* finish two lines mult in a&b matrix ,and add result with a element of matrix c */

	ldr r0, .matrix
	add r0, r0, #12
	ldr r2, .matrix + 4
	bl loop

	ldr r9,[r8]
	add r9, r9, r6
	str r9,[r8], #4

	/* finish two lines mult in a&b matrix ,and add result with a element of matrix c */

	ldr r0, .matrix
	add r0, r0, #12
	ldr r2, .matrix + 4
	add r2, r2, #4
	bl loop
	

	ldr r9,[r8]
	add r9, r9, r6
	str r9,[r8], #4

	/* finish two lines mult in a&b matrix ,and add result with a element of matrix c */

	ldr r8, .matrix + 8	/*d matrix*/

	ldmia r8,{r1,r2,r4,r5}
	
	ldr r7, .matrix + 12	/*c matrix*/
	
	stmia r7,{r1,r2,r4,r5}

	ldr r1, .matrix + 12	/*point to the address of C’s first element*/


loop:
	
	ldr r1, [r0], #4	/*matrix A*/
	ldr r3, [r2], #8	/*matrix B*/
	mov r6, #0
	add r7, r0, #8		/*end condition*/

	mul r5, r1, r3
	add r6, r6, r5
	
	cmp r7, r0
	bne loop
	mov pc, lr
	
	.end
        nop

