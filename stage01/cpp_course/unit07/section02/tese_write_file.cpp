/*************************************************************************
    > File Name: tese_write_file.cpp
    > Author: koffuxu
    > Mail: koffuxu@gmail.com 
    > Created Time: 2016年05月02日 星期一 11时57分39秒
 ************************************************************************/

#include<iostream>
#include<fstream>
using namespace std;
int main(void) {
	ofstream output;
	output.open("scores.txt");
	output<<"Koffu"<<" "<<"W"<<" "<<"Xu"<<" "<< 90 <<endl;
	output<<"Jack"<<" "<<"H"<<" "<<"Roll"<<" "<< 80 <<endl;
	output.close();
	return 0;
	
}

