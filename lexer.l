%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "parser.tab.h"
int words = 0;
int chars = 0;
int lines = 0;

%}

%%

"int"	{words++, chars += strlen(yytext);
			printf("%s : TYPE\n", yytext);
			return TYPE;
		}

"char"	{words++, chars += strlen(yytext);
			printf("%s : TYPE\n", yytext);
			return TYPE;
		}

[a-zA-Z]+	{words++; chars += strlen(yytext);
			printf("%s : IDENTIFIER\n",yytext);
			return ID;
		}
[1-9][0-9]*	{words++; chars += strlen(yytext);
			printf("%s : NUMBER\n",yytext);
			return NUMBER;
		}
";"		{chars++;
		  printf("%s : SEMICOLON\n", yytext);
		  return SEMICOLON;
		}
		

"="		{chars++;
		  printf("%s : EQ\n", yytext);
		  return EQ;
		}

","		{chars++;
		  printf("%s : COMMA\n", yytext);
		  return COMMA;
		}
[0][1-9] {words++; chars += strlen(yytext);
			printf("%s : Possible illegal number format.\nI think you meant to type a number and inadverdetently typed a ZERO on the first line %d char %d\n", yytext, lines, chars);}

"+"|"-"|"*"|"/"|"=="|"!="|"<"|"<="|">"|">="|"&&"|"||" {words++; chars += strlen(yytext);
			printf("%s : OPERATOR\n", yytext);
			return OPERATOR;
}

"(" {words++; chars += strlen(yytext);
			printf("%s : LEFTPAR\n", yytext);
			return LEFTPAR;}
")" {words++; chars += strlen(yytext);
			printf("%s : RIGHTPAR\n", yytext);
			return RIGHTPAR;}

"[" {words++; chars += strlen(yytext);
			printf("%s : LEFTBRACK\n", yytext);
			return LEFTBRACK;}
"]" {words++; chars += strlen(yytext);
			printf("%s : RIGHTBRACK\n", yytext);
			return RIGHTBRACK;}

"{" {words++; chars += strlen(yytext);
			printf("%s : LEFTCURL\n", yytext);
			return LEFTCURL;}
"}" {words++; chars += strlen(yytext);
			printf("%s : RIGHTCURL\n", yytext);
			return RIGHTCURL;}


"!" {words++; chars += strlen(yytext);
			printf("%s : UOPERATOR\n", yytext);
			return UOPERATOR;}

\n		{lines++; chars=0;}
[ \t]	{chars++;}
.		{chars++;
                	printf("%s : Unrecognized symbol at line %d char %d\n", yytext,lines,chars);
		}

"return"|"read id"|"write"|"writeln"|"break"|"if"|"else"|"while" {words++, chars += strlen(yytext);
			printf("%s : STATEMENT\n", yytext);
			return STATEMENT;
		}

%%
