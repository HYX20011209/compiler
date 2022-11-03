%option noyywrap
%{
    /*
    * You will need to comment this line in lab5.
    */
    // #define ONLY_FOR_LEX
    
    #ifdef ONLY_FOR_LEX
    #else
    // #define YYSTYPE void *
    
    #endif

    #define YY_NO_UNPUT
    #define YY_NO_INPUT
    #include <string>
    #include "parser.h"
    
    #include <ostream>
    #include <fstream>
    using namespace std;
    extern FILE *yyin; 
    extern FILE *yyout;
    #ifdef ONLY_FOR_LEX
    void DEBUG_FOR_LAB4(std::string s){
        std::string DEBUG_INFO = s + "\n";
        fputs(DEBUG_INFO.c_str(), yyout);
    }
    #endif
    string char2str(char* ch)
    {
        string res = "";
        for(int i=0;ch[i]!='\0';i++)
        {
            res+=ch[i];
        }
        return res;
    }
    
%}



INTEGER ([1-9][0-9]*|0)
ID [[:alpha:]_][[:alpha:][:digit:]_]*
FLOATNUM   ([1-9][0-9]*|0).[0-9]+

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
        string s = "INT\t\t\t\tint\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return INT_TYPE;
    #endif
}
"float" {
    #ifdef ONLY_FOR_LEX
        string s = "FLOAT\t\t\t\tfloat\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return FLOAT_TYPE;
    #endif 
}
"void" {
    #ifdef ONLY_FOR_LEX
        string s = "VOID\t\t\t\tvoid\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return VOID_TYPE;
    #endif 
}
"const" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("CONST\t\t\t\tconst");
    #else
        return CONST;
    #endif 

}
"if" {
    #ifdef ONLY_FOR_LEX
        string s = "IF\t\t\t\tif\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return IF;
    #endif
};
"else" {
    #ifdef ONLY_FOR_LEX
        string s = "ELSE\t\t\t\telse\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return ELSE;
    #endif
};
"return" {
    #ifdef ONLY_FOR_LEX
        string s = "RETURN\t\t\t\treturn\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return RETURN;
    #endif
}


"while" {
    #ifdef ONLY_FOR_LEX
        string s = "WHILE\t\t\t\twhile\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return WHILE;
    #endif
}

"break" {
    #ifdef ONLY_FOR_LEX
        string s = "BREAK\t\t\t\tbreak\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return BREAK;
    #endif
}
"continue" {
    #ifdef ONLY_FOR_LEX
        string s = "CONTINUE\t\t\t\tcontinue\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return CONTINUE;
    #endif
}



"=" {
    #ifdef ONLY_FOR_LEX
        string s = "ASSIGN\t\t\t\t=\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return ASSIGN;
    #endif
}




"!" {
    #ifdef ONLY_FOR_LEX
        string s = "NOT\t\t\t\t!\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return NOT;
    #endif 
}

"<=" {
    #ifdef ONLY_FOR_LEX
        string s = "LESSEQ\t\t\t\t<=\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return LESSEQ;
    #endif 
}
">=" {
    #ifdef ONLY_FOR_LEX
        string s = "GREATEQ\t\t\t\t>=\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return GREATEQ;
    #endif 
}
">" {
    #ifdef ONLY_FOR_LEX
        string s = "GREAT\t\t\t\t>\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return GREAT;
    #endif 
}
"<" {
    #ifdef ONLY_FOR_LEX
        string s = "LESS\t\t\t\t<\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return LESS;
    #endif 
}
"==" {
    #ifdef ONLY_FOR_LEX
        string s = "EQUAL\t\t\t\t==\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return EQUAL;
    #endif 
}
"!=" {
    #ifdef ONLY_FOR_LEX
        string s = "NEQUAL\t\t\t\t!=\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return NEQUAL;
    #endif 
}


"&&" {
    #ifdef ONLY_FOR_LEX
        string s = "AND\t\t\t\t&&\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return AND;
    #endif 
}
"||" {
    #ifdef ONLY_FOR_LEX
        string s = "OR\t\t\t\t||\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return OR;
    #endif 
}


"+" {
    #ifdef ONLY_FOR_LEX
        string s = "ADD\t\t\t\t+\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return ADD;
    #endif
}
"-" {
    #ifdef ONLY_FOR_LEX
        string s = "SUB\t\t\t\t-\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return SUB;
    #endif 
}
"*" {
    #ifdef ONLY_FOR_LEX
        string s = "MUL\t\t\t\t*\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return MUL;
    #endif 
}
"/" {
    #ifdef ONLY_FOR_LEX
        string s = "DIV\t\t\t\t/\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return DIV;
    #endif 
}
";" {
    #ifdef ONLY_FOR_LEX
        string s = "SEMICOLON\t\t\t\t;\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return SEMICOLON;
    #endif
}
"," {
    #ifdef ONLY_FOR_LEX
        string s = "COMMA\t\t\t\t,\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return COMMA;
    #endif
}
"(" {
    #ifdef ONLY_FOR_LEX
        string s = "LPAREN\t\t\t\t(\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return LPAREN;
    #endif
}
")" {
    #ifdef ONLY_FOR_LEX
        string s = "RPAREN\t\t\t\t)\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
    return RPAREN;
    #endif
}
"{" {
    #ifdef ONLY_FOR_LEX
        string s = "LBRACE\t\t\t\t{\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return LBRACE;
    #endif
}
"}" {
    #ifdef ONLY_FOR_LEX
        string s = "RBRACE\t\t\t\t}\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return RBRACE;
    #endif
}
"[" {
    #ifdef ONLY_FOR_LEX
        string s = "LBRACK\t\t\t\t)\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return LBRACK;
    #endif
}
"]" {
    #ifdef ONLY_FOR_LEX
        string s = "RBRACK\t\t\t\t)\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return RBRACK;
    #endif
}

{INTEGER} {
    #ifdef ONLY_FOR_LEX
        string s = "INT\t\t\t\t"+char2str(yytext)+"\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        yylval.ftype = atoi(yytext);
        return INTEGER;
    #endif 
}

{ID} {
    #ifdef ONLY_FOR_LEX
        string s = "ID\t\t\t\t"+char2str(yytext)+"\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        char* lexeme = new char[strlen(yytext) + 1];
        strcpy(lexeme, yytext);
        yylval.strtype = lexeme;
        return ID;
    #endif 
}







{FLOATNUM} {
    #ifdef ONLY_FOR_LEX
        string s = "FLT\t\t\t\t"+char2str(yytext)+"\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        yylval.ftype = atoi(yytext);
        return FLOATNUM;
    #endif 
}




{EOL} yylineno++;
{WHITE}
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
    string caption = "Type\t\t\tAttributes\t\t\tValues";
    DEBUG_FOR_LAB4(caption);
    yylex();
    return 0;
}
#endif
