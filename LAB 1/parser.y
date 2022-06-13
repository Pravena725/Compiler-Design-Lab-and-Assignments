%{
#include<stdio.h>
#include<stdlib.h>
#include "parser.tab.h"
int yylex();
void yyerror(char* s);
extern int yylineno;
extern char *yytext;
%}
%token INT FLOAT DOUBLE CHAR STATIC ID INCLUDE MAIN HEADER DO WHILE IF ELSE FOR BOOL BREAK INC DEC STRLIT VNUM GTE LTE EQ NE OR AND LNOT SCOMB ECOMB SSQB ESQB SCURB ECURB
%%

P : S 	{printf("Valid Declaration\n");YYACCEPT;}
  ;
S : INCLUDE HEADER S
  | STATIC S
  | MAINF S
  | DECLR ';' S
  | ASSGN ';' S
  | 
  ;
DECLR : TYPE List_Var
      ;

List_Var : List_Var ',' ID | ID 
         ;

TYPE : INT | FLOAT | CHAR | BOOL | DOUBLE 
     ;

ASSGN : ID '=' EXPR | STRLIT
      ;

EXPR : EXPR RELOP E | E | ID INC | ID DEC | LNOT ID
     ;

RELOP : GTE|LTE|EQ|NE|OR|AND
      ;

E : E'+'T|E'-'T|T
  ;

T : T'*'F|T'/'F|F
  ;


F : SCOMB EXPR ECOMB | ID | VNUM
  ;

MAINF : TYPE MAIN SCOMB Empty_ListVar ECOMB SCURB Stmt ECURB
     ;

Empty_ListVar : List_Var
	      |
              ;

Stmt : SingleStmt Stmt | Block Stmt | BREAK
     ;

SingleStmt : DECLR | ASSGN ';' | IF COND Stmt | IF COND Stmt ELSE Stmt | LOOP | DO Block WHILE COND ;
           ;

Block : SCURB Stmt ECURB
      ;

LOOP : WHILE SCOMB COND ECOMB LOOP2
      | FOR SCOMB COND ECOMB LOOP2
      ;

COND : EXPR | ASSGN 
     ;

LOOP2 : SCURB Stmt ECURB 
      |
      ;


%%
void yyerror(char* s)
{
printf("Error:%s,line number:%d,%s\n",s,yylineno,yytext);
exit(0);
}

int main()
{
yyparse();
return 0;	
}


