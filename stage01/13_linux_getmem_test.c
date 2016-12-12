/*************************************************************************
    > File Name: 13_linux_getmem_test.c
    > Author: koffuxu
    > Mail: koffuxu@gmail.com 
    > Created Time: Sat 21 Nov 2015 02:08:35 PM CST
 ************************************************************************/

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
//segment fault
void get_mem1(char * p)
{
    p = (char *)malloc(100);
}
char * get_mem2(void)
{
    //char* p = "Hello word";
    char p[] = "hello word arrary";
    return p;
}
void get_mem3(char **p, int num)
{
    *p = (char*)malloc(num);
}
int main(void)
{
    char *str=NULL;
 //   get_mem1(str);
 //   strcpy(str,"hello word");
 //   str = get_mem2();
    get_mem3(&str,20);
    strcpy(str,"hello word from 3");
    printf("\n%s\n",str);
    free(str);
    return 0;
}
