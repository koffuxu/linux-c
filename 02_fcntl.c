
#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<fcntl.h>

int main(void){

	int fd,flag;
	char* buf="hello,Linux C!";
	if(fd=open("/home/gangfeng.xu/app/linux_c/koffuxu.txt",O_RDWR/*|O_APPEND|O_CREAT|O_TRUNC,666*/) < 0){

		perror("open");
		exit(-1);
	}
	printf("the fd  = %d; size = %d\n",fd,strlen(buf));
	write(fd,buf,strlen(buf));
//	lseek(fd,0,SEEK_SET);
//	write(fd,"xu",2);
//	close(fd);
	return 0;
}
