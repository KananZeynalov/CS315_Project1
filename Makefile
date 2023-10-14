runnable.out:lex.yy.c
	gcc -o GojoLink.out lex.yy.c
lex.yy.c:
	lex GojoLink.l
clean:
	rm -f lex.yy.c GojoLink.out
