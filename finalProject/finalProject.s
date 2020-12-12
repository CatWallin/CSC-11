
//CSC-11 Final Project
//Street Crossing
//Catherine Wallin
//Fall 2020

.equ INPUT, 0
.equ OUTPUT, 1
.equ LOW, 0
.equ HIGH, 1
					//Lights for Car Stop Light
.equ GRN_CAR, 23			//wiringPi 23
.equ YEL_CAR, 24			//wiringPi 24
.equ RED_CAR, 25			//wiringPi 25
					//Lights for Crosswalk
.equ GRN_WALK, 26			//wiringPi 26
.equ RED_WALK, 27			//wiringPi 27

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

	mov r0, #GRN_CAR		//setting the lights as output
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

	mov r0, #RED_CAR		//turn the RED_CAR pin off
	bl pinOff

	mov r0, #GRN_CAR		//turn on the GRN_CAR pin
	bl pinOn

	mov r0, #RED_WALK		//turn on the RED_WALK pin
	bl pinOn

	mov r0, #WLK_PIN
	bl digitalRead
	cmp r0, #HIGH			// is r0 == HIGH? is the button pushed?
	bne continue_while 		// if no, go to continue_while

	mov r0, #GRN_CAR		//turn off GRN_CAR pin
	bl pinOff

	mov r0, #YEL_CAR		//turn on YEL_CAR pin to indicate drivers to prepare to stop
	bl pinOn

	ldr r0, =#5000
	bl delay

	mov r0, #YEL_CAR		//turn off YEL_CAR pin
	bl pinOff

	mov r0, #RED_CAR		//turn on RED_CAR pin to indicate drivers to stop
	bl pinOn

	mov r0, #RED_WALK		//turn off RED_WALK pin
	bl pinOff

	mov R0, #GRN_WALK		//turn on GRN_WALK pin to indicate to pedestrians that they may cross
	bl pinOn

	ldr r0, =#10000
	bl delay

	mov r0, #GRN_WALK		//turn off GRN_WALK pin
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

	b do_while			//restart the loop

continue_while:

	mov r0, #EXIT_LOOP		//compare the input to see if the exit button has been pushed
	bl digitalRead
	cmp r0, #HIGH
	bne do_while			//if it has not been pushed, continue the loop

	b end_do_while			//if it has been pushed, exit the loop

end_do_while:

	mov r0, #GRN_CAR
	bl pinOff

	mov r0, #RED_WALK
	bl pinOff


	mov r0, #0
	pop {pc}

pinOn:
	push {lr}			//function to turn pin on
	mov R1, #HIGH
	bl digitalWrite
	pop {pc}

pinOff:
	push {lr}			//function to turn pin off
	mov r1, #LOW
	bl digitalWrite
	pop {pc}

setPinOutput:				//function to set a pin as output
	push {lr}
	mov r1, #OUTPUT
	bl pinMode
	pop {pc}
