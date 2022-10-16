	.arch armv7-a
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"IO.c"


	.text
	.section	.rodata
	.align	2
input:
	.ascii	"%d\000"

	.align 	2
output1:
	.ascii "%d\012\000"

	.align	2
output2:
	.ascii	"hello!\000"

	.text
	.align	1
	.global	main
	.arch armv7-a
	.syntax unified
	.thumb
	.thumb_func
	.fpu vfpv3-d16
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	sub	sp, sp, #16
	add	r7, sp, #0

	movs r3, #0
	str r3, [r7,#4]

	ldr r0, .label2
	mov r1, r7
	add r1, r1, #4
	bl	__isoc99_scanf

	ldr r0, .label2 + 4
	ldr r1, [r7,#4]
	bl printf

	ldr r0, .label2 + 8
	bl printf
	
.label1:
	mov	r0, r3
	adds	r7, r7, #16
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}

.label2:
	.word input
	.word output1
	.word output2

	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
