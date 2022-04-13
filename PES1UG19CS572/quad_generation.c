#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "quad_generation.h"

void quad_code_gen(char* a, char* b, char* op, char* c)
{
	fprintf(icg_quad_file,"%s\t%s\t%s\t%s\n",op,b,c,a);
	//use fprintf to output the quadruple code to icg_quad_file
}

char* new_temp()
{	
	char* temp=(char*)malloc(sizeof(char)*4);
	sprintf(temp,"t%d",temp_no);
	temp_no++;
	return temp;
	
		//returns a pointer to a new temporary
}
