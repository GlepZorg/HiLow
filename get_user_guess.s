@ define architecture
.cpu cortex-a72
.fpu neon-fp-armv8
.syntax unified

@ define data section
.balign 4

@ text section
.align 2
.global get_user_guess
.extern printf
.extern scanf

@ Function: get_user_guess
@ Prompts user for a guess and reads the input
get_user_guess:
    push {fp, lr}           @ Save frame pointer and link register
    add fp, sp, #4          @ Set frame pointer

    ldr r0, =promptMsg      @ Load prompt message address
    bl printf               @ Call printf to print the prompt

    ldr r0, =inputFormat    @ Load input format
    sub sp, sp, #4          @ Allocate space on stack for input
    mov r1, sp              @ Move stack pointer to r1 (temporary storage)
    bl scanf                @ Call scanf to get user input
    ldr r0, [sp]            @ Load the input value from stack

    add sp, sp, #4          @ Deallocate space on stack
    pop {fp, lr}            @ Restore frame pointer and link register
    bx lr                   @ Return with user input in r0

.data
promptMsg:      .asciz "Please enter a guess: "
inputFormat:    .asciz "%d"

