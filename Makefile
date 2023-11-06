runnable.out:y.tab.c lex.yy.c
	gcc -o GojoLink.out y.tab.c
y.tab.c: tuna.y
	yacc tuna.y
lex.yy.c: GojoLink.l
	lex GojoLink.l
clean:
	rm -f lex.yy.c GojoLink.out y.tab.c
