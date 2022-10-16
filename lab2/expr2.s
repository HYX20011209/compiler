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
	.file	"expr2.c"
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
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #36
	add	r7, sp, #0
	movs	r3, #2
	str	r3, [r7]
	movs	r3, #3
	str	r3, [r7, #4]
	ldr	r2, [r7]
	ldr	r3, [r7, #4]
	cmp	r2, r3
	ite	eq
	moveq	r3, #1
	movne	r3, #0
	uxtb	r3, r3
	str	r3, [r7, #8]
	ldr	r2, [r7]
	ldr	r3, [r7, #4]
	cmp	r2, r3
	ite	gt
	movgt	r3, #1
	movle	r3, #0
	uxtb	r3, r3
	str	r3, [r7, #12]
	ldr	r2, [r7]
	ldr	r3, [r7, #4]
	cmp	r2, r3
	ite	lt
	movlt	r3, #1
	movge	r3, #0
	uxtb	r3, r3
	str	r3, [r7, #16]
	ldr	r2, [r7]
	ldr	r3, [r7, #4]
	cmp	r2, r3
	ite	ge
	movge	r3, #1
	movlt	r3, #0
	uxtb	r3, r3
	str	r3, [r7, #20]
	ldr	r2, [r7]
	ldr	r3, [r7, #4]
	cmp	r2, r3
	ite	le
	movle	r3, #1
	movgt	r3, #0
	uxtb	r3, r3
	str	r3, [r7, #24]
	ldr	r2, [r7]
	ldr	r3, [r7, #4]
	cmp	r2, r3
	ite	ne
	movne	r3, #1
	moveq	r3, #0
	uxtb	r3, r3
	str	r3, [r7, #28]
	movs	r3, #0
	mov	r0, r3
	adds	r7, r7, #36
	mov	sp, r7
	@ sp needed
	ldr	r7, [sp], #4
	bx	lr
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
