%{
#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>
#ifndef YYSTYPE
#define YYSTYPE double
#endif
int yylex();
extern int yyparse();
FILE* yyin;
void yyerror(const char* s);
// int isdigit(char t){
//     if(t>='0'&&t<='9'){
//         return 1;
//     }
//     return 0;
// }
%}


%token ADD
%token SUB
%token MUL
%token DIV
%token LEFT_BR
%token RIGHT_BR
%token NUMBER


%left ADD SUB
%left MUL DIV
%right UMINUS

%%

lines   :   lines expr '\n' {printf("%f\n",$2);}
        |   lines '\n'
        |   
        ;

expr    :   expr ADD expr   {$$ = $1 + $3;}
        |   expr SUB expr   {$$ = $1 - $3;}
        |   expr MUL expr   {$$ = $1 * $3;}
        |   expr DIV expr   {$$ = $1 / $3;}
        |   LEFT_BR expr RIGHT_BR   {$$ = $2;}
        |   SUB expr %prec UMINUS   {$$ = -$2;}
        |   NUMBER
        ;

// NUMBER  :   '0'     {$$=0.0;}
//         |   '1'     {$$=1.0;}
//         |   '2'     {$$=2.0;}
//         |   '3'     {$$=3.0;}
//         |   '4'     {$$=4.0;}
//         |   '5'     {$$=5.0;}
//         |   '6'     {$$=6.0;}
//         |   '7'     {$$=7.0;}
//         |   '8'     {$$=8.0;}
//         |   '9'     {$$=9.0;}
//         ;


%%



int yylex()
{
    int t;
    while(1)
    {
        t = getchar();
        if(isdigit(t)){
            yylval = 0;
            while(isdigit(t)){
                yylval = yylval*10 + t - '0';
                t = getchar();
            }
            ungetc(t,stdin);
            return NUMBER;
        }else if(t=='+')
        {
            return ADD;
        }
        else if(t=='-')
        {
            return SUB;
        }
        else if(t=='*')
        {
            return MUL;
        }
        else if(t=='/')
        {
            return DIV;
        }
        else if(t=='(')
        {
            return LEFT_BR;
        }
        else if(t==')')
        {
            return RIGHT_BR;
        }
        else
        {
            return t;
        }
    }
    
}

int main(void)
{
    yyin = stdin;
    do{
        yyparse();
    }while(!feof(yyin));
    return 0;
}
void yyerror(const char* s){
    fprintf(stderr, "Parse error: %s\n",s);
    exit(1);
}