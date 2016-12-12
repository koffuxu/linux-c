/*************************************************************************
    > File Name: 16_strtok.c
    > Author: koffuxu
    > Mail: koffuxu@gmail.com 
    > Created Time: 2016年04月29日 星期五 10时38分36秒
 ************************************************************************/

#include<stdio.h>
#include<string.h>

#define INFO_MAX_SZ 50
typedef struct person{
    char name[25];
    char gender[8];
    int age;
}Person;
int main(int argc, char *argv[])
{
    char buffer[INFO_MAX_SZ] = "Koffu male 25, Tony male 27, Kimi famale 26";
    char* buf = buffer;
    char* tmp[20];
    int i = 0;
    char* out_ptr = NULL;
    char* in_ptr = NULL;
    const char* delim = " ";
    //strtok useage
    /*printf("buffer -- before = %s\n", buffer);
    buf = strtok(buffer, delim);
    printf("buffer -- after = %s\n", buffer);
    printf("buf = %s\n", buf);
    while(buf != NULL) {
        //when the first parameter is NULL means continue the pervious string
        buf = strtok(NULL, delim);
        printf("buf = %s\n", buf);
    }*/

    //strtok_r useage
    while((tmp[i] = strtok_r(buf, ",", &out_ptr)) != NULL){
        buf = tmp[i];
        while((tmp[i] = strtok_r(buf, " ", &in_ptr)) !=NULL){
            printf("--%s--",tmp[i]);
            i++;
            buf = NULL;
        }
        printf("\n");
        buf = NULL;
        
    }
    
}
