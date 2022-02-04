tokens = '''int return INT;
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
. return *yytext;
'''.strip().split('\n')

tokens = list(map(lambda x: x.strip().split(), tokens))
for t in tokens:
    if t:
        print(f'%token {t[-1][:-1]}')

