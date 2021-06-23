lexer: lexer.l
	flex lexer.l
	gcc -o Lexer lex.yy.c -ll
	./Lexer program.gcupl
	
clean:
	rm -f Lexer
	rm -f lex.yy.c
	rm -f a.out
	ls -l

