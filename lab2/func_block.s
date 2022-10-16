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
	.file	"assignment2.c"
	.text
	.align	1
	.global	fuc1
	.arch armv7-a
	.syntax unified
	.thumb
	.thumb_func
	.fpu vfpv3-d16
	.type	fuc1, %function
fuc1:
	push	{r7}
	sub	sp, sp, #12
	add	r7, sp, #0
	str	r0, [r7, #4]
.label1:
	ldr	r3, [r7, #4]
	cmp	r3, #1
	beq	.label2
	b	.label1
.label2:
	nop
	movs	r3, #5
	mov	r0, r3
	adds	r7, r7, #12
	mov	sp, r7
	ldr	r7, [sp], #4
	bx	lr
	.size	fuc1, .-fuc1
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.fpu vfpv3-d16
	.type	main, %function
main:
	push	{r7, lr}
	sub	sp, sp, #16
	add	r7, sp, #0
	movw	r3, #13107
	movt	r3, 16467
	str	r3, [r7, #8]	@ float
	movs	r3, #1
	str	r3, [r7, #4]
	b	.label4
.label3:
	ldr	r3, [r7, #4]
	adds	r3, r3, #1
	str	r3, [r7, #4]
.label4:
	ldr	r3, [r7, #4]
	cmp	r3, #1
	beq	.label3
	ldr	r3, [r7, #4]
	cmp	r3, #2
	bne	.label5
	movs	r3, #3
	str	r3, [r7, #4]
	b	.label6
.label5:
	movs	r3, #4
	str	r3, [r7, #4]
.label6:
	movs	r0, #1
	bl	fuc1(PLT)
	str	r0, [r7, #12]
	movs	r3, #0
	mov	r0, r3
	adds	r7, r7, #16
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
