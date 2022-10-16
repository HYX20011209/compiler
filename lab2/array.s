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
	.file	"array.c"

	.text
	.section .rodata
	.align 2
str_output:
	.ascii "%d\000"

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
	push	{r7, lr}
	sub	sp, sp, #16
	add	r7, sp, #0

	
	movs r3, #10
	str r3, [r7]

	movs r3, #20
	str r3, [r7, #4]

	movs r3, #10
	str r3, [r7, #8]

	ldr r3, [r7, #4]
	str r3, [r7, #12]

	ldr r0, .label2
	ldr r1, [r7, #12]
	bl printf

.label1:
	mov	r0, r3
	adds	r7, r7, #16
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
.label2:
	.word str_output

	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
