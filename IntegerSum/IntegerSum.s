.global main

.section .rodata
prompt:		.asciz "Enter three integer values: "
scan_str:	.asciz "%d %d %d"
result_msg:	.asciz "%d + %d + %d = %d\n"

.section .data
x:	.word	0
y:	.word	0
z:	.word	0

.align 4
.text
main:
	push {lr}

	ldr r0, =prompt
	bl printf

	ldr r0, =scan_str
	ldr r1, =x
	ldr r2, =y
	ldr r3, =z
	bl scanf

	ldr r0, =x
	ldr r1, =y
	ldr r2, =z
	ldr r5, [r0]
	ldr r6, [r1]
	ldr r7, [r2]

	adds r3, r5, r6		// r3 = r5 + r6
	adds r4, r3, r7		// r4 = r3 + r7

	ldr r0, =result_msg
	mov r1, r5		// r1 = r5
	mov r2, r6		// r2 = r6
	mov r3, r7		// r3 = r7

	bl printf		// call printf

	mov r0, #0
	pop {pc}
