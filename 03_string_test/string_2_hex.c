/*************************************************************************
    > File Name: string_2_hex.c
    > Author: koffuxu
    > Mail: koffuxu@gmail.com 
    > Created Time: Wed 17 Dec 2014 08:15:08 PM CST
 ************************************************************************/

#include<stdio.h>
#include<string.h>
int str2hex(const char* a){
    int i, temp,result = 0;
    for(i=0; i<strlen(a); i++){
        if((a[i]>'0') || (a[i] < '9')){
            temp = a[i] - '0';
        }else if(((a[i]>'a') || (a[i] < 'b'))){

            temp = a[i] - 'a';
        }else if(((a[i]>'0') || (a[i] < '9'))){
            temp = a[i] - 'A';
        }else
            return -1;//error
        result += result*16 + temp;
        printf("temp%d is %d;  result=%d\n",i,temp,result);
    }
    return result;
}

int main(void){
    char array[]="12";
    int i = 0;
    i = str2hex(array);
    printf("result is %d\n",i);
    return 0;
}
