%option noyywrap
%{
    /*
    * You will need to comment this line in lab5.
    */
    #define ONLY_FOR_LEX
    
    #ifdef ONLY_FOR_LEX
    #else
    #define YYSTYPE void *
    #include "parser.h"
    #endif

    #define YY_NO_UNPUT
    #define YY_NO_INPUT
    #include <string>

    #ifdef ONLY_FOR_LEX
    #include <ostream>
    #include <fstream>
    using namespace std;
    extern FILE *yyin; 
    extern FILE *yyout;

    void DEBUG_FOR_LAB4(std::string s){
        std::string DEBUG_INFO = s + "\n";
        fputs(DEBUG_INFO.c_str(), yyout);
    }
    string char2str(char* ch)
    {
        string res = "";
        for(int i=0;ch[i]!='\0';i++)
        {
            res+=ch[i];
        }
        return res;
    }
    #endif
%}




ID [[:alpha:]_][[:alpha:][:digit:]_]*
DECIMAL ([1-9][0-9]*|0)
HEXADECIMAL (0x|0X)[0-9A-Fa-f]+
OCTAL       (0)[0-7]+
FLOATNUM   ([1-9][0-9]*|0).[0-9]+

EOL (\r\n|\n|\r)
WHITE [\t ]

BLOCKCOMMENTBEGIN "/*"
BLOCKCOMMENTELEMENT .|\n
BLOCKCOMMENTEND "*/"
%x BLOCKCOMMENT


commentline "//".*

%%

"int" {
    /*
    * Questions: 
    *   Q1: Why we need to return INT in further labs?
    *   Q2: What is "INT" actually?
    */
    #ifdef ONLY_FOR_LEX
        string s = "INT\t\t\t\tint\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return INT;
    #endif
}
"float" {
    #ifdef ONLY_FOR_LEX
        string s = "FLOAT\t\t\t\tfloat\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return FLOAT;
    #endif 
}
"void" {
    #ifdef ONLY_FOR_LEX
        string s = "VOID\t\t\t\tvoid\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return VOID;
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
"switch" {
    #ifdef ONLY_FOR_LEX
        string s = "SWITCH\t\t\t\tswitch\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return SWITCH;
    #endif
}
"case" {
    #ifdef ONLY_FOR_LEX
        string s = "CASE\t\t\t\tcase\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return CASE;
    #endif
}
"for" {
    #ifdef ONLY_FOR_LEX
        string s = "FOR\t\t\t\tfor\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return FOR;
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
"do" {
    #ifdef ONLY_FOR_LEX
        string s = "DO\t\t\t\tdo\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return DO;
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
"+=" {
    #ifdef ONLY_FOR_LEX
        string s = "ADDASGN\t\t\t\t+=\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return ADDASGN;
    #endif 
}
"-=" {
    #ifdef ONLY_FOR_LEX
        string s = "MINASGN\t\t\t\t-=\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return MINASGN;
    #endif 
}
"*=" {
    #ifdef ONLY_FOR_LEX
        string s = "MULASGN\t\t\t\t*=\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return MULASGN;
    #endif 
}
"/=" {
    #ifdef ONLY_FOR_LEX
        string s = "DIVASGN\t\t\t\t/=\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return DIVASGN;
    #endif 
}


"&" {
    #ifdef ONLY_FOR_LEX
        string s = "QUO\t\t\t\t&\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return QUO;
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
"->" {
    #ifdef ONLY_FOR_LEX
        string s = "ARROW\t\t\t\t->\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return ARROW;
    #endif 
}
"++" {
    #ifdef ONLY_FOR_LEX
        string s = "SADD\t\t\t\t++\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return SADD;
    #endif 
}
"--" {
    #ifdef ONLY_FOR_LEX
        string s = "SMIN\t\t\t\t--\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return SMIN;
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
        DEBUG_FOR_LAB4("COMMA", ",");
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

{ID} {
    #ifdef ONLY_FOR_LEX
        string s = "ID\t\t\t\t"+char2str(yytext)+"\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return DECIMAL;
    #endif 
}

{DECIMAL} {
    #ifdef ONLY_FOR_LEX
        string s = "DEC\t\t\t\t"+char2str(yytext)+"\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return DECIMAL;
    #endif 
}
{HEXADECIMAL} {
    #ifdef ONLY_FOR_LEX
        string s = "HEX\t\t\t\t"+to_string(strtol(yytext,NULL,16))+"\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return HEXADECIMAL;
    #endif 
}
{OCTAL} {
    #ifdef ONLY_FOR_LEX
        string s = "OCT\t\t\t\t"+to_string(strtol(yytext,NULL,8))+"\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return OCTAL;
    #endif 
}
{FLOATNUM} {
    #ifdef ONLY_FOR_LEX
        string s = "FLT\t\t\t\t"+char2str(yytext)+"\t\t\t\t"+to_string(yylineno);
        DEBUG_FOR_LAB4(s);
    #else
        return OCTAL;
    #endif 
}

{commentline} {
    #ifdef ONLY_FOR_LEX
        ;
    #else
        return COMMENTLINE;
    #endif
}

{BLOCKCOMMENTBEGIN} {
	#ifdef ONLY_FOR_LEX
		BEGIN BLOCKCOMMENT; 
		// fprintf(yyout,"Begin a comment:\n");
	#else
		return BLOCKCOMMENTBEGIN;
	#endif
	}
<BLOCKCOMMENT>{BLOCKCOMMENTELEMENT} {
	#ifdef ONLY_FOR_LEX
		// fprintf(yyout,"%s",yytext);
	#else
		return BLOCKCOMMENTELEMENT;
	#endif
	}
<BLOCKCOMMENT>{BLOCKCOMMENTEND} {
	#ifdef ONLY_FOR_LEX
		BEGIN INITIAL;
		// fprintf(yyout,"%i",yylineno);
		// fprintf(yyout,"\nthis comment End!\n");
	#else
		return BLOCKCOMMENTEND;
	#endif
	}


{EOL} yylineno++;
{WHITE}
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
