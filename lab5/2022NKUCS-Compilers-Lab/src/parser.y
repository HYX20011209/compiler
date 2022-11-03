%code top{
    #include <iostream>
    #include <assert.h>
    #include "parser.h"
    extern Ast ast;
    int yylex();
    int yyerror( char const * );
    // 当前类型
    Type* currentType;
}

%code requires {
    #include "Ast.h"
    #include "SymbolTable.h"
    #include "Type.h"
}

%union {
    int itype;
    float ftype;
    char* strtype;
    StmtNode* stmttype;
    ExprNode* exprtype;
    Type* type;
}

%start Program
%token <strtype> ID 
%token <itype> INTEGER
%token <ftype> FLOATING
%token CONST
%token TYPE_INT TYPE_FLOAT TYPE_VOID
%token IF ELSE WHILE BREAK CONTINUE RETURN
%token LPAREN RPAREN LBRACKET RBRACKET LBRACE RBRACE COMMA SEMICOLON
%token ADD SUB MUL DIV MOD AND OR NOT LESS LESSEQ GREAT GREATEQ EQ NEQ ASSIGN

%type <stmttype> Stmts Stmt AssignStmt ExpStmt BlockStmt IfStmt WhileStmt BreakStmt ContinueStmt ReturnStmt
%type <stmttype> DeclStmt ConstDefList ConstDef ConstInitVal VarDefList VarDef VarInitVal FuncDef FuncParams FuncParam FuncRParams
%type <exprtype> Exp ConstExp AddExp MulExp UnaryExp PrimaryExp LVal Cond LOrExp LAndExp EqExp RelExp
%type <type> Type

%precedence THEN
%precedence ELSE
%%

// 程序
Program
    :   Stmts{
            ast.setRoot($1);
        }
    ;

Stmts
    :   Stmts Stmt{
            //这里需要注意的是递归推导出的每个Stmts都是同一个节点，
            //但拆分出的Stmt会被自下而上的压入vector
            SeqNode* node = (SeqNode*)$1; //创建一个SeqNode类型节点指针，赋值为Stmts
            node->addNext((StmtNode*)$2);//将Stmt放入该节点的vector中
            $$ = (StmtNode*) node;//将识别到的Stmts赋值为该节点（指针）
        }
    |   Stmt{
            SeqNode* node = new SeqNode();
            node->addNext((StmtNode*)$1);
            $$ = (StmtNode*) node;
        }
    ;

// 语句
Stmt
    :   AssignStmt {$$=$1;}
    |   ExpStmt SEMICOLON{$$=$1;}
    |   BlockStmt {$$=$1;}
    |   IfStmt {$$=$1;}
    |   WhileStmt {$$=$1;}
    |   BreakStmt {$$=$1;}
    |   ContinueStmt {$$=$1;}
    |   ReturnStmt {$$=$1;}
    |   DeclStmt {$$=$1;}
    |   FuncDef {$$=$1;}
    |   SEMICOLON {$$ = new EmptyStmt();}
    ;

LVal
    : ID {
        //识别到标识符就创建一个符号表项指针，并通过全局符号表指针
        //identifiers查找对应的标识符。没找到就打印错误信息
        //找到就创建一个Id节点类（继承自ExprNode）
        SymbolEntry *se;
        se = identifiers->lookup($1);
        if(se == nullptr)
        {
            fprintf(stderr, "identifier \"%s\" is undefined\n", (char*)$1);
            delete [](char*)$1;
            assert(se != nullptr);
        }
        $$ = new Id(se);
        delete []$1;
    }
    //数组左值
    ;
// 赋值语句
AssignStmt
    :   LVal ASSIGN Exp SEMICOLON {
            $$ = new AssignStmt($1, $3);
        }
    ;

// 表达式语句
ExpStmt
    :   ExpStmt COMMA Exp {
            ExprStmtNode* node = (ExprStmtNode*)$1;
            node->addNext($3);
            $$ = node;
        }
    |   Exp {
            ExprStmtNode* node = new ExprStmtNode();
            node->addNext($1);
            $$ = node;
        }
    ;

BlockStmt
    :   LBRACE 
        //遇到语句块左大括号就创建符号表，这时新的符号表是原来的后一级
        {identifiers = new SymbolTable(identifiers);}
        Stmts RBRACE 
        {
            $$ = new CompoundStmt($3);
            // SymbolTable *top = identifiers;
            //由于全局符号表，因此需要通过前向指针使之保持原有位置
            identifiers = identifiers->getPrev();
            // delete top;
        }
    |   LBRACE RBRACE 
        {
            $$ = new CompoundStmt(nullptr);
        }
    ;


// if语句
IfStmt
    :   IF LPAREN Cond RPAREN Stmt %prec THEN {
            $$ = new IfStmt($3, $5);
        }
    |   IF LPAREN Cond RPAREN Stmt ELSE Stmt {
            $$ = new IfElseStmt($3, $5, $7);
        }
    ;

//while 语句
WhileStmt
    :   WHILE LPAREN Cond RPAREN Stmt {
            $$ = new WhileStmt($3,$5);
        }
    ;

//todo break 语句
BreakStmt
    :   BREAK SEMICOLON {
            $$ = new BreakStmt();
        }
    ;

//todo continue 语句
ContinueStmt
    :   CONTINUE SEMICOLON{
            $$ = new ContinueStmt();
        }
    ;


// return 语句
ReturnStmt
    :   RETURN Exp SEMICOLON {
            $$ = new ReturnStmt($2);
        }
    |   RETURN SEMICOLON {
            // std::cout << "ReturnStmt -> RETURN SEMICOLON" << std::endl;
            $$ = new ReturnStmt(nullptr);
        }
    ;

// 变量表达式
Exp
    :   AddExp {
            $$ = $1;
        }
    ;

// 常量表达式
ConstExp
    :   AddExp {
            $$ = $1;
        }
    ;






/* 
    Symbol entry for temporary variable created by compiler. Example:

    int a;
    a = 1 + 2 + 3;

    The compiler would generate intermediate code like:

    t1 = 1 + 2
    t2 = t1 + 3
    a = t2

    So compiler should create temporary symbol entries for t1 and t2:

    | temporary variable | label |
    | t1                 | 1     |
    | t2                 | 2     |

class TemporarySymbolEntry : public SymbolEntry
{
private:
    int label;
public:
    TemporarySymbolEntry(Type *type, int label);
    virtual ~TemporarySymbolEntry() {};
    std::string toStr();
};
*/



AddExp
    :   MulExp {
            $$ = $1;
        }
    |   AddExp ADD MulExp {
            SymbolEntry *se;
            //只要有一个是float那么就应该创建float类型的表项
            if($1->getType()->isInt() && $3->getType()->isInt()){
                se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            }
            else{
                se = new TemporarySymbolEntry(TypeSystem::floatType, SymbolTable::getLabel());
            }
            $$ = new BinaryExpr(se, BinaryExpr::ADD, $1, $3);
        }
    |   AddExp SUB MulExp {
            SymbolEntry *se;
            if($1->getType()->isInt() && $3->getType()->isInt()){
                se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            }
            else{
                se = new TemporarySymbolEntry(TypeSystem::floatType, SymbolTable::getLabel());
            }
            $$ = new BinaryExpr(se, BinaryExpr::SUB, $1, $3);
        }
    ;

// 乘法级表达式
MulExp
    :   UnaryExp {
            $$ = $1;
        }
    |   MulExp MUL UnaryExp {
            SymbolEntry *se;
            if($1->getType()->isInt() && $3->getType()->isInt()){
                se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            }
            else{
                se = new TemporarySymbolEntry(TypeSystem::floatType, SymbolTable::getLabel());
            }
            $$ = new BinaryExpr(se, BinaryExpr::MUL, $1, $3);
        }
    |   MulExp DIV UnaryExp {
            SymbolEntry *se;
            if($1->getType()->isInt() && $3->getType()->isInt()){
                se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            }
            else{
                se = new TemporarySymbolEntry(TypeSystem::floatType, SymbolTable::getLabel());
            }
            $$ = new BinaryExpr(se, BinaryExpr::DIV, $1, $3);
        }
    |   MulExp MOD UnaryExp {
            SymbolEntry *se;
            if($1->getType()->isInt() && $3->getType()->isInt()){
                se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            }
            else{
                se = new TemporarySymbolEntry(TypeSystem::floatType, SymbolTable::getLabel());
            }
            $$ = new BinaryExpr(se, BinaryExpr::MOD, $1, $3);
        }
    ;

// 非数组表达式
UnaryExp
    :   PrimaryExp {
            $$ = $1;
        }
    |   ID LPAREN FuncRParams RPAREN {//函数调用表达式，例如a = b + f(x)中的"f(x)""
            SymbolEntry *se;
            se = identifiers->lookup($1);
            if(se == nullptr)
            {
                fprintf(stderr, "identifier \"%s\" is undefined\n", (char*)$1);
                delete [](char*)$1;
                assert(se != nullptr);
            }
            SymbolEntry *tmp = new TemporarySymbolEntry(se->getType(), SymbolTable::getLabel());
            $$ = new FuncCallNode(tmp, new Id(se), (FuncCallParamsNode*)$3);
        }
    |   ADD UnaryExp {
            $$ = $2;
        }
    |   SUB UnaryExp {
            SymbolEntry *tmp = new TemporarySymbolEntry($2->getType(), SymbolTable::getLabel());
            $$ = new OneOpExpr(tmp, OneOpExpr::SUB, $2);
        }
    |   NOT UnaryExp {
            SymbolEntry *tmp = new TemporarySymbolEntry($2->getType(), SymbolTable::getLabel());
            $$ = new OneOpExpr(tmp, OneOpExpr::NOT, $2);
        }
    ;

/*  
    Symbol entry for literal constant. Example:

    int a = 1;

    Compiler should create constant symbol entry for literal constant '1'.

class ConstantSymbolEntry : public SymbolEntry
{
private:
    int value;

public:
    ConstantSymbolEntry(Type *type, int value);
    virtual ~ConstantSymbolEntry() {};
    int getValue() const {return value;};
    std::string toStr();
    // You can add any function you need here.
};
*/
PrimaryExp
    :   LVal {
            $$ = $1;
        }
    |   LPAREN Exp RPAREN {
            $$ = $2;
        }
    |   INTEGER {
            SymbolEntry *se = new ConstantSymbolEntry(TypeSystem::intType, $1);
            $$ = new Constant(se);
        }
    |   FLOATING {
            SymbolEntry *se = new ConstantSymbolEntry(TypeSystem::floatType, $1);
            $$ = new Constant(se);
        }
    ;

// 函数参数列表
FuncRParams
    :   FuncRParams COMMA Exp {
            FuncCallParamsNode* node = (FuncCallParamsNode*) $1;
            node->addNext($3);
            $$ = node;
        }
    |   Exp {
            FuncCallParamsNode* node = new FuncCallParamsNode();
            node->addNext($1);
            $$ = node;
        }
    |   %empty {
            $$ = nullptr;
        }
    ;

// 条件表达式
Cond
    :   LOrExp {$$ = $1;}
    ;

// 或运算表达式
LOrExp
    :   LAndExp {
            $$ = $1;
        }
    |   LOrExp OR LAndExp {
            SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::boolType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::OR, $1, $3);
        }
    ;

// 与运算表达式
LAndExp
    :   EqExp {
            $$ = $1;
        }
    |   LAndExp AND EqExp {
            SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::boolType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::AND, $1, $3);
        }
    ;

// 相等判断表达式
EqExp
    :   RelExp {
            $$ = $1;
        }
    |   EqExp EQ RelExp {
            SymbolEntry* se = new TemporarySymbolEntry(TypeSystem::boolType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::EQ, $1, $3);
        }
    |   EqExp NEQ RelExp {
            SymbolEntry* se = new TemporarySymbolEntry(TypeSystem::boolType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::NEQ, $1, $3);
        }
    ;

// 关系表达式
RelExp
    :   AddExp {
            $$ = $1;
        }
    |   RelExp LESS AddExp {
            SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::boolType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::LESS, $1, $3);
        }
    |   RelExp LESSEQ AddExp {
            SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::boolType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::LESSEQ, $1, $3);
        }
    |   RelExp GREAT AddExp {
            SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::boolType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::GREAT, $1, $3);
        }
    |   RelExp GREATEQ AddExp {
            SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::boolType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::GREATEQ, $1, $3);
        }
    ;

// 类型
Type
    :   TYPE_INT {
            $$ = TypeSystem::intType;
            //例如读取到"int a"，就把currentType设置为int
            currentType = TypeSystem::intType;
        }
    |   TYPE_FLOAT {
            $$ = TypeSystem::floatType;
            currentType = TypeSystem::floatType;
        }
    |   TYPE_VOID {
            $$ = TypeSystem::voidType;
        }
    ;

// 声明语句
DeclStmt
    :   CONST Type ConstDefList SEMICOLON {
            $$ = $3;
        }
    |   Type VarDefList SEMICOLON {
            $$ = $2;
        }
    ;

// 常量定义列表
ConstDefList
    :   ConstDefList COMMA ConstDef {
            DeclStmt* node = (DeclStmt*) $1;
            node->addNext((DefNode*)$3);
            $$ = node;
        }
    |   ConstDef {
            DeclStmt* node = new DeclStmt(true);
            node->addNext((DefNode*)$1);
            $$ = node;
        }
    ;

// 常量定义
ConstDef
    :   ID ASSIGN ConstInitVal {
            // 将ID插入符号表中
            Type* type;
            if(currentType->isInt()){
                type = TypeSystem::constIntType;
            }
            else{
                type = TypeSystem::constFloatType;
            }
            SymbolEntry *se;
            se = new IdentifierSymbolEntry(type, $1, identifiers->getLevel());
            identifiers->install($1, se);
            $$ = new DefNode(new Id(se), (InitValNode*)$3, true, false);
        }
    // todo 数组常量的定义
    ;

// 常量初始化值
ConstInitVal
    :   ConstExp {
            InitValNode* node = new InitValNode(true, false);
            node->addNext((ExprNode*)$1);
            $$ = node;
        }
    // todo 常量数组的初始化值 
    ;

// 变量定义列表
VarDefList
    :   VarDefList COMMA VarDef {
            DeclStmt* node = (DeclStmt*) $1;
            node->addNext((DefNode*)$3);
            $$ = node;
        }
    |   VarDef {
            DeclStmt* node = new DeclStmt(true);
            node->addNext((DefNode*)$1);
            $$ = node;
        }
    ;

// 变量定义
VarDef
    :   ID {
            Type* type;
            if(currentType->isInt()){
                type = TypeSystem::intType;
            }
            else{
                type = TypeSystem::floatType;
            }
            SymbolEntry *se;
            se = new IdentifierSymbolEntry(type, $1, identifiers->getLevel());
            identifiers->install($1, se);
            $$ = new DefNode(new Id(se), nullptr, false, false);
        }
    |   ID ASSIGN VarInitVal {
            Type* type;
            if(currentType->isInt()){
                type = TypeSystem::intType;
            }
            else{
                type = TypeSystem::floatType;
            }
            SymbolEntry *se;
            se = new IdentifierSymbolEntry(type, $1, identifiers->getLevel());
            identifiers->install($1, se);
            $$ = new DefNode(new Id(se), (InitValNode*)$3, false, false);
        }
    // todo 数组变量的定义
    ;

// 变量初始化值
VarInitVal
    :   Exp {
            InitValNode* node = new InitValNode(false, false);
            node->addNext((ExprNode*)$1);
            $$ = node;
        }
    // todo 数组变量的初始化值
    ;

// 函数定义
FuncDef
    :   Type ID {
            Type *funcType;
            funcType = new FunctionType($1,{});
            SymbolEntry *se = new IdentifierSymbolEntry(funcType, $2, identifiers->getLevel());
            identifiers->install($2, se);
            identifiers = new SymbolTable(identifiers);
        }
        LPAREN FuncParams RPAREN BlockStmt {
            SymbolEntry *se;
            se = identifiers->lookup($2);
            assert(se != nullptr);
            $$ = new FunctionDef(se, (FuncDefParamsNode*)$5, $7);
            SymbolTable *top = identifiers;
            identifiers = identifiers->getPrev();
            delete top;
            delete []$2;
        }
    ;

// 函数参数列表
FuncParams
    :   FuncParams COMMA FuncParam {
            FuncDefParamsNode* node = (FuncDefParamsNode*)$1;
            node->addNext(((DefNode*)$3)->getId());
            $$ = node;
        }
    |   FuncParam {
            FuncDefParamsNode* node = new FuncDefParamsNode();
            node->addNext(((DefNode*)$1)->getId());
            $$ = node;
        }
    |   %empty {
            $$ = nullptr;
        }
    ;

// 函数参数
FuncParam
    :   Type ID {
            SymbolEntry *se = new IdentifierSymbolEntry($1, $2, identifiers->getLevel());
            identifiers->install($2, se);
            $$ = new DefNode(new Id(se), nullptr, false, false);
        }
    // todo 数组函数参数
    ;
    
%%

int yyerror(char const* message)
{
    std::cerr<<message<<std::endl;
    return -1;
}
