%{    
	int lines = 0;
	int words = 0;
	int chars = 0;
%}


%%

"int"|"char"	{ words++, chars += strlen(yytext);
			printf("%s : TYPE\n", yytext); }
"write"|"return" {words++; chars += strlen(yytext);
			printf("%s : KEYWORD\n", yytext);}
[a-zA-Z]+ {words++, chars += strlen(yytext);
			printf("%s : IDENTIFIER\n", yytext);}
[1-9][0-9]* {words++; chars += strlen(yytext);
			printf("%s : NUMBER\n", yytext);}
[0][1-9] {words++; chars += strlen(yytext);
			printf("%s : Possible illegal number format.\nI think you meant to type a number and inadverdetently typed a ZERO on the first line %d char %d\n", yytext, lines, chars);}
"+"|"-"|"*"|"/" {words++; chars += strlen(yytext);
			printf("%s : OPERATOR\n", yytext);}

"("	{chars++; printf("%s : LEFTPAR\n", yytext);}
")"	{chars++; printf("%s : RIGHTPAR\n", yytext);}
"{"	{chars++; printf("%s : LEFTBRA\n", yytext);}
"}"	{chars++; printf("%s : RIGHTBRA\n", yytext);}
";"	{ printf("%s : SEMICOLON\n", yytext); }
"="	{ printf("%s : EQUAL\n", yytext); }

\n    ++lines; ++chars;
.     ++chars;

%%

int main(int argc, char **argv )
{
	// printf("Test print\n");    
	if ( argc > 1 )
	{
		if(!(yyin = fopen(argv[1], "r")))
		{
			perror(argv[1]);
			return(1);
		}
	}

	yylex();
	printf("Number of Lines: %d \nNumber of Characters: %d\n", lines, chars);
	
	return 0;
}


