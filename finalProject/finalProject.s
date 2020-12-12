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

.text
.global main

main:
	push {lr}
	bl wiringPiSetup		//initialize the wiringPi Library

	mov r0, #WLK_PIN
	bl setPinInput			//setting WLK_PIN as input (push to cross)

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





