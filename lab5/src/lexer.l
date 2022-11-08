%option noyywrap
%{
    /*
    * You will need to comment this line in lab5.
    */
    //#define ONLY_FOR_LEX
    
    #ifdef ONLY_FOR_LEX
    #else
    // #define YYSTYPE void *
    #endif

    #define YY_NO_UNPUT
    #define YY_NO_INPUT
    #include "parser.h"
    #include <string>
    #include <sstream>

    #include <ostream>
    #include <fstream>
    using namespace std;
    extern FILE *yyin; 
    extern FILE *yyout;

    int column = 1;

    #ifdef ONLY_FOR_LEX
    void DEBUG_FOR_LAB4(std::string token, std::string lexeme){
        fprintf(yyout, "[DEBUG LAB4]:  %8s%8s%8d%8d\n",token.c_str(), lexeme.c_str(), yylineno, column);
    }
    #endif
%}

INTNUM ([1-9][0-9]*|0)
OCTAL (0[1-7][0-7]*|0)
HEXAL (0(x|X)[1-9a-fA-F][0-9a-fA-F]*|0)
FLOATNUM ((([0-9]*[.][0-9]*([eE][+-]?[0-9]+)?)|([0-9]+[eE][+-]?[0-9]+))[fLlL]?)
ID [[:alpha:]_][[:alpha:][:digit:]_]*
EOL (\r\n|\n|\r)
WHITE [\t ]
COMMENT (\/\/[^\n]*)
commentbegin "/*"
commentelement .
commentline \n
commentend "*/"
%x COMMENT
%x COMBLOCK

%%
{commentbegin} {BEGIN COMMENT;}
<COMMENT>{commentelement} {}
<COMMENT>{commentline} {yylineno++;}
<COMMENT>{commentend} {BEGIN INITIAL;}

"int" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("INT_TYPE", "int");
        column+=strlen(yytext);
    #else
        return INT_TYPE;
    #endif
}
"float" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("FLOAT_TYPE", "float");
        column+=strlen(yytext);
    #else
        return FLOAT_TYPE;
    #endif
}
"void" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("VOID_TYPE", "void");
        column+=strlen(yytext);
    #else
        return VOID_TYPE;
    #endif 
}
"const" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("CONST", "const");
        column+=strlen(yytext);
    #else
        return CONST;
    #endif 

}
"if" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("IF", "if");
        column+=strlen(yytext);
    #else
        return IF;
    #endif
}
"else" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ELSE", "else");
        column+=strlen(yytext);
    #else
        return ELSE;
    #endif
}
"while" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("WHILE", "while");
        column+=strlen(yytext);
    #else
        return WHILE;
    #endif
}
"break" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("BREAK", "break");
        column+=strlen(yytext);
    #else
        return BREAK;
    #endif
}
"continue" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("CONTINUE", "continue");
        column+=strlen(yytext);
    #else
        return CONTINUE;
    #endif
}
"return" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("RETURN", "return");
        column+=strlen(yytext);
    #else
        return RETURN;
    #endif
}
"=" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ASSIGN", "=");
        column+=strlen(yytext);
    #else
        return ASSIGN;
    #endif
}
"==" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("EQ", "==");
        column+=strlen(yytext);
    #else
        return EQ;
    #endif
}
"!=" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("NEQ", "!=");
        column+=strlen(yytext);
    #else
        return NEQ;
    #endif
}
"<" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("LESS", "<");
        column+=strlen(yytext);
    #else
        return LESS;
    #endif
}
"<=" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("LESSEQ", "<=");
        column+=strlen(yytext);
    #else
        return LESSEQ;
    #endif
}
">" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("GREAT", ">");
        column+=strlen(yytext);
    #else
        return GREAT;
    #endif
}
">=" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("GREATEQ", ">=");
        column+=strlen(yytext);
    #else
        return GREATEQ;
    #endif
}
"+" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ADD", "+");
        column+=strlen(yytext);
    #else
        return ADD;
    #endif
}
"-" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("SUB", "-");
        column+=strlen(yytext);
    #else
        return SUB;
    #endif
}
"*" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("MUL", "*");
        column+=strlen(yytext);
    #else
        return MUL;
    #endif
}
"/" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("DIV", "/");
        column+=strlen(yytext);
    #else
        return DIV;
    #endif
}
"%" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("MOD", "%");
        column+=strlen(yytext);
    #else
        return MOD;
    #endif
}
"||" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("OR", "||");
        column+=strlen(yytext);
    #else
        return OR;
    #endif
}
"&&" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("AND", "&&");
        column+=strlen(yytext);
    #else
        return AND;
    #endif
}
"!" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("NOT", "!");
        column+=strlen(yytext);
    #else
        return NOT;
    #endif
}
"," {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("COMMA", ",");
        column+=strlen(yytext);
    #else
        return COMMA;
    #endif
}
";" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("SEMICOLON", ";");
        column+=strlen(yytext);
    #else
        return SEMICOLON;
    #endif
}
"(" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("LPAREN", "(");
        column+=strlen(yytext);
    #else
        return LPAREN;
    #endif
}
")" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("RPAREN", ")");
        column+=strlen(yytext);
    #else
    return RPAREN;
    #endif
}
"[" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("LBRACKET", "[");
        column+=strlen(yytext);
    #else
        return LBRACKET;
    #endif
}
"]" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("RBRACKET", "]");
        column+=strlen(yytext);
    #else
    return RBRACKET;
    #endif
}
"{" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("LBRACE", "{");
        column+=strlen(yytext);
    #else
        return LBRACE;
    #endif
}
"}" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("RBRACE", "}");
        column+=strlen(yytext);
    #else
        return RBRACE;
    #endif
}
"getint" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ID", "getint");
        column+=strlen(yytext);
    #else
        yylval.strtype = new char[strlen(yytext) + 1];
        strcpy(yylval.strtype, yytext);
        Type* funcType = new FunctionType(TypeSystem::intType, {});//返回类型int，无参数
        SymbolTable* globalTable;    //全局符号表
        for(globalTable = identifiers;globalTable->getPrev();globalTable = globalTable->getPrev()); //全局符号表
        SymbolEntry* entry = new IdentifierSymbolEntry(funcType, yytext, 0);//全局作用域，即0级
        globalTable->install(yytext, entry);
        return ID;
    #endif
}
"getch" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ID", "getch");
        column+=strlen(yytext);
    #else
        yylval.strtype = new char[strlen(yytext) + 1];
        strcpy(yylval.strtype, yytext);
        Type* funcType = new FunctionType(TypeSystem::intType, {});
        SymbolTable* globalTable;    //全局符号表
        for(globalTable = identifiers;globalTable->getPrev();globalTable = globalTable->getPrev()); //全局符号表
        SymbolEntry* entry = new IdentifierSymbolEntry(funcType, yytext, 0);//全局作用域，即0级
        globalTable->install(yytext, entry);
        return ID;
    #endif
}
"getfloat" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ID", "getfloat");
        column+=strlen(yytext);
    #else
        yylval.strtype = new char[strlen(yytext) + 1];
        strcpy(yylval.strtype, yytext);
        Type* funcType = new FunctionType(TypeSystem::floatType, {});
        SymbolTable* globalTable;    //全局符号表
        for(globalTable = identifiers;globalTable->getPrev();globalTable = globalTable->getPrev()); //全局符号表
        SymbolEntry* entry = new IdentifierSymbolEntry(funcType, yytext, 0);//全局作用域，即0级
        globalTable->install(yytext, entry);
        return ID;
    #endif
}
"putint" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ID", "putint");
        column+=strlen(yytext);
    #else
        yylval.strtype = new char[strlen(yytext) + 1];
        strcpy(yylval.strtype, yytext);
        std::vector<Type*> vec; //形参类型表
        vec.push_back(TypeSystem::intType);
        Type* funcType = new FunctionType(TypeSystem::voidType, vec);//返回类型void，参数表[int]
        SymbolTable* globalTable;    //全局符号表
        for(globalTable = identifiers;globalTable->getPrev();globalTable = globalTable->getPrev()); //全局符号表
        SymbolEntry* entry = new IdentifierSymbolEntry(funcType, yytext, 0);//全局作用域，即0级
        globalTable->install(yytext, entry);
        return ID;
    #endif
}
"putch" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ID", "putch");
        column+=strlen(yytext);
    #else
        yylval.strtype = new char[strlen(yytext) + 1];
        strcpy(yylval.strtype, yytext);
        std::vector<Type*> vec; //形参类型表
        vec.push_back(TypeSystem::intType);
        Type* funcType = new FunctionType(TypeSystem::voidType, vec);//返回类型void，参数表[int]
        SymbolTable* globalTable;    //全局符号表
        for(globalTable = identifiers;globalTable->getPrev();globalTable = globalTable->getPrev()); //全局符号表
        SymbolEntry* entry = new IdentifierSymbolEntry(funcType, yytext, 0);//全局作用域，即0级
        globalTable->install(yytext, entry);
        return ID;
    #endif
}
"putfloat" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ID", "putfloat");
        column+=strlen(yytext);
    #else
        yylval.strtype = new char[strlen(yytext) + 1];
        strcpy(yylval.strtype, yytext);
        std::vector<Type*> vec; //形参类型表
        vec.push_back(TypeSystem::floatType);
        Type* funcType = new FunctionType(TypeSystem::voidType, vec);//返回类型void，参数表[int]
        SymbolTable* globalTable;    //全局符号表
        for(globalTable = identifiers;globalTable->getPrev();globalTable = globalTable->getPrev()); //全局符号表
        SymbolEntry* entry = new IdentifierSymbolEntry(funcType, yytext, 0);//全局作用域，即0级
        globalTable->install(yytext, entry);
        return ID;
    #endif
    /*todo: implement getarray, putarray, getfarray, putfarray, putf*/
}
"starttime" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ID", "starttime");
        column+=strlen(yytext);
    #else
        yylval.strtype = new char[strlen(yytext) + 1];
        strcpy(yylval.strtype, yytext);
        Type* funcType = new FunctionType(TypeSystem::voidType, {});//返回类型void，无参数
        SymbolTable* globalTable;    //全局符号表
        for(globalTable = identifiers;globalTable->getPrev();globalTable = globalTable->getPrev()); //全局符号表
        SymbolEntry* entry = new IdentifierSymbolEntry(funcType, yytext, 0);//全局作用域，即0级
        globalTable->install(yytext, entry);
        return ID;
    #endif
}
"stoptime" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ID", "stoptime");
        column+=strlen(yytext);
    #else
        yylval.strtype = new char[strlen(yytext) + 1];
        strcpy(yylval.strtype, yytext);
        Type* funcType = new FunctionType(TypeSystem::voidType, {});//返回类型void，无参数
        SymbolTable* globalTable;    //全局符号表
        for(globalTable = identifiers;globalTable->getPrev();globalTable = globalTable->getPrev()); //全局符号表
        SymbolEntry* entry = new IdentifierSymbolEntry(funcType, yytext, 0);//全局作用域，即0级
        globalTable->install(yytext, entry);
        return ID;
    #endif
}
{INTNUM} {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("INTNUM", ""+std::string(yytext));
        column+=strlen(yytext);
    #else
        yylval.itype = atoi(yytext);
        return INTNUM;
    #endif
}
{FLOATNUM} {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("FLOATNUM", ""+std::string(yytext));
        column+=strlen(yytext);
    #else
        yylval.ftype = atoi(yytext);
        return FLOATNUM;
    #endif
}
{ID} {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ID", ""+std::string(yytext));
        column+=strlen(yytext);
    #else
        char* lexeme = new char[strlen(yytext) + 1];
        strcpy(lexeme, yytext);
        yylval.strtype = lexeme;
        return ID;
    #endif
}
{OCTAL} {
    char* stop;
    int dec = strtol(yytext, &stop, 8);
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("DECIMAL", ""+to_string(dec));
        column+=strlen(yytext);
    #else
        yylval.itype = dec;
        return INTNUM;
    #endif 
}
{HEXAL} {
    char* stop;
    int dec = strtol(yytext, &stop, 16);
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("DECIMAL", ""+to_string(dec));
        column+=strlen(yytext);
    #else
        yylval.itype = dec;
        return INTNUM;
    #endif 
}
{EOL} {
    #ifdef ONLY_FOR_LEX
        yylineno++;
        column=1;
    #endif
}
{WHITE} {
    #ifdef ONLY_FOR_LEX
        if(yytext[0] == 32)
            column+=1;
        else
            column+=4;
    #endif
}
{COMMENT}
%%

#ifdef ONLY_FOR_LEX
int main(int argc, char **argv){

    if(argc != 5){
        fprintf(stderr, "Argument Not Enough");
        exit(EXIT_FAILURE);
    }

    
    if(!(yyin = fopen(argv[1], "r"))){
        fprintf(stderr, "No such file or directory: %s", argv[1]);
        exit(EXIT_FAILURE);
    }

    if(!(yyout = fopen(argv[3], "w"))){
        fprintf(stderr, "No such file or directory: %s", argv[3]);
        exit(EXIT_FAILURE);
    }
    fprintf(yyout, "[DEBUG LAB4]:  %8s%8s%8s%8s\n","token", "lexeme", "lineno", "column");
    yylineno = 1;
    yylex();
    return 0;
}
#endif