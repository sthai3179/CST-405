%{

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%token TYPE
%token ID
%token SEMICOLON
%token EQ
%token COMMA
%token NUMBER
%token OPERATOR
%token UOPERATOR
%token LEFTPAR
%token RIGHTPAR
%token LEFTBRACK
%token RIGHTBRACK
%token LEFTCURL
%token RIGHTCURL
%token STATEMENT

%start Program

%%

Program: VarDeclList FuncDeclList
;

VarDeclList:
	| VarDecl VarDeclList
;

FuncDeclList:
	| Expr FuncDeclList
;

/*ParamDeclList:
	| ParamDeclListTail
;

ParamDeclListTail:
ParamDecl
;
*/

ExprList:
	| ExprListTail
;


ExprListTail:
	Expr 
	| Expr COMMA ExprListTail
;

/*StmtList WIP*/
StmtList:
Stmt | Stmt StmtList
;

VarDecl:	TYPE ID SEMICOLON	{ printf("\n RECOGNIZED RULE: Variable declaration %d\n", $2); }
		| TYPE ID LEFTBRACK NUMBER RIGHTBRACK SEMICOLON {printf("\n RECOGNIZED RULE: Variable Declaration %d\n", $2);}
;

Expr:	
	ID EQ ID SEMICOLON	{ printf("\n RECOGNIZED RULE: ID EQ ID SEMICOLON\n"); }
	| ID EQ NUMBER SEMICOLON	{ printf("\n RECOGNIZED RULE: ID EQ ID SEMICOLON\n"); }
	| ID BinOp ID SEMICOLON{ printf("\n RECOGNIZED RULE: ID BinOp ID\n"); }
	| Expr BinOp Expr SEMICOLON{ printf("\n RECOGNIZED RULE: Expr BinOp Expr\n"); }
	| UnaryOp Expr { printf("\n RECOGNIZED RULE: UnaryOp Expr\n"); }
	| ID EQ Expr 	{ printf("\n RECOGNIZED RULE: ID EQ Expr\n"); }
	| ID LEFTBRACK Expr RIGHTBRACK EQ Expr { printf("\n RECOGNIZED RULE: ID [Expr] EQ Expr\n");} 
	| TYPE ID LEFTBRACK RIGHTBRACK { printf("\n RECOGNIZED RULE: Parameter Declaration\n"); }
	| TYPE ID { printf("\n RECOGNIZED RULE: Parameter Declaration\n"); }
	
;

/*Stmt WIP*/
Stmt:
	/*SEMICOLON {printf("RECOGNIZED RULE: Statement");}
	|Expr SEMICOLON {printf("RECOGNIZED RULE: Statement");}*/
	|STATEMENT Expr SEMICOLON {printf("RECOGNIZED RULE: Statement");}
	|STATEMENT SEMICOLON {printf("RECOGNIZED RULE: Statement");}
	|Block {printf("RECOGNIZED RULE: Statement");}
;

/*ParamDecl WIP*/
/*ParamDecl: TYPE ID LEFTBRACK RIGHTBRACK	{printf("\nRECOGNIZED RULE: Parameter Decl %d\n", $2);}
;*/

BinOp: 
	OPERATOR 
;

/*UnaryOp- Only ! Works, "-" overlaps with BinOp*/
UnaryOp:
	UOPERATOR
;

/*Block WIP*/
Block:
	LEFTCURL VarDeclList StmtList RIGHTCURL
;





%%

int main(int argc, char**argv)
{
	printf("Compiler started. \n\n");

	if (argc > 1){
	  if(!(yyin = fopen(argv[1], "r")))
          {
		perror(argv[1]);
		return(1);
	  }
	}
	yyparse();
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}
