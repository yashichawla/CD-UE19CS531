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
	int type = -1;
	int var_type = -1;
	char* val = '~';
	char* var_val = '~';
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
					// printf("%s %d %d %s\n", name, line, scope, val);
					symbol* s = init_symbol(name, val, size, type, line, scope);
					if (check_symbol_table(name))
					{
						printf("Error: %s already declared at line %d\n", name, line);
						yyerror($1);
					}
					else
					{
						insert_into_table(s);
						// type = -1;
						var_val = '~';
					}
			}
     | T_ID 	{
				/*
					check if symbol is in table
					if it is then print error for redeclared variable
					else make an entry and insert into the table
					revert variables to default values:type
				*/

				if (check_symbol_table($1))
				{
					printf("Error: %s already declared on line %d\n", $1, yylineno);
					yyerror($1);
				}
				else {
					name = $1;
					val = "~";
					line = yylineno;
					// printf("%s %d %d %s\n", name, line, scope, val);
					symbol* s = init_symbol(name, val, size, type, line, scope);
					insert_into_table(s);
					// type = -1;
				}
			}	 

//assign type here to be returned to the declaration grammar
TYPE : T_INT {size=2; type=2;}
       | T_FLOAT {size=4; type=3;}
       | T_DOUBLE {size=8; type=4;}
       | T_CHAR {size=1; type=1;}
       ;
    
/* Grammar for assignment */   
ASSGN : T_ID '=' EXPR 	{
					name = $1;
					val = $3;
					line = yylineno;
					type = get_symbol_table_type(name);
					printf("name = %s line = %d scope = %d value = %s type = %d\n", name, line, scope, val, type);
					symbol* s = init_symbol(name, val, size, type, line, scope);
					if (check_symbol_table(name))
					{
						insert_value_to_name(name, val, type);
						// var_type = type;
						// type = -1;
					}
					else
					{
						printf("Error: %s not declared on line %d\n", name, line);
						yyerror($1);
					}
			}
	;

EXPR : EXPR REL_OP E
       | E { var_val = $1; }
       ;
	   
E : E '+' T
		{
			if (var_type == 2)
				{ sprintf($$, "%d", (atoi($1) + atoi($3))); }
			else if (var_type == 3)
				{ sprintf($$, "%lf", (atof($1) + atof($3))); }
			else
			{
				printf("Yashi is a cutie<3\nCharacter type used in arithmetic\n");
				yyerror($$);
				$$ = "~";
			}
		}
    | E '-' T 
		{
			if (var_type == 2)
				{ sprintf($$, "%d", (atoi($1) - atoi($3))); }
			else if (var_type == 3)
				{ sprintf($$, "%lf", (atof($1) - atof($3))); }
			else
			{
				printf("Yashi is a hottie <3\nCharacter type used in arithmetic\n");
				yyerror($$);
				$$ = "~";
			}
		}
    | T
    ;
	
	
T : T '*' F
    | T '/' F
    | F { $$ = $1; }
    ;

F : '(' EXPR ')'
    | T_ID 
			{
				name = $1;
				if (check_symbol_table(name))
				{
					var_val = get_symbol_table_value(name);
					if (var_val != NULL && var_val != '~')
					{
						printf("Error: %s not initialised on line %d\n", name, yylineno);
						yyerror($1);
					}
					else
					{
						$$=strdup(var_val);
						var_type = get_variable_type(var_val);
						if (var_type != type && type != -1)
						{
							printf("Error: %s not of type %s on line %d\n", name, type_to_string(type), yylineno);
							yyerror($1);
						}
					}
				}
				else
				{
					printf("Error: %s not declared on line %d\n", name, yylineno);
					yyerror($1);
				}
			}
    | T_NUM 
		{
			$$ = strdup($1);
			var_type = get_variable_type($1);
			printf("val = %s type = %d var_type = %d\n", $1, type, var_type);
			// if (var_type != type && type != -1)
			// {
			// 	printf("Error: %s not of type %s on line %d\n", $1, type_to_string(type), yylineno);
			// 	yyerror($1);
			// }
		}

    | T_STRLITERAL 
		{
			$$ = strdup($1);
			var_type = 1;
			if (var_type != type)
			{
				printf("Error: %s not of type %s on line %d\n", $1, type_to_string(type), yylineno);
				yyerror($1);
			}
		}
    ;

REL_OP :   T_LESSEREQ
	   | T_GREATEREQ
	   | '<' 
	   | '>' 
	   | T_EQCOMP
	   | T_NOTEQUAL
	   ;	


/* Grammar for main function */
MAIN : TYPE T_MAIN '(' EMPTY_LISTVAR ')' '{' { scope +=1; } STMT '}' { scope -=1; } ;

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

BLOCK : '{' { scope += 1; }  STMT  '}' { scope -= 1; } ;

COND : EXPR 
       | ASSGN
       ;


%%


/* error handling function */
void yyerror(char* s)
{
	printf("Error :%s at %d \n", s, yylineno);
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
