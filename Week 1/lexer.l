%{
#include <stdio.h>
#include "y.tab.h"
void yyerror(char *s);
int yylinenumber;
%}

digit [0-9]
letter [a-zA-Z]
letterspecial [a-zA-Z_]
alnum [a-zA-Z0-9]
alnumspecial [a-zA-Z0-9_]
whitespace [ \t\r]

polarity [-+]?
fraction  (\.{digit}+)?
exponent ([Ee][+-]{digit}+)?
number {polarity}?{digit}+{fraction}{exponent}
id {letter}{alnumspecial}*
%x state
%%

\/\/(.*) ;
"/*"([^*]|\*+[^*/])*\*+"/" ;

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
main return MAIN;
return return RETURN;
void return VOID;

"++" return OPERATOR_INCREMENT;
"--" return OPERATOR_DECREMENT;
">=" return OPERATOR_GREATER_EQUAL;
"<=" return OPERATOR_LESS_EQUAL;
"==" return OPERATOR_EQUAL;
"!=" return OPERATOR_NOT_EQUAL;
"&&" return OPERATOR_AND;
"||" return OPERATOR_OR;
"+=" return OPERATOR_PLUS_EQUAL;
"-=" return OPERATOR_MINUS_EQUAL;
"*=" return OPERATOR_MULTIPLY_EQUAL;
"/=" return OPERATOR_DIVIDE_EQUAL;
"%=" return OPERATOR_MODULUS_EQUAL;

\n { ++yylinenumber; };
{whitespace} ;
{letter}{alnumspecial}*\.h return HEADER;
{id}* return ID;
{number} return NUMBER;
"'".*"'" return STRING;
. return *yytext;

%%
