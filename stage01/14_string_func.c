/*************************************************************************
    > File Name: 14_string_func.c
    > Author: koffuxu
    > Mail: koffuxu@gmail.com 
    > Created Time: Thu 24 Dec 2015 03:06:10 PM CST
 ************************************************************************/

#include<stdio.h>
#include<string.h>

void func(char* str){
    if (str == 0) {
        return;
    }
    int len = strlen(str);
    if (len <= 1){
        return;
    }
    char last = str[len - 1];
    str[0] = last;
    if((len - 1) > 1){
        str[len-1] = 0;
        func(str + 1);
    }
    str[len-1] = last;
    return;
}
int main(){
    char str[] = "123456";
    func(str);
    printf("%s\n",str);
    return 0;
}
