%{
#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>
#ifndef YYSTYPE
#define YYSTYPE char*
#endif
char idStr[50];
char numStr[50];
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
%token ID


%left ADD SUB
%left MUL DIV
%right UMINUS

%%

lines   :   lines expr ';' {printf("%s\n",$2);}
        |   lines ';'
        |   
        ;

expr    :   expr ADD expr   {$$ =(char*)malloc(50*sizeof(char)); strcpy($$,$1);
                            strcat($$,$3); strcat($$,"+ ");}
        |   expr SUB expr   {$$ = (char*)malloc(50*sizeof(char)); strcpy($$,$1);
                            strcat($$,$3); strcat($$,"- ");}
        |   expr MUL expr   {$$ = (char*)malloc(50*sizeof(char)); strcpy($$,$1);
                            strcat($$,$3); strcat($$,"* ");}
        |   expr DIV expr   {$$ = (char*)malloc(50*sizeof(char)); strcpy($$,$1);
                            strcat($$,$3); strcat($$,"/ ");}
        |   LEFT_BR expr RIGHT_BR   {$$ =(char*)malloc(50*sizeof(char)); strcpy($$,$2);}
        |   SUB expr %prec UMINUS   {$$ =(char*)malloc(50*sizeof(char)); strcpy($$,$2);
                            strcat($$,"- ");}
        |   NUMBER          {$$=(char*)malloc(50*sizeof(char));
                            strcpy($$,$1);strcat($$," ");}
        |    ID              {$$=(char*)malloc(50*sizeof(char));
                            strcpy($$,$1);strcat($$," ");}                
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
        if(t==' ' || t=='\t' || t=='\n')
        {

        }else if(t>='0'&& t<='9'){
            int ti=0;
            while(t>='0'&& t<='9'){
                numStr[ti] = t;
                t = getchar();
                ti++;
            }
            numStr[ti]='\0';
            yylval = numStr;
            ungetc(t,stdin);
            return NUMBER;
        }else if((t>='a'&&t<='z')||(t>='A'&&t<='Z')||(t=='_')){
            int ti=0;
            while((t>='a'&&t<='z')||(t>='A'&&t<='Z')||(t=='_')||(t>='0'&& t<='9')){
                idStr[ti] = t;
                ti++;
                t = getchar();
            }
            idStr[ti]='\0';
            yylval=idStr;
            ungetc(t,stdin);
            return ID;
        }
        else if(t=='+')
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