a.out: y.tab.c lex.yy.c
	gcc y.tab.c lex.yy.c

y.tab.c: yacc.y
	bison -dy yacc.y
	
lex.yy.c: lex.l
	lex lex.l

