%{
#include <stdio.h>
#include "y.tab.h"
void yyerror(char *s);
%}

digit [0-9]
letter [a-zA-Z]
alnum [a-zA-Z0-9]
alnumspecial [a-zA-Z0-9_]
whitespace [ \t]

%%

int return INT;
float return FLOAT;
char return CHAR;
double return DOUBLE;
while return WHILE;
if return IF;
else return ELSE;
for return FOR;
do return DO;
break return BREAK;
continue return CONTINUE;
#include return INCLUDE;
{letter}*\.h return HEADER;
main return MAIN;
{letter}{alnumspecial}* return ID;
\n return NEWLINE;
{whitespace} ;
{digit}+ return NUMBER;

. return *yytext;

%%
