%{
# include <stdio.h>
# include <stdlib.h>
int yylex();
void yyerror(char *s);
extern int yylinenumber;
extern char *yytext;
%}

%token INT
%token FLOAT
%token CHAR
%token DOUBLE
%token WHILE
%token IF
%token ELSE
%token FOR
%token DO
%token BREAK
%token CONTINUE
%token INCLUDE
%token MAIN
%token RETURN
%token VOID
%token OPERATOR_INCREMENT
%token OPERATOR_DECREMENT
%token OPERATOR_GREATER_EQUAL
%token OPERATOR_LESS_EQUAL
%token OPERATOR_EQUAL
%token OPERATOR_NOT_EQUAL
%token OPERATOR_AND
%token OPERATOR_OR
%token OPERATOR_PLUS_EQUAL
%token OPERATOR_MINUS_EQUAL
%token OPERATOR_MULTIPLY_EQUAL
%token OPERATOR_DIVIDE_EQUAL
%token OPERATOR_MODULUS_EQUAL
%token HEADER
%token ID
%token NUMBER

%%

S : Program { printf("Valid Declaration\n");YYACCEPT; }
  ;

Program : INCLUDE '<' HEADER '>' Program
  | Declaration ';' Program
  | 
  ;
Declaration : TYPE ListOfDeclarations 
  ;

TYPE : INT
     | FLOAT
     | CHAR
     | DOUBLE
     ;

ListOfDeclarations : ListOfDeclarations ',' ID
  | ID
  ;

%%

void yyerror(char *line)
{
  printf("Error near token %s on line %d: %s\n", yytext, yylinenumber+1, line);
  exit(0);
}

int main()
{
    if (!yyparse())
        printf("Parsing successful!\n");
    else
        printf("Parsing Failed :(\n");
    return 0;
}