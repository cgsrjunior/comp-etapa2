#
# UFRGS - Compiladores - Etapa 1
# Cleiber Rodrigues e Cintia Valente
# Cartões 00270139
#
# Makefile for single compiler call

etapa2: y.tab.o lex.yy.o  main.o
	gcc -o etapa2 lex.yy.o y.tab.o main.o -lfl
main.o: main.c
	gcc -c main.c
y.tab.o: y.tab.c
	gcc -c y.tab.c -Wall
y.tab.c: parser.y
	bison -y -d -v parser.y
lex.yy.o: lex.yy.c
	gcc -c lex.yy.c
lex.yy.c: scanner.l
	flex --header-file=lex.yy.h scanner.l 
clean:
	rm *.o lex.yy.c lex.yy.h y.tab.c y.tab.h parser.tab.c parser.tab.h etapa2