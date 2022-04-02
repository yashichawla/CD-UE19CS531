%{
	#include "sym_tab.c"
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#define YYSTYPE char*
	/*
		declare variables to help you keep track or store properties
		scope can be default value for this lab(implementation in the next lab)
	*/
	void yyerror(char* s); // error handling function
	int yylex(); // declare the function performing lexical analysis
	extern int yylineno; // track the line number
	char *yytext();
	char* name;
	int size;
	int type;
	char* val;
	int line;
	int scope;

%}

%token T_INT T_CHAR T_DOUBLE T_WHILE  T_INC T_DEC   T_OROR T_ANDAND T_EQCOMP T_NOTEQUAL T_GREATEREQ T_LESSEREQ T_LEFTSHIFT T_RIGHTSHIFT T_PRINTLN T_STRING  T_FLOAT T_BOOLEAN T_IF T_ELSE T_STRLITERAL T_DO T_INCLUDE T_HEADER T_MAIN T_ID T_NUM

%start START


%%
START : PROG { printf("Valid syntax\n"); YYACCEPT; }	
        ;	
	  
PROG :  MAIN PROG				
	|DECLR ';' PROG 				
	| ASSGN ';' PROG 			
	| 					
	;
	 

DECLR : TYPE LISTVAR 
	;	


LISTVAR : LISTVAR ',' VAR 
	  | VAR
	  ;

VAR: T_ID '=' EXPR 	{
					name = $1;
					val = $3;
					line = yylineno;
					//scope = 1;
					printf("%s %d %d %s\n", name, line, scope, val);
					symbol* s = init_symbol(name, val, size, type, line, scope);
					if (check_symbol_table(name))
					{
						insert_value_to_name(name, val, type);
					}
					else
					{
						insert_into_table(s);
					}
			}
     | T_ID 	{
				/*
					check if symbol is in table
					if it is then print error for redeclared variable
					else make an entry and insert into the table
					revert variables to default values:type
				*/

				if (check_symbol_table($1)) {
					yyerror("Redeclared variable");
				}
				else {
					name = $1;
					val = "~";
					line = yylineno;
					//scope = 1;
					// printf("%s %d %d %s\n", name, line, scope, val);
					symbol* s = init_symbol(name, val, size, type, line, scope);
					insert_into_table(s);
					// if (check_symbol_table(name))
					// {
					// 	insert_value_to_name(name, val, type);
					// }
					// else
					// {
					// 	insert_into_table(s);
					// }
				}
			}	 

//assign type here to be returned to the declaration grammar
TYPE : T_INT {size=2;type=2;}
       | T_FLOAT {size=4;type=3;}
       | T_DOUBLE {size=8;type=4;}
       | T_CHAR {size=1;type=1;}
       ;
    
/* Grammar for assignment */   
ASSGN : T_ID '=' EXPR 	{
					name = $1;
					val = $3;
					line = yylineno;
					//scope = 1;
					printf("%s %d %d %s\n", name, line, scope, val);
					symbol* s = init_symbol(name, val, size, type, line, scope);
					if (check_symbol_table(name))
					{
						insert_value_to_name(name, val, type);
					}
					else
					{
						insert_into_table(s);
					}
			}
	;

EXPR : EXPR REL_OP E
       | E 
       ;
	   
E : E '+' T
    | E '-' T 
    | T { $$=$1 }
    ;
	
	
T : T '*' F
    | T '/' F
    | F
    ;

F : '(' EXPR ')'
    | T_ID
    | T_NUM 
    | T_STRLITERAL 
    ;

REL_OP :   T_LESSEREQ
	   | T_GREATEREQ
	   | '<' 
	   | '>' 
	   | T_EQCOMP
	   | T_NOTEQUAL
	   ;	


/* Grammar for main function */
MAIN : TYPE T_MAIN '(' EMPTY_LISTVAR ')' { scope +=1; } '{' STMT '}';

EMPTY_LISTVAR : LISTVAR
		|	
		;

STMT : STMT_NO_BLOCK STMT
       | BLOCK STMT 
       |
       ;


STMT_NO_BLOCK : DECLR ';'
       | ASSGN ';' 
       ;

BLOCK : { scope += 1; } '{'  STMT  '}' { scope -= 1; } ;

COND : EXPR 
       | ASSGN
       ;


%%


/* error handling function */
void yyerror(char* s)
{
	printf("Error :%s at %d \n",s,yylineno);
}


int main(int argc, char* argv[])
{
	/* initialise table here */
	t = init_table();
	yyparse();
	/* display final symbol table*/
	display_symbol_table();
	return 0;
}
