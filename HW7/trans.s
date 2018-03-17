.section .text
.global trans
.type trans,%function

trans:

    @ APCS Format

    mov ip, sp
    stmfd sp!, {fp, ip, lr, pc}
    sub fp, ip, #4

    cmp r0, #96
    bgt upper
    b end

upper:

    cmp r0, #123
    bge end
    sub r0, r0, #32

end:

    ldmea fp, {fp, sp, pc}

    nop
    .end
