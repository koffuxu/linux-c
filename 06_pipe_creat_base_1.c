/*************************************************************************
    > File Name: 06_fifo_creat_base.c
    > Author: koffuxu
    > Mail: koffuxu@gmail.com 
    > Created Time: Sat 06 Dec 2014 11:09:45 AM CST
    > fifo = named pipe
    > but this code show unamed pipe
 ************************************************************************/

#include<stdio.h>
#include<unistd.h>
int main(void){

    int n,fd[2];
    pid_t pid;
    char line[100];
    //creat pipo
    if(pipe(fd)<0){
        printf("pipe creat fail!\n");
    }

    //creat proc
    if((pid = fork()) < 0){
        printf("fork error!\n");
    }
    if(pid == 0){
//this is child process,read something from write end
        close(fd[1]);
        n = read(fd[0],line,100);
        printf("Has read [%s] count %d,from pipe write end\n",line,n);
        //write(STDOUT_FILENO,line,n);
    }else {   
// this father process,close read thread,then,write something
        close(fd[0]);
        write(fd[1],"hello word koffu from father process", 50);

    }

    return 0;
}
