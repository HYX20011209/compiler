	.text
	.file	"test1.cpp"
	.section	.text.startup,"ax",@progbits
	.p2align	4, 0x90         # -- Begin function __cxx_global_var_init
	.type	__cxx_global_var_init,@function
__cxx_global_var_init:                  # @__cxx_global_var_init
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	$_ZStL8__ioinit, %edi
	callq	_ZNSt8ios_base4InitC1Ev
	movl	$_ZNSt8ios_base4InitD1Ev, %edi
	movl	$_ZStL8__ioinit, %esi
	movl	$__dso_handle, %edx
	callq	__cxa_atexit
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	__cxx_global_var_init, .Lfunc_end0-__cxx_global_var_init
	.cfi_endproc
                                        # -- End function
	.text
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$80, %rsp
	xorl	%ecx, %ecx
	movl	$2, -8(%rbp)
	movl	$1, -76(%rbp)
	movl	$3, -4(%rbp)
	movl	-8(%rbp), %eax
	addl	-4(%rbp), %eax
	movl	%eax, -72(%rbp)
	movl	-8(%rbp), %eax
	movl	-4(%rbp), %edx
	subl	%eax, %edx
	movl	%edx, -68(%rbp)
	movl	-8(%rbp), %eax
	imull	-4(%rbp), %eax
	movl	%eax, -64(%rbp)
	movl	-8(%rbp), %esi
	movl	-4(%rbp), %eax
	cltd
	idivl	%esi
	movl	%eax, -60(%rbp)
	movl	-8(%rbp), %esi
	movl	-4(%rbp), %eax
	cltd
	idivl	%esi
	movl	%edx, -56(%rbp)
	movl	-8(%rbp), %eax
	cmpl	-4(%rbp), %eax
	sete	%al
	andb	$1, %al
	movzbl	%al, %eax
	movl	%eax, -52(%rbp)
	movl	-8(%rbp), %eax
	cmpl	-4(%rbp), %eax
	setg	%al
	andb	$1, %al
	movzbl	%al, %eax
	movl	%eax, -48(%rbp)
	movl	-8(%rbp), %eax
	cmpl	-4(%rbp), %eax
	setl	%al
	andb	$1, %al
	movzbl	%al, %eax
	movl	%eax, -44(%rbp)
	movl	-8(%rbp), %eax
	cmpl	-4(%rbp), %eax
	setge	%al
	andb	$1, %al
	movzbl	%al, %eax
	movl	%eax, -40(%rbp)
	movl	-8(%rbp), %eax
	cmpl	-4(%rbp), %eax
	setle	%al
	andb	$1, %al
	movzbl	%al, %eax
	movl	%eax, -36(%rbp)
	movl	-8(%rbp), %eax
	cmpl	-4(%rbp), %eax
	setne	%al
	andb	$1, %al
	movzbl	%al, %eax
	movl	%eax, -32(%rbp)
	movl	$1, -12(%rbp)
	movl	$0, -16(%rbp)
	cmpl	$0, -12(%rbp)
	je	.LBB1_2
# %bb.1:
	cmpl	$0, -16(%rbp)
	setne	%cl
.LBB1_2:
	andb	$1, %cl
	movzbl	%cl, %eax
	movl	%eax, -28(%rbp)
	cmpl	$0, -12(%rbp)
	movb	$1, %al
	jne	.LBB1_4
# %bb.3:
	cmpl	$0, -16(%rbp)
	setne	%al
.LBB1_4:
	andb	$1, %al
	movzbl	%al, %eax
	movl	%eax, -24(%rbp)
	cmpl	$0, -12(%rbp)
	setne	%al
	xorb	$-1, %al
	andb	$1, %al
	movzbl	%al, %eax
	movl	%eax, -20(%rbp)
	movl	-72(%rbp), %esi
	movabsq	$_ZSt4cout, %rdi
	callq	_ZNSolsEi
	movq	%rax, %rdi
	movabsq	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %rsi
	callq	_ZNSolsEPFRSoS_E
	movl	-68(%rbp), %esi
	movabsq	$_ZSt4cout, %rdi
	callq	_ZNSolsEi
	movq	%rax, %rdi
	movabsq	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %rsi
	callq	_ZNSolsEPFRSoS_E
	movl	-64(%rbp), %esi
	movabsq	$_ZSt4cout, %rdi
	callq	_ZNSolsEi
	movq	%rax, %rdi
	movabsq	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %rsi
	callq	_ZNSolsEPFRSoS_E
	movl	-60(%rbp), %esi
	movabsq	$_ZSt4cout, %rdi
	callq	_ZNSolsEi
	movq	%rax, %rdi
	movabsq	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %rsi
	callq	_ZNSolsEPFRSoS_E
	movl	-56(%rbp), %esi
	movabsq	$_ZSt4cout, %rdi
	callq	_ZNSolsEi
	movq	%rax, %rdi
	movabsq	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %rsi
	callq	_ZNSolsEPFRSoS_E
	movl	-52(%rbp), %esi
	movabsq	$_ZSt4cout, %rdi
	callq	_ZNSolsEi
	movq	%rax, %rdi
	movabsq	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %rsi
	callq	_ZNSolsEPFRSoS_E
	movl	-48(%rbp), %esi
	movabsq	$_ZSt4cout, %rdi
	callq	_ZNSolsEi
	movq	%rax, %rdi
	movabsq	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %rsi
	callq	_ZNSolsEPFRSoS_E
	movl	-44(%rbp), %esi
	movabsq	$_ZSt4cout, %rdi
	callq	_ZNSolsEi
	movq	%rax, %rdi
	movabsq	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %rsi
	callq	_ZNSolsEPFRSoS_E
	movl	-40(%rbp), %esi
	movabsq	$_ZSt4cout, %rdi
	callq	_ZNSolsEi
	movq	%rax, %rdi
	movabsq	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %rsi
	callq	_ZNSolsEPFRSoS_E
	movl	-36(%rbp), %esi
	movabsq	$_ZSt4cout, %rdi
	callq	_ZNSolsEi
	movq	%rax, %rdi
	movabsq	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %rsi
	callq	_ZNSolsEPFRSoS_E
	movl	-32(%rbp), %esi
	movabsq	$_ZSt4cout, %rdi
	callq	_ZNSolsEi
	movq	%rax, %rdi
	movabsq	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %rsi
	callq	_ZNSolsEPFRSoS_E
	movl	-28(%rbp), %esi
	movabsq	$_ZSt4cout, %rdi
	callq	_ZNSolsEi
	movq	%rax, %rdi
	movabsq	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %rsi
	callq	_ZNSolsEPFRSoS_E
	movl	-24(%rbp), %esi
	movabsq	$_ZSt4cout, %rdi
	callq	_ZNSolsEi
	movq	%rax, %rdi
	movabsq	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %rsi
	callq	_ZNSolsEPFRSoS_E
	movl	-20(%rbp), %esi
	movabsq	$_ZSt4cout, %rdi
	callq	_ZNSolsEi
	movq	%rax, %rdi
	movabsq	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %rsi
	callq	_ZNSolsEPFRSoS_E
	xorl	%eax, %eax
	addq	$80, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.section	.text.startup,"ax",@progbits
	.p2align	4, 0x90         # -- Begin function _GLOBAL__sub_I_test1.cpp
	.type	_GLOBAL__sub_I_test1.cpp,@function
_GLOBAL__sub_I_test1.cpp:               # @_GLOBAL__sub_I_test1.cpp
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	callq	__cxx_global_var_init
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end2:
	.size	_GLOBAL__sub_I_test1.cpp, .Lfunc_end2-_GLOBAL__sub_I_test1.cpp
	.cfi_endproc
                                        # -- End function
	.type	_ZStL8__ioinit,@object  # @_ZStL8__ioinit
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,1
	.hidden	__dso_handle
	.section	.init_array,"aw",@init_array
	.p2align	3
	.quad	_GLOBAL__sub_I_test1.cpp
	.ident	"clang version 10.0.0-4ubuntu1 "
	.section	".note.GNU-stack","",@progbits
