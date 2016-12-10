/*************************************************************************
    > File Name: deamon_process_test.c
    > Author: koffuxu
    > Mail: koffuxu@gmail.com 
    > Created Time: Mon 15 Dec 2014 04:44:47 PM CST
 ************************************************************************/

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<fcntl.h>
#include<sys/types.h>
#include<sys/stat.h>
#include<unistd.h>
#include<sys/wait.h>
#include<signal.h>
#define MAXFILE 65535

volatile sig_atomic_t _running = 1;
void sigterm_handler(int arg);

int main(void){
    pid_t pc;
    int i, fd,len; 
    char *buf="development and mantain!\n";
    len = strlen(buf);
    //1,fork chirld process;father process exit
    pc = fork();
    printf("chirld process no=%d\n",pc);
    if(pc < 0){
        printf("fork error!\n");
        exit(1);
    }else if(pc > 0){
        printf("chirld process no=%d\n",pc);
        exit(0);
    }
    //2,create new comversation for chirld process
    setsid();
    chdir("/");
    umask(0);
    //3,close fd for reserved memory
    close(STDIN_FILENO);
    close(STDOUT_FILENO);
    close(STDERR_FILENO);

    signal(SIGTERM,sigterm_handler);
    if((fd = open("/tmp/hsperfdata_gangfeng.xu/test.log",O_CREAT|O_WRONLY|O_APPEND,0600))<0){
        perror("open");
        exit(1);
    }
    while(_running){

        write(fd,buf,len);
        sleep(10);
    }
    close(fd);

}

void sigterm_handler(int arg){
    _running = 0;
}
