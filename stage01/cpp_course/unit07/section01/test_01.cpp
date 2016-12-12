/*************************************************************************
    > File Name: test_01.cpp
    > Author: koffuxu
    > Mail: koffuxu@gmail.com 
    > Created Time: 2016年05月02日 星期一 11时29分57秒
 ************************************************************************/

#include<iostream>
using namespace std;
int main(void){
	char c;
	int i = 0;
	do {
		c = cin.get();
		cout << ++i << ":"<<static_cast<int>(c)<<endl;

	} while (c != 'q');
}
