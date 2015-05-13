/*************************************************************************
    > File Name: 10_cpp_point_refernce.cpp
    > Author: koffuxu
    > Mail: koffuxu@gmail.com 
    > Created Time: Wed 22 Apr 2015 10:43:39 AM CST
 ************************************************************************/

#include<iostream>
using namespace std;
//1, reference and point
//2, pass by reference and pass by point in function varible

int main(int argc, char** argv){
    int i = 1;
    int& ref = i;
    int x = ref;
    cout<<"x is:"<<x<<endl;

    ref = 2;
    int* p = &i;
    cout<<"ref = "<<ref<<", i = "<<i<<endl;
    cout<<"&ref = "<<&ref<<", & = "<<&i<<endl;
    cout<<"p = "<<p<<endl;
    cout<<"*p = "<<*p<<endl;
    
    //2,




    return 0;
}
