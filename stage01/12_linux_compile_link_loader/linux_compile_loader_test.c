/*************************************************************************
    > File Name: linux_compile_loader_test.c
    > Author: koffuxu
    > Mail: koffuxu@gmail.com 
    > Created Time: Wed 13 May 2015 01:52:59 PM CST
 ************************************************************************/

#include<stdio.h>
#include<sys/types.h>
#include <unistd.h>
int main(){
    uid_t uid;
    uid = getuid();
    printf("hello world YM studio; uid = %d\n",uid);
    return 0;
}
