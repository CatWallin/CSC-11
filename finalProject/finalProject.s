
//CSC-11 Final Project
//Street Crossing
//Catherine Wallin

.equ INPUT, 0
.equ OUTPUT, 1
.equ LOW, 0
.equ HIGH, 1
					//Lights for Car Stop Light
.equ GRN_CAR, 23			//wiringPi 
.equ YEL_CAR, 24			//wiringPi 
.equ RED_CAR, 25			//wiringPi
					//Lights for Crosswalk 
.equ GRN_WALK, 26			//wiringPi
.equ RED_WALK, 27			//wiringPi

.equ WLK_PIN, 29			//wiringPi 29 - Push to Cross 
.equ EXIT_LOOP, 6			//wiringPi 11 - Push to exit 

.text
.global main

main:

	push {lr}
	bl wiringPiSetup		//initialize the wiringPi Library

	mov r0, #WLK_PIN
	mov r1, #INPUT
	bl pinMode			//setting WLK_PIN as input (push to cross)

	mov r0, #EXIT_LOOP		//setting the EXIT_LOOP as input (push to exit)
	mov r1, #INPUT
	bl pinMode

	mov r0, #GRN_CAR
	bl setPinOutput

	mov r0, #YEL_CAR
	bl setPinOutput

	mov r0, #RED_CAR 
	bl setPinOutput

	mov r0, #GRN_WALK
	bl setPinOutput

	mov r0, #RED_WALK
	bl setPinOutput

do_while:

	mov r0, #RED_CAR
	bl pinOff

	mov r0, #GRN_CAR
	bl pinOn

	mov r0, #RED_WALK
	bl pinOn

	mov r0, #WLK_PIN
	bl digitalRead
	cmp r0, #HIGH		// is r0 == HIGH? is the button pushed?
	bne continue_while 	// if no, go to continue_while

	mov r0, #GRN_CAR
	bl pinOff

	mov r0, #YEL_CAR
	bl pinOn

	ldr r0, =#5000
	bl delay

	mov r0, #YEL_CAR
	bl pinOff

	mov r0, #RED_CAR
	bl pinOn

	mov r0, #RED_WALK
	bl pinOff

	mov R0, #GRN_WALK
	bl pinOn

	ldr r0, =#10000
	bl delay

	mov r0, #GRN_WALK
	bl pinOff

	mov r0, #RED_WALK		//start flashing red walk light to indicate to stop crossing
	bl pinOn

	ldr r0, =#1000
	bl delay

	mov r0, #RED_WALK
	bl pinOff

	ldr r0, =#500
	bl delay

	mov r0, #RED_WALK
	bl pinOn

	ldr r0, =#500
	bl delay

	mov r0, #RED_WALK
	bl pinOff

	ldr r0, =#500
	bl delay

	mov r0, #RED_WALK
	bl pinOn

	ldr r0, =#500
	bl delay

	mov r0, #RED_WALK
	bl pinOff

	ldr r0, =#500
	bl delay

	mov r0, #RED_WALK
	bl pinOn

	ldr r0, =#500
	bl delay

	mov r0, #RED_WALK
	bl pinOff

	ldr r0, =#500
	bl delay

	b do_while

continue_while:

	mov r0, #EXIT_LOOP
	bl digitalRead
	cmp r0, #HIGH
	bne do_while

	b end_do_while

end_do_while:
	mov r0, #0
	pop {pc}

pinOn:
	push {lr}
	mov R1, #HIGH
	bl digitalWrite
	pop {pc}

pinOff:
	push {lr}
	mov r1, #LOW
	bl digitalWrite
	pop {pc}

setPinOutput:
	push {lr}
	mov r1, #OUTPUT
	bl pinMode
	pop {pc}
