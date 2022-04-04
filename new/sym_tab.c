#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "sym_tab.h"



/*
typedef struct symbol		//data structure of items in the list
{
	char* name;			//identifier name
	int len;			//length of identifier name
	int type;			//identifier type
	char* val;			//value of the identifier
	int line;			//line number
	int scope;			//scope
	struct symbol* next;
}symbol;

typedef struct table		//keeps track of the start of the list
{
	symbol* head;
}table;

static table* t;
*/





table* init_table()	
{
	/*
        allocate space for table pointer structure eg (t_name)* t
        initialise head variable eg t->head
        return structure
    	*/
    	table* newTable = (table*)malloc(sizeof(table));
    	newTable->head = NULL;
    	return newTable;    	
    	
}

symbol* init_symbol(char* name, int size, int type, int lineno, int scope) //allocates space for items in the list
{
	/*
        allocate space for entry pointer structure eg (s_name)* s
        initialise all struct variables(name, value, type, scope, length, line number)
        return structure
    	*/
    	
    	symbol* newSymbol = (symbol*)malloc(sizeof(symbol));
    	newSymbol->name=name;
    	newSymbol->len=size;
    	newSymbol->type=type;
    	newSymbol->scope=scope;
    	newSymbol->val="~";
    	newSymbol->line=lineno;
    	newSymbol->next=NULL;
    	return newSymbol;
    	
}

void insert_into_table(symbol* arguments)/* 
 arguments can be the structure s_name already allocated before this function call
 or the variables to be sent to allocate_space_for_table_entry for initialisation        
*/
{
    /*
        check if table is empty or not using the struct table pointer
        else traverse to the end of the table and insert the entry
    */
    
    if(!t->head)
    {
    	t->head=arguments;
    	return;
    }
    
    symbol* temp=t->head;
    while(temp->next)
    {
    	temp=temp->next;
    }
    temp->next=arguments;
    return;
}

int check_symbol_table(char* name) //return a value like integer for checking
{
    /*
        check if table is empty and return a value like 0
        else traverse the table
        if entry is found return a value like 1
        if not return a value like 0
    */
    if(!t->head)
    {    
    	return 0;
    }
    
    symbol* temp=t->head;
    while(temp)
    {
    	if(strcmp(name,temp->name)==0)
    	{
    		return 1;
    	}
    	temp=temp->next;
    }
    return 0;
}

char* insert_value_to_name(char* name,char* value)
{
    /*
        if value is default value return back
        check if table is empty
        else traverse the table and find the name
        insert value into the entry structure
    */
    symbol* temp=t->head;
    while(temp)
    {
    	if(strcmp(name,temp->name)==0)
    	{
    		temp->val=value;
    		return value;
    	}
    	temp=temp->next;
    }
    
    return value;
}

void display_symbol_table()
{
    /*
        traverse through table and print every entry
        with its struct variables
    */
    
    symbol* temp=t->head;
    printf("\n--------Symbol Table-------\n");
    while(temp)
    {
    	printf("Name= %s  Value= %s   Type= %d   Len= %d   Line= %d   Scope= %d\n",temp->name,temp->val,temp->type,temp->len,temp->line,temp->scope);
    	temp=temp->next;
    }
    return;
}

char* retrieve_val(char* name)
{
	symbol* temp=t->head;
	while(temp)
	{
		if(strcmp(temp->name,name)==0)
		{
			return temp->val;
		}
		temp=temp->next;
	}
	return name;
}

int retrieve_type(char* name)
{
	symbol* temp=t->head;
	while(temp)
	{
		if(strcmp(temp->name,name)==0)
		{
			return temp->type;
		}
		temp=temp->next;
	}
	return -1;
}

int type_check(char* value)
{
	
	for(char* c=value;*c!='\0';c++)
	{
        
		if(isalpha(*c))
		{		    
		    return 1;
		}
		else if(*c == '.')
		{
		    printf("Float");
		    return 3;
		}        
   	 }
    
	return 2;	
}


int Getsize(int type)
{
	switch(type)
	{
		case 1: return 1;
		case 2: return 2;
		case 3: return 4;
		case 4: return 8;
	}
}



