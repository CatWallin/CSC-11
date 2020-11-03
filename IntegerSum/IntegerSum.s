.global main

.section .rodata
prompt:		.asciz "Enter three integer values: "
scan_str:	.asciz "%d %d %d"
result_msg1:	.asciz "%d + %d + %d = "
result_msg2:	.asciz "%d\n"

.section .data
x:	.word	0
y:	.word	0
z:	.word	0
sum:	.word	0

.align 4
.text
main:
	push {lr}

	// output prompt
	ldr r0, =prompt
	bl printf

	// read input
	ldr r0, =scan_str
	ldr r1, =x		// r1 holds address of x
	ldr r2, =y		// r2 holds address of y
	ldr r3, =z		// r3 holds address of z
	bl scanf

	ldr r1, =x
	ldr r2, =y
	ldr r3, =z
	ldr r5, [r1]		// r5 holds value of x
	ldr r6, [r2]		// r6 holds value of y
	ldr r7, [r3]		// r7 holds value of z

	ldr r8, =sum
	adds r3, r5, r6		// r3 = r5 + r6
	adds r4, r3, r7		// r4 = r3 + r7, r4 holds the total sum
	// str r4, [r8] 

	ldr r0, =result_msg1	// output results
	mov r1, r5		// r1 = r5, r1 holds value of x
	mov r2, r6		// r2 = r6, r2 holds value of y
	mov r3, r7		// r3 = r7, r3 holds value of z
	bl printf 		// call printf

	ldr r0, =result_msg2 	// output sum
	mov r1, r4		// r1 = r4
	bl printf		// call printf

	mov r0, #0
	pop {pc}
