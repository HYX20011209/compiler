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
%token <ftype> FLOATNUM
%token IF ELSE WHILE BREAK CONTINUE RETURN
%token INT VOID FLOAT
%token LPAREN RPAREN LBRACK RBRACK LBRACE RBRACE SEMICOLON COMMA
%token ADD SUB MUL DIV MOD AND OR NOT LESS LESSEQ GREAT GREATEQ EQUAL NEQUAL ASSIGN

%type <stmttype> Stmts Stmt AssignStmt BlockStmt ExpStmt IfStmt WhileStmt BreakStmt ContinueStmt ReturnStmt 
%type <stmttype> DeclStmt ConstDefList ConstDef ConstInitVal VarDefList VarDef VarInitVal FuncDef FuncParams FuncParam FuncRParams
%type <exprtype> Exp ConstExp AddExp MulExp UnaryExp Cond LOrExp PrimaryExp LVal RelExp EqExp LAndExp
%type <type> Type

%precedence THEN
%precedence ELSE
%%
Program
    : Stmts {
        ast.setRoot($1);
    }
    ;

/* Stmts
    : Stmt {$$=$1;}
    | Stmts Stmt{
        $$ = new SeqNode($1, $2);
    }
    ; */
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

Stmt
    : AssignStmt {$$=$1;}
    | ExpStmt SEMICOLON{$$=$1;}
    | BlockStmt {$$=$1;}
    | IfStmt {$$=$1;}
    | WhileStmt {$$=$1;}
    | BreakStmt {$$=$1;}
    | ReturnStmt {$$=$1;}
    | DeclStmt {$$=$1;}
    | FuncDef {$$=$1;}
    | SEMICOLON {$$ = new EmptyStmt();}
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
AssignStmt
    :
        LVal ASSIGN Exp SEMICOLON {
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
IfStmt
    : IF LPAREN Cond RPAREN Stmt %prec THEN {
        $$ = new IfStmt($3, $5);
    }
    | IF LPAREN Cond RPAREN Stmt ELSE Stmt {
        $$ = new IfElseStmt($3, $5, $7);
    }
    ;

//while 语句
WhileStmt
    :   WHILE LPAREN Cond RPAREN Stmt {
            $$ = new WhileStmt($3,$5);
        }
    ;

//break 语句
BreakStmt
    :   BREAK SEMICOLON {
            //std::cout << "BreakStmt -> BREAK SEMICOLON" << std::endl;
            $$ = new BreakStmt();
        }
    ;

//continue 语句
ContinueStmt
    :   CONTINUE SEMICOLON{
            // std::cout << "ContinueStmt -> CONTINUE SEMICOLON" << std::endl;
            $$ = new ContinueStmt;
        }
    ;


ReturnStmt
    :
        RETURN Exp SEMICOLON{
            $$ = new ReturnStmt($2);
        }
    |   RETURN SEMICOLON {
            // std::cout << "ReturnStmt -> RETURN SEMICOLON" << std::endl;
            $$ = new ReturnStmt(nullptr);
        }
    ;

//变量表达式
Exp
    :
        AddExp {$$ = $1;}
    ;


// 常量表达式
ConstExp
    :   AddExp {
            $$ = $1;
        }
    ;



Cond
    :
    LOrExp {$$ = $1;}
    ;
PrimaryExp
    :
    LVal {
        $$ = $1;
    }
    | INTEGER {
        SymbolEntry *se = new ConstantSymbolEntry(TypeSystem::intType, $1);
        $$ = new Constant(se);
    }
    ;
AddExp
    :
    PrimaryExp {$$ = $1;}
    |
    AddExp ADD PrimaryExp
    {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::ADD, $1, $3);
    }
    |
    AddExp SUB PrimaryExp
    {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::SUB, $1, $3);
    }
    ;
RelExp
    :
    AddExp {$$ = $1;}
    |
    RelExp LESS AddExp
    {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::LESS, $1, $3);
    }
    ;
LAndExp
    :
    RelExp {$$ = $1;}
    |
    LAndExp AND RelExp
    {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::AND, $1, $3);
    }
    ;
LOrExp
    :
    LAndExp {$$ = $1;}
    |
    LOrExp OR LAndExp
    {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::OR, $1, $3);
    }
    ;
Type
    : INT {
        $$ = TypeSystem::intType;
    }
    | VOID {
        $$ = TypeSystem::voidType;
    }
    ;
DeclStmt
    :
    Type ID SEMICOLON {
        SymbolEntry *se;
        se = new IdentifierSymbolEntry($1, $2, identifiers->getLevel());
        identifiers->install($2, se);
        $$ = new DeclStmt(new Id(se));
        delete []$2;
    }
    ;
FuncDef
    :
    Type ID {
        Type *funcType;
        funcType = new FunctionType($1,{});
        SymbolEntry *se = new IdentifierSymbolEntry(funcType, $2, identifiers->getLevel());
        identifiers->install($2, se);
        identifiers = new SymbolTable(identifiers);
    }
    LPAREN RPAREN
    BlockStmt
    {
        SymbolEntry *se;
        se = identifiers->lookup($2);
        assert(se != nullptr);
        $$ = new FunctionDef(se, $6);
        SymbolTable *top = identifiers;
        identifiers = identifiers->getPrev();
        delete top;
        delete []$2;
    }
    ;
%%

int yyerror(char const* message)
{
    std::cerr<<message<<std::endl;
    return -1;
}
