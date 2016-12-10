/*************************************************************************
    > File Name: 07_cpp_overload.cpp
    > Author: koffuxu
    > Mail: koffuxu@gmail.com 
    > Created Time: Mon 20 Apr 2015 11:09:45 AM CST
 ************************************************************************/

#include<iostream>
using namespace std;
//function overload
void print(int i)
{
    cout<<"Print a integer:"<<i<<endl;
}
void print(string str)
{
    cout<<"print a Streing:"<<str<<endl;
}
//class overload

int main(){
    print(10);
    print("Hello Test CPP Overload!");
    return 0;
}
