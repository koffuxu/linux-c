/*************************************************************************
    > File Name: test_read_file.cpp
    > Author: koffuxu
    > Mail: koffuxu@gmail.com 
    > Created Time: 2016年05月02日 星期一 12时21分07秒
 ************************************************************************/

#include<iostream>
#include<fstream>
using namespace std;
int main(void) {
	ifstream input;
	char fname[10];
	char mname;
	char lname[10];
	int score;
	input.open("scores.txt");
	//
	if( input.fail() ) {
		cout<<"file NOT FOUND"<<endl;
	} else {
		while(!input.eof()){
			//read 1 line,blank is a Word token
			input>>fname>>mname>>lname>>score;
			cout<<fname<<" "<<mname<<" "<<lname<<" "<<score<<endl;
		}
		input.close();
		return 0;
	}
}

