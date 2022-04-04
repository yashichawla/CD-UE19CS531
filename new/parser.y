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
	int size;
	int type=-1;
	void yyerror(char* s); // error handling function
	int yylex(); // declare the function performing lexical analysis
	extern int yylineno; // track the line number
	char *yytext();
	int line;
	char *val;
	char *name;
	int scope=0;
	char* e;char* f;
	int rtype=0;
%}

%token T_INT T_CHAR T_DOUBLE T_WHILE  T_INC T_DEC   T_OROR T_ANDAND T_EQCOMP T_NOTEQUAL T_GREATEREQ T_LESSEREQ T_LEFTSHIFT T_RIGHTSHIFT T_PRINTLN T_STRING  T_FLOAT T_BOOLEAN T_IF T_ELSE T_STRLITERAL T_DO T_INCLUDE T_HEADER T_MAIN T_ID T_NUM

%start START


%nonassoc T_IFX
%nonassoc T_ELSE

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
				/*
					check if symbol is in table
					if it is then error for redeclared variable
					else make entry and insert into table
					insert value coming from EXPR
					revert variables to default values:value,type
				*/
				
				if(check_symbol_table($1)==1)
				{
					printf("Variable %s already declared\n",$1);
					yyerror($1);
				}
				else
				{
					name=$1;
                    			val="~";
                    			line=yylineno;                    			
                    			symbol *argument=init_symbol(name,size,type,line,scope); //char* name, int size, int type, int lineno, int scope
                    			insert_into_table(argument);
                    			insert_value_to_name($1,$3);
					
					
				}
			}
     | T_ID 		{
				/*
                   			check if symbol is in table
                    			if it is then print error for redeclared variable
                    			else make an entry and insert into the table
                    			revert variables to default values:type
                    		*/
                    		if(check_symbol_table($1)==1)
                    		{
                    			printf("Semantic Error: Redeclared variable %s\n",$1);
                    		}
                    		else
                    		{
                    			name=$1;
                    			val="~";
                    			line=yylineno;
                    			symbol *argument=init_symbol(name,size,type,line,scope); //char* name, int size, int type, int lineno, int scope
                    			insert_into_table(argument);
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
				if(check_symbol_table($1)==1)
				{
					
					insert_value_to_name($1,$3);
				}
				else
				{
					printf("Semantic Error: Variable %s not declared\n",$1);
				}
				
				
			}
	;

EXPR : EXPR REL_OP E
       | E   { $$ = strdup($1);}
       ;
	   
E : E '+' T	{
			
			switch(type)
			{
				
				case 1: printf("Mismatch type\n");
					yyerror($1);
					break;
				case 2: sprintf($$,"%d",atoi($1)+atoi($3));
					break;
				case 3: sprintf($$,"%f",atof($1)+atof($3));
					break;
				case 4:
					sprintf($$,"%lf",strtod(strdup($1),&e)+strtod(strdup($3),&f));
					break;		
			
			}			
		}		//(str, "%d", 42);
    | E '-' T	{
			switch(type)
			{
				
				case 1: printf("Mismatch type\n");
					yyerror($1);
					break;
				case 2: sprintf($$,"%d",atoi($1)-atoi($3));
					break;
				case 3: sprintf($$,"%f",atof($1)-atof($3));
					break;
				case 4:
					sprintf($$,"%lf",strtod($1,&e)-strtod($3,&f));
					break;		
			
			}			
		}	
    | T 	{$$=strdup($1);}
    ;
	
	
T : T '*' F	{
			switch(type)
			{
				
				case 1: printf("Mismatch type\n");
					yyerror($1);
					break;
				case 2: sprintf($$,"%d",atoi($1)*atoi($3));
					break;
				case 3: sprintf($$,"%f",atof($1)*atof($3));
					break;
				case 4:
					sprintf($$,"%lf",strtod($1,&e)*strtod($3,&f));
					break;		
			
			}			
		}	
    | T '/' F	{
			switch(type)
			{
				
				case 1: printf("Mismatch type\n");
					yyerror($1);
					break;
				case 2: sprintf($$,"%d",atoi($1)/atoi($3));
					break;
				case 3: sprintf($$,"%f",atof($1)/atof($3));
					break;
				case 4:
					sprintf($$,"%lf",strtod($1,&e)/strtod($3,&f));
					break;		
			
			}			
		}	
    | F	{$$=strdup($1);}
    ;

F : '(' EXPR ')'
    | T_ID	{	$$=retrieve_val($1);
    			rtype=type_check($1);
			
    		}
    			
    | T_NUM 	{$$=strdup($1);}
    | T_STRLITERAL {$$=strdup($1);}
    ;

REL_OP :   T_LESSEREQ {$$=strdup($1);}
	   | T_GREATEREQ {$$=strdup($1);}
	   | '<'{$$=strdup($1);}
	   | '>' {$$=strdup($1);}
	   | T_EQCOMP {$$=strdup($1);}
	   | T_NOTEQUAL {$$=strdup($1);}
	   ;	


/* Grammar for main function */
MAIN : TYPE T_MAIN '(' EMPTY_LISTVAR ')' '{' {scope++;} STMT '}' {scope--;};

EMPTY_LISTVAR : LISTVAR
		|	
		;

STMT : STMT_NO_BLOCK STMT
       | BLOCK STMT
       |
       ;


STMT_NO_BLOCK : DECLR ';'
       | ASSGN ';' 
       | T_IF '(' COND ')' STMT %prec T_IFX	/* if loop*/
       | T_IF '(' COND ')' STMT T_ELSE STMT	/* if else loop */ 
       ;

BLOCK : '{' {scope++;} STMT '}' {scope--;};

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
	t=init_table();
	yyparse();
	/* display final symbol table*/
	display_symbol_table();
	return 0;

}
