.set SWI_Open, 0x1
.set SWI_Close, 0x2
.set SWI_Write, 0x5
.set SWI_Read, 0x6
.set SWI_Flen, 0xC
.set AngelSWI, 0x123456

/* ========================= */
/*       DATA section        */
/* ========================= */
    .data
    .align 4

/* --- a string --- */
.filename_in:
    .ascii "input.txt\000"

.filename_out:
    .ascii "output.txt\000"

.readbuffer:
    .space 4

/* ========================= */
/*       TEXT section        */
/* ========================= */
    .section .text
    .global main
    .type main,%function

.open_param_in:
    .word .filename_in
    .word 0x2
    .word 0x8

.open_param_out:
    .word .filename_out
    .word 0x4
    .word 0x8

.write_param:
    .space 4   @ file descriptor
    .space 4   @ address of the string
    .space 4   @ length of the string

.read_param:
    .space 4
    .word .readbuffer   @ address of char buffer
    .space 4

.flen_param:
    .space 4

.close_param:
    .space 4

main:

    @ APCS Format

    mov ip, sp
    stmfd sp!, {fp, ip, lr, pc}
    sub fp, ip, #4

    @ open a input file

    mov r0, #SWI_Open
    adr r1, .open_param_in
    swi AngelSWI
    mov r2, r0  @ R2 is input file descriptor


    @ open a output file

    mov r0, #SWI_Open
    adr r1, .open_param_out
    swi AngelSWI
    mov r7, r0  @ R7 is output file descriptor


    @ get file length

    mov r0, #SWI_Flen
    adr r1, .flen_param
    str r2, [r1, #0]
    swi AngelSWI
    mov r6, r0  @ RO will return file length


    @ set "write_param" without param2 (Address of the string)

    adr r1, .write_param
    str r7, [r1, #0]          /* store file descriptor */

    mov r3, #1
    str r3, [r1, #8]          /* store the length of the string */

    @ read from a file

    adr r1, .read_param
    str r2, [r1, #0]          /* store file descriptor */

    ldr r5, [r1, #4]          /* r5 is the address of readbuffer */

    mov r3, #1
    str r3, [r1, #8]          /* store the length of the string */


loop:
    cmp r6, #1  @ boundary condition of loop 
    beq END

    mov r0, #SWI_Read
    swi AngelSWI @ the char will be store in format of address in r5

    ldr r8, [r5, #0]

    cmp r8, #96
    mov r9, pc  @ Because double loop will lose lr for back last loop
    bgt upper

    adr r1, .write_param
    str r5, [r1, #4] @ write param2 must be a address of char , thus r5 is stored in r1 directively 
    mov r0, #SWI_Write
    swi AngelSWI

    sub r6, r6, #1

    adr r1, .read_param     @ make r1 be read_param for next round of loop
    bne loop

upper:
    cmp r8, #123
    movge pc, r9    @ greater and equal
    sub r8, r8, #32
    strb r8, [r5]

    /*
        Because r8 stores "[alphabet],00,00,00",
        the store-instruction must be "byte mode"
        in order to avoid loading other needless bytes.
    */

    mov pc, r9

END:
    ldmea fp, {fp, sp, pc}

    /* close 2 file */
    adr r1, .close_param
    str r2, [r1, #0]

    mov r0, #SWI_Close
    swi AngelSWI

    ldmea fp, {fp, sp, pc}

    adr r1, .close_param
    str r7, [r1, #0]

    mov r0, #SWI_Close
    swi AngelSWI

    ldmea fp, {fp, sp, pc}

    nop
    .end

