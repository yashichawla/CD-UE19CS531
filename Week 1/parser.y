%{
# include <stdio.h>
# include <stdlib.h>
int yylex();
void yyerror(char *s);
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
%token ID
%token NEWLINE
%token NUMBER
%token HEADER
%%

S : Program NEWLINE {printf("Valid Declaration\n");YYACCEPT;}
  ;

Program : INCLUDE '<' HEADER '>' Program
  |Declaration ';' Program
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

void yyerror(char *s) {
  printf("%s\n", s);
  exit(0);
}

int main()
{
    if (!yyparse())
        printf("Parsing successful!\n");
    else
        printf("Parsing Failed.\n");
    return 0;
}