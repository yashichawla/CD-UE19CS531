#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sym_tab.h"

table *init_table()
{
    /*
        allocate space for table pointer structure eg (t_name)* t
        initialise head variable eg t->head
        return structure
    */
    table *t = (table *)malloc(sizeof(table));
    t->head = NULL;
    return t;
}

symbol *init_symbol(char *name, char*value, int size, int type, int lineno, int scope) // allocates space for items in the list
{
    /*
        allocate space for entry pointer structure eg (s_name)* s
        initialise all struct variables(name, value, type, scope, length, line number)
        return structure
    */
    symbol *s = (symbol *)malloc(sizeof(symbol));
    s->name = name;
    s->size = size;
    s->type = type;
    s->val = value;
    s->line = lineno;
    s->scope = scope;
    s->next = NULL;
    return s;
}

int insert_into_table(symbol *s)
/*
 arguments can be the structure s_name already allocated before this function call
 or the variables to be sent to allocate_space_for_table_entry for initialisation
*/

/*
        check if table is empty or not using the struct table pointer
        else traverse to the end of the table and insert the entry
*/
{
    if (t->head == NULL)
    {
        t->head = s;
    }
    else
    {
        symbol *temp = t->head;
        while (temp->next != NULL)
        {
            temp = temp->next;
        }
        temp->next = s;
    }
    return 1;
}

int check_symbol_table(char *name) // return a value like integer for checking
{
    /*
        check if table is empty and return a value like 0
        else traverse the table
        if entry is found return a value like 1
        if not return a value like 0
    */

    symbol *temp = t->head;
    if (temp == NULL)
    {
        return 0;
    }
    while (temp != NULL)
    {
        if (strcmp(temp->name, name) == 0)
        {
            return 1;
        }
        temp = temp->next;
    }
    return 0;
}

int insert_value_to_name(char *name, char *value, int type)
{
    /*
        if value is default value return back
        check if table is empty
        else traverse the table and find the name
        insert value into the entry structure
    */

    symbol *temp = t->head;
    if (strcmp(value, "~") == 0)
    {
        return 0;
    }
    if (temp == NULL)
    {
        return 0;
    }
    while (temp != NULL)
    {
        if (strcmp(temp->name, name) == 0)
        {
            temp->val = value;
            temp->type = type;
            return 1;
        }
        temp = temp->next;
    }
    return 0;
}

void display_symbol_table()
{
    /*
        traverse through table and print every entry
        with its struct variables
    */

    printf("Name\tSize\tType\tLineno\tScope\tValue\n");
    symbol *temp = t->head;
    while (temp != NULL)
    {
        printf("%s\t%d\t%d\t%d\t%d\t%s\n", temp->name, temp->size, temp->type, temp->line, temp->scope, temp->val);
        temp = temp->next;
    }
}

char* get_symbol_data_type(char* name)
{
    symbol* temp = t->head;
    while (temp != NULL)
    {
        if (!strcmp(temp->name, name))
        {
            return temp->type;
        }
    }
    return NULL;
}

char* check_literal(char* value)
{
    int length = strlen(value);
    if ((value[0] == '\'' && value[length-1] == '\'') || (value[0] == '\"' && value[length-1] == '\"'))
    {
        return "literal";
    }
}

char* evaluate_expression(char* operand_1, char* value_1, char* operand_2, char* value2)
{
    char* type_1 = get_symbol_data_type(operand_1);
    char* type_2 = get_symbol_data_type(operand_2);
    if (type_1 == NULL && type_2 == NULL) // both are either undeclared variables or literals
    {

    }
}

