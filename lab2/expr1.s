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
	.file	"expr1.c"
	.text
	.global	__aeabi_idiv
	.global	__aeabi_idivmod
	.align	1
	.global	main
	.arch armv7-a
	.syntax unified
	.thumb
	.thumb_func
	.fpu vfpv3-d16
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	sub	sp, sp, #40
	add	r7, sp, #0


	movs	r3, #2
	str	r3, [r7, #4]
	movs	r3, #3
	str	r3, [r7, #8]


	ldr	r2, [r7, #4]
	ldr	r3, [r7, #8]
	add	r3, r3, r2
	str	r3, [r7, #12]


	ldr	r2, [r7, #8]
	ldr	r3, [r7, #4]
	subs	r3, r2, r3
	str	r3, [r7, #16]


	ldr	r3, [r7, #4]
	ldr	r2, [r7, #8]
	mul	r3, r2, r3
	str	r3, [r7, #20]


	ldr	r1, [r7, #4]
	ldr	r0, [r7, #8]
	bl	__aeabi_idiv(PLT)
	mov	r3, r0
	str	r3, [r7, #24]


	ldr	r3, [r7, #8]
	ldr	r1, [r7, #4]
	mov	r0, r3
	bl	__aeabi_idivmod(PLT)
	mov	r3, r1
	str	r3, [r7, #28]


	ldr	r3, [r7, #4]
	adds	r2, r3, #1
	str	r2, [r7, #4]
	str	r3, [r7, #32]

	ldr	r3, [r7, #8]
	subs	r2, r3, #1
	str	r2, [r7, #8]
	str	r3, [r7, #36]

	
	movs	r3, #0
	mov	r0, r3
	adds	r7, r7, #40
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",%progbits


ldr	r3, [r7, #4]
	ldr	r2, [r7, #8]
	div r3, r2, r3
	@ mov	r3, r0
	str	r3, [r7, #24]


    ldr    r3, [r7, #4]
    str r3, [r7, #32]   @;val1 -> r7+32
    add r2, r3, #1
    str r2, [r7, #4]    @;a++ -> r7+4

    ldr r3, [r7, #4]
    str r3, [r7, #36]   @;val2 -> r7+36
    sub r2, r3, #1
    str r2, [r7, #4]    @;a-- -> r7+4
    
    ldr r3, [r7, #4]
    add r2, r3, #1
    str r2, [r7, #40]   @;val3 -> r7+40
    str r2, [r7, #4]    @;++a -> r7+4
    

    ldr r3, [r7, #4]
    sub r2, r3, #1
    str r2, [r7, #44]   @;val4 -> r7+44
    str r2, [r7, #4]    @;--a -> r7+4