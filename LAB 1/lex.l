
%{
#include<stdio.h>
#include "y.tab.h"
int yywrap();
int yylineno;
%}


letter [a-zA-Z]
digit [0-9]
id {letter}({letter}|{digit})*
strlit \".*\"
opsign [+-]?
opfrac (\.{digit})?
opexponent ([Ee][+-]?{digit}+)?
number {opsign}{digit}+{opfrac}{opexponent}
start	\/\/*
end	\*\/	

%%
^("//")(.*)	;
{start}.*{end}	;

int	return INT;
float	return FLOAT;
char	return CHAR;
bool	return BOOL;
double	return DOUBLE;
static 	return STATIC;
main	return MAIN;
if	return IF;
else	return ELSE;
for	return FOR;
while	return WHILE;
do	return DO;
break	return BREAK;
#include	return INCLUDE;
{id}	return ID;
{number}	return VNUM;
{strlit}	return STRLIT;
'<'[a-z]+\.h'>'	return HEADER;
">="	return GTE;	
"<="	return LTE;
"=="	return EQ;
"!="	return NE;
"++"	return INC;
"--"	return DEC;
"||"	return OR;
"&&"	return AND;
[' '|'\t']	;

"!"	return LNOT;
"("	return SCOMB;
")"	return ECOMB;
"["	return SSQB;
"]"	return ESQB;
"{"	return SCURB;
"}"	return ECURB;
\n	++yylineno;
.	return *yytext;


%%
int yywrap()
{
return 1;
}





