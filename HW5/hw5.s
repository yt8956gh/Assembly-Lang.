.section .text
.global main
.type main,%function
	
main:
    mov r0, #48
    mov r1, #40
    b gcd

gcd:
    cmp r0,r1
    beq endp @if r1 and r0 equal ,end program
    subpl r0, r0, r1 @make larger number be difference of two-number
    submi r1, r1, r0
    b gcd

endp:
    .end
