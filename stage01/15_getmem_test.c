/*************************************************************************
    > File Name: 15_getmem_test.c
    > Author: koffuxu
    > Mail: koffuxu@gmail.com 
    > Created Time: Mon 28 Dec 2015 09:59:57 AM CST
 ************************************************************************/

#include<stdio.h>
#include<string.h>
#include <stdlib.h>
void getMem1(char* str, int num)
{
    str = (char *)malloc(sizeof(char) * num);
}
void getMem2(char** str, int num)
{
    *str = (char *)malloc(sizeof(char) * num);
}

int main(int args, char* argv[]){
    char* p = NULL;
    //getMem1(p, 100);
    getMem2(&p, 100);
    strcpy(p,"hello Dec.28th");
    printf("%s",p);
}
