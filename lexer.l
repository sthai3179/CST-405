%{    
	int lines = 0;
	int chars = 0;
%}


%%

"int"	{printf("%s: TYPE\n", yytext);}

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
