#ifndef __AST_H__
#define __AST_H__

#include <fstream>

class SymbolEntry;

class Node
{
private:
    static int counter;
    int seq;
public:
    Node();
    int getSeq() const {return seq;};
    virtual void output(int level) = 0;
};

class ExprNode : public Node
{
protected:
    SymbolEntry *symbolEntry;
public:
    ExprNode(SymbolEntry *symbolEntry) : symbolEntry(symbolEntry){};
    // Type* getType();
};

class BinaryExpr : public ExprNode
{
private:
    int op;
    ExprNode *expr1, *expr2;
public:
    enum {ADD, SUB, MUL, DIV, MOD, AND, OR, LESS, LESSEQ, GREAT, GREATEQ, EQUAL, NEQUAL};
    BinaryExpr(SymbolEntry *se, int op, ExprNode*expr1, ExprNode*expr2) : ExprNode(se), op(op), expr1(expr1), expr2(expr2){};
    void output(int level);
};

class Constant : public ExprNode
{
public:
    Constant(SymbolEntry *se) : ExprNode(se){};
    void output(int level);
};

class Id : public ExprNode
{
public:
    Id(SymbolEntry *se) : ExprNode(se){};
    SymbolEntry* getSymbolEntry() {return symbolEntry;}
    void output(int level);
};

class StmtNode : public Node
{};

class EmptyStmt : public StmtNode
{
public:
    EmptyStmt(){};
    void output(int level);
};

class CompoundStmt : public StmtNode
{
private:
    StmtNode *stmt;
public:
    CompoundStmt(StmtNode *stmt) : stmt(stmt) {};
    void output(int level);
};

class SeqNode : public StmtNode
{
private:
    std::vector<StmtNode*> stmtList;
public:
    SeqNode(){}
    void addNext(StmtNode* next);
    void output(int level);
};

class DefNode : public StmtNode
{
private:
    Id* id;
    InitValNode* initVal;
    bool isConst;
    bool isArray;
public:
    DefNode(Id* id, InitValNode* initVal, bool isConst, bool isArray) : 
        isConst(isConst), isArray(isArray), id(id), initVal(initVal){};
    Id* getId() {return id;}
    void output(int level);
};

class InitValNode : public StmtNode
{
private:
    bool isConst;
    bool isArray;
    std::vector<ExprNode*> initValList;
public:
    InitValNode(bool isConst, bool isArray) : isConst(isConst), isArray(isArray){};
    void addNext(ExprNode* next);
    void output(int level);
};

class DeclStmt : public StmtNode
{
private:
    bool isConst;
    std::vector<DefNode*> defList;
public:
    DeclStmt(bool isConst) : isConst(isConst){};
    void addNext(DefNode* next);
    void output(int level);
};

class IfStmt : public StmtNode
{
private:
    ExprNode *cond;
    StmtNode *thenStmt;
public:
    IfStmt(ExprNode *cond, StmtNode *thenStmt) : cond(cond), thenStmt(thenStmt){};
    void output(int level);
};

class IfElseStmt : public StmtNode
{
private:
    ExprNode *cond;
    StmtNode *thenStmt;
    StmtNode *elseStmt;
public:
    IfElseStmt(ExprNode *cond, StmtNode *thenStmt, StmtNode *elseStmt) : cond(cond), thenStmt(thenStmt), elseStmt(elseStmt) {};
    void output(int level);
};


class BreakStmt: public StmtNode
{
public:
    BreakStmt(){};
    void output(int level);
};

class ContinueStmt: public StmtNode
{
public:
    ContinueStmt(){};
    void output(int level);
};


class ReturnStmt : public StmtNode
{
private:
    ExprNode *retValue;
public:
    ReturnStmt(ExprNode*retValue) : retValue(retValue) {};
    void output(int level);
};

class AssignStmt : public StmtNode
{
private:
    ExprNode *lval;
    ExprNode *expr;
public:
    AssignStmt(ExprNode *lval, ExprNode *expr) : lval(lval), expr(expr) {};
    void output(int level);
};

class FuncDefParamsNode : public StmtNode
{
private:
    std::vector<Id*> paramsList;
public:
    FuncDefParamsNode() {};
    void addNext(Id* next);
    void output(int level);
};

class FunctionDef : public StmtNode
{
private:
    SymbolEntry *se;
    StmtNode *stmt;
    FuncDefParamsNode *params;
public:
    FunctionDef(SymbolEntry *se, FuncDefParamsNode *params, StmtNode *stmt) : se(se),  params(params), stmt(stmt){};
    void output(int level);
};

class FuncCallParamsNode : public StmtNode
{
private:
    std::vector<ExprNode*> paramsList;
public:
    FuncCallParamsNode(){};
    void addNext(ExprNode* next);
    void output(int level);
};

class FuncCallNode : public ExprNode
{
private:
    Id* funcId;
    FuncCallParamsNode* params;
public:
    FuncCallNode(SymbolEntry *se, Id* id, FuncCallParamsNode* params) : ExprNode(se), funcId(id), params(params){};
    void output(int level);
};

class Ast
{
private:
    Node* root;
public:
    Ast() {root = nullptr;}
    void setRoot(Node*n) {root = n;}
    void output();
};

#endif
