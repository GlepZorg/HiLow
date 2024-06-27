@ define architecture
.cpu cortex-a72
.fpu neon-fp-armv8
.syntax unified

@ define data section
.balign 4

@ text section
.align 2
.global main
.extern generate_number
.extern get_user_guess
.extern printf

@ Function: main
@ Drives the function calls for the High-Low game
main:
    push {fp, lr}           @ Save frame pointer and link register
    add fp, sp, #4          @ Set frame pointer

    bl generate_number      @ Call generate_number to get the random number
    mov r5, r0              @ Store the generated number in r5

    mov r6, #7              @ Initialize attempt counter to 7

game_loop:
    bl get_user_guess       @ Call get_user_guess to get the user's guess
    mov r4, r0              @ Store the user's guess in r4

    cmp r4, r5              @ Compare the user's guess with the generated number
    beq correct_guess       @ If equal, go to correct_guess
    blt too_low             @ If less, go to too_low
    bgt too_high            @ If greater, go to too_high

too_low:
    ldr r0, =tooLowMsg      @ Load too low message
    bl printf               @ Print message
    sub r6, r6, #1          @ Decrement attempts
    b check_attempts        @ Check if attempts are exhausted

too_high:
    ldr r0, =tooHighMsg     @ Load too high message
    bl printf               @ Print message
    sub r6, r6, #1          @ Decrement attempts
    b check_attempts        @ Check if attempts are exhausted

correct_guess:
    ldr r0, =correctMsg     @ Load correct message
    mov r1, #7              @ Total attempts
    sub r1, r1, r6          @ Calculate number of guesses
    bl printf               @ Print message
    b game_exit             @ Exit game

check_attempts:
    cmp r6, #0              @ Compare attempts with 0
    bgt game_loop           @ If attempts > 0, continue game loop
    ldr r0, =gameOverMsg    @ Load game over message
    bl printf               @ Print game over message
    b game_exit             @ Exit game

game_exit:
    mov r0, #0              @ Return 0
    pop {fp, lr}            @ Restore frame pointer and link register
    bx lr                   @ Return

.data
tooLowMsg:      .asciz "Too low, guess again\n"
tooHighMsg:     .asciz "Too high, guess again\n"
correctMsg:     .asciz "You got it! It took %d guesses.\n"
gameOverMsg:    .asciz "YOU LOSE\n"

