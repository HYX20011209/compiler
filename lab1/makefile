.PHONY: pre, lexer, ast-g++, ast-llvm,ir-llvm, asm, obj,exe,antiobj,antiexe

all: pre lexer ast-g++ ast-llvm ir-llvm  all-pass asm  obj exe antiobj antiexe 

#预处理
pre:
	g++ factor.cpp -E -o factor.i

#词法分析
lexer:
	clang -E -Xclang -dump-tokens factor.cpp> tokens 2>&1

#语法分析树-文本形式
ast-g++:
	g++ -fdump-tree-original-raw factor.cpp

#语法分析树-树形式
ast-llvm:
	clang -E -Xclang -ast-dump factor.cpp > clangAst 2>&1

#生成llvm中间代码
ir-llvm:
	clang -S -emit-llvm factor.cpp

#生成每个pass后的llvm IR
all-pass:
	llc -print-before-all -print-after-all factor.ll > factor.log 2>&1

#生成汇编代码
asm:
	g++ -O0 -o factor.s -S -masm=att factor.i

#生成目标文件
obj:
	g++ -O0 -c -o factor.o factor.s


antiobj:
	objdump -C -d factor.o > factor-anti-obj.s
	nm -C factor.o > factor-nm-obj.txt

exe:
	g++ -O0 -o factor factor.o

antiexe:
	objdump -C -d factor>factor-anti-exe.s
	nm -C factor>factor-nm-exe.txt

#opt -S --memcpyopt factor.ll -o factor1.ll