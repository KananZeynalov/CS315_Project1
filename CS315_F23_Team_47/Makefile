runnable.out:y.tab.c lex.yy.c
	gcc y.tab.c
y.tab.c: CS315_F23_Team_47.y
	yacc CS315_F23_Team_47.y
lex.yy.c: CS315_F23_Team_47.l
	lex CS315_F23_Team_47.l
clean:
	rm -f lex.yy.c a.out y.tab.c
