/*************************************************************************
    > File Name: 06_pipe_creat_base_2.c
    > Author: koffuxu
    > Mail: koffuxu@gmail.com 
    > Created Time: Sat 06 Dec 2014 03:13:22 PM CST
    > named pipe = fifo 
    > system call mkfifo()
 ************************************************************************/

#include<stdio.h>
#include<unistd.h>
#include<sys/stat.h>
#include<sys/types.h>
#include<stdio.h>
#include<stdlib.h>
#include<fcntl.h>
#include<limits.h>

int main(void){

    int fd;
    int num;
    char buf[PIPE_BUF] = "abc\n";
    mode_t mode = 0666;
    if(mkfifo("fifo1", mode) < 0)
    {
        printf("mkfifo error \n");
    }
    if((fd = open("fifo1",O_RDONLY)) < 0){
        printf("open fifo 1 error\n");
    }
    while((num = read(fd, buf, PIPE_BUF-1)) > 0){
        printf("this char from fifo1: %s\n",buf);
    }
    close(fd);
    if(num == 0){
        printf("read end\n");
    }
    return 0;
}
