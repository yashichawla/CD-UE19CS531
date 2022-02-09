compiler: y.tab.c lex.yy.c
	gcc y.tab.c lex.yy.c -ll

y.tab.c: yacc.y
	yacc -d yacc.y

lex.yy.c: lex.l
	lex lex.l

clean:
	rm *.yy.c y.tab.h y.tab.c a.out