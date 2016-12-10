/*************************************************************************
    > File Name: 01_debug.c
    > Author: koffuxu
    > Mail: koffuxu@gmail.com 
    > Created Time: 2013年07月17日 星期三 23时26分11秒
 ************************************************************************/

#include<stdio.h>
void exchange1(int* x, int* y)
{
	int temp;
	temp = *x;
	*x = *y;
	*y = temp;

}
int main()
{

	int a = 1, b = 3;
	exchange1(&a,&b);
	printf("after exchange1 a = %d,b = %d\n",a,b);
}
