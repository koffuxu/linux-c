/*************************************************************************
    > File Name: test.c
    > Author: koffuxu
    > Mail: koffuxu@gmail.com 
    > Created Time: Fri Dec 29 11:04:15 2017
 ************************************************************************/

#include<stdio.h>

#define BUILD_ZERO(a) (sizeof(struct {int :-!!(a);}))
int main(int argc, char* argv){
    printf("Who are you(0): %ld\n",BUILD_ZERO(0));
    //compile error: negative width in bit-field '<anonymous>'
    //printf("Who are you(10): %ld\n",BUILD_ZERO(10));
    //printf("Who are you('c'): %ld\n",BUILD_ZERO('c'));
}
