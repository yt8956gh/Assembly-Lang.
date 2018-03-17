.section .text
.global main
.type main,%function
	
main:
	MOV r0, #-100 @the number input
	MOV r1, #0
	CMP r1, r0 @using #0 to determine Negative or Positive
	MOVMI r2, r0 @MI represent N in CPSR is Negative
	SUBPL r2, r1, r0 @PL represent N in CPSR is Positive or Zero
nop
.end
	










