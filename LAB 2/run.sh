#!/bin/bash

lex lexer.l
yacc -d parser.y -Wno
gcc -g y.tab.c lex.yy.c sym_tab.c -lfl 

./a.out<sample_input1.c>output1.txt
