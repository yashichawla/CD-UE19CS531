#include <stdio.h>
void main()
{
    int a = 1;
    int i = -(a && a || (a && !true));
}
