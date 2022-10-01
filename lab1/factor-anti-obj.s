
factor.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <main>:
   0:	f3 0f 1e fa          	endbr64 
   4:	55                   	push   %rbp
   5:	48 89 e5             	mov    %rsp,%rbp
   8:	48 83 ec 20          	sub    $0x20,%rsp
   c:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
  13:	00 00 
  15:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  19:	31 c0                	xor    %eax,%eax
  1b:	48 8d 45 ec          	lea    -0x14(%rbp),%rax
  1f:	48 89 c6             	mov    %rax,%rsi
  22:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # 29 <main+0x29>
  29:	e8 00 00 00 00       	callq  2e <main+0x2e>
  2e:	c7 45 f0 02 00 00 00 	movl   $0x2,-0x10(%rbp)
  35:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
  3c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  3f:	39 45 f0             	cmp    %eax,-0x10(%rbp)
  42:	7f 10                	jg     54 <main+0x54>
  44:	8b 45 f4             	mov    -0xc(%rbp),%eax
  47:	0f af 45 f0          	imul   -0x10(%rbp),%eax
  4b:	89 45 f4             	mov    %eax,-0xc(%rbp)
  4e:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
  52:	eb e8                	jmp    3c <main+0x3c>
  54:	8b 45 f4             	mov    -0xc(%rbp),%eax
  57:	89 c6                	mov    %eax,%esi
  59:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # 60 <main+0x60>
  60:	e8 00 00 00 00       	callq  65 <main+0x65>
  65:	48 89 c2             	mov    %rax,%rdx
  68:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 6f <main+0x6f>
  6f:	48 89 c6             	mov    %rax,%rsi
  72:	48 89 d7             	mov    %rdx,%rdi
  75:	e8 00 00 00 00       	callq  7a <main+0x7a>
  7a:	b8 00 00 00 00       	mov    $0x0,%eax
  7f:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  83:	64 48 33 0c 25 28 00 	xor    %fs:0x28,%rcx
  8a:	00 00 
  8c:	74 05                	je     93 <main+0x93>
  8e:	e8 00 00 00 00       	callq  93 <main+0x93>
  93:	c9                   	leaveq 
  94:	c3                   	retq   

0000000000000095 <__static_initialization_and_destruction_0(int, int)>:
  95:	f3 0f 1e fa          	endbr64 
  99:	55                   	push   %rbp
  9a:	48 89 e5             	mov    %rsp,%rbp
  9d:	48 83 ec 10          	sub    $0x10,%rsp
  a1:	89 7d fc             	mov    %edi,-0x4(%rbp)
  a4:	89 75 f8             	mov    %esi,-0x8(%rbp)
  a7:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
  ab:	75 32                	jne    df <__static_initialization_and_destruction_0(int, int)+0x4a>
  ad:	81 7d f8 ff ff 00 00 	cmpl   $0xffff,-0x8(%rbp)
  b4:	75 29                	jne    df <__static_initialization_and_destruction_0(int, int)+0x4a>
  b6:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # bd <__static_initialization_and_destruction_0(int, int)+0x28>
  bd:	e8 00 00 00 00       	callq  c2 <__static_initialization_and_destruction_0(int, int)+0x2d>
  c2:	48 8d 15 00 00 00 00 	lea    0x0(%rip),%rdx        # c9 <__static_initialization_and_destruction_0(int, int)+0x34>
  c9:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # d0 <__static_initialization_and_destruction_0(int, int)+0x3b>
  d0:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # d7 <__static_initialization_and_destruction_0(int, int)+0x42>
  d7:	48 89 c7             	mov    %rax,%rdi
  da:	e8 00 00 00 00       	callq  df <__static_initialization_and_destruction_0(int, int)+0x4a>
  df:	90                   	nop
  e0:	c9                   	leaveq 
  e1:	c3                   	retq   

00000000000000e2 <_GLOBAL__sub_I_main>:
  e2:	f3 0f 1e fa          	endbr64 
  e6:	55                   	push   %rbp
  e7:	48 89 e5             	mov    %rsp,%rbp
  ea:	be ff ff 00 00       	mov    $0xffff,%esi
  ef:	bf 01 00 00 00       	mov    $0x1,%edi
  f4:	e8 9c ff ff ff       	callq  95 <__static_initialization_and_destruction_0(int, int)>
  f9:	5d                   	pop    %rbp
  fa:	c3                   	retq   
