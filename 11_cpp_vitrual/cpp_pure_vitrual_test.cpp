/*************************************************************************
    > File Name: cpp_vitrual_test.cpp
    > Author: koffuxu
    > Mail: koffuxu@gmail.com 
    > Created Time: Wed 13 May 2015 11:28:05 AM CST
 ************************************************************************/
//this is virtual function test exsample

#include<iostream>
using namespace std;

class A {
    public:
    void virtual print()= 0;
};

class B : public A{
    public:
    void print(){
        cout <<"this is class b."<<endl;
    }
};

int main()
{
    //A* a = new A()://error,cannot instantiation a pure virtrual class
    A* a = new B();
    a->print();
    return 0;
}
