@ define architecture
.cpu cortex-a72
.fpu neon-fp-armv8
.syntax unified

@ define data section
.balign 4

@ text section
.align 2
.global generate_number
.extern srand
.extern rand
.extern time

@ Function: generate_number
@ Generates a random number between 50 and 100
generate_number:
    push {fp, lr}           @ Save frame pointer and link register
    add fp, sp, #4          @ Set frame pointer

    sub sp, sp, #8          @ Allocate space for time argument
    mov r0, sp              @ Move stack pointer to r0 (argument for time)
    bl time                 @ Call time function
    ldr r0, [sp]            @ Load the time value into r0
    bl srand                @ Call srand function with time as argument
    add sp, sp, #8          @ Deallocate space

    bl rand                 @ Generate a random number

    mov r1, #51             @ r1 = 51 (range size)
    udiv r2, r0, r1         @ r2 = r0 / 51 (quotient)
    mls r0, r2, r1, r0      @ r0 = r0 - (r2 * r1) (modulus operation)
    add r0, r0, #50         @ r0 = r0 + 50 (adjust to range 50-100)

    pop {fp, lr}            @ Restore frame pointer and link register
    bx lr                   @ Return

