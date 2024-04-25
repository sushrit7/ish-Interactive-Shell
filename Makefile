CC = gcc

OBJS = lex.yy.o y.tab.o main.o

ish: $(OBJS)
	gcc -g -o $@ $(OBJS) -ll -lfl

lex.yy.c: ish.l
	lex ish.l

lex.yy.h: lex.yy.c
	touch lex.yy.h

lex.yy.o : lex.yy.c lex.yy.h y.tab.h
	gcc -c -g lex.yy.c

y.tab.c y.tab.h: ish.y
	yacc -d -v ish.y

y.tab.o : y.tab.c
	gcc -c -g y.tab.c

main.o: main.c lex.yy.h y.tab.h
	gcc -c -g main.c

clean:
	rm -f lex.yy.c y.tab.c y.tab.h *.o ish y.output






















