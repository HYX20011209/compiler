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
	.file	"expr3.c"
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
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #28
	add	r7, sp, #0


	movs	r3, #1
	str	r3, [r7, #4]
	movs	r3, #0
	str	r3, [r7, #8]

    ;&&
	ldr	r3, [r7, #4]    ;r3=x
	cmp	r3, #0          ;if(r3==0).label1
	beq	.label1
	ldr	r3, [r7, #8]    ;r3=y
	cmp	r3, #0          ;if(r3==0).label1
	beq	.label1
	movs	r3, #1
	b	.label2
.label1:
	movs	r3, #0
.label2:
	str	r3, [r7, #12]

    ;||
	ldr	r3, [r7, #4]    ;r3=x
	cmp	r3, #0          ;if(r3!=0).label3
	bne	.label3
	ldr	r3, [r7, #8]    ;r3=y
	cmp	r3, #0          ;if(r3==0).label4
	beq	.label4
.label3:
	movs	r3, #1
	b	.label5
.label4:
	movs	r3, #0
.label5:
	str	r3, [r7, #16]

    ;!
	ldr	r3, [r7, #4]    ;r3=x
	cmp	r3, #0          
	ite	ne
	movne	r3, #0      ;if(x!=0)r3=1
	moveq	r3, #1      ;if(x==0)r3=0
	uxtb	r3, r3      ;符号扩展
	str	r3, [r7, #20]


	
	movs	r3, #0
	mov	r0, r3
	adds	r7, r7, #28
	mov	sp, r7
	@ sp needed
	ldr	r7, [sp], #4
	bx	lr
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
