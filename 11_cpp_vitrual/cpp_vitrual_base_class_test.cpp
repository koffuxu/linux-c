/*************************************************************************
    > File Name: cpp_vitrual_base_class_test.cpp
    > Author: koffuxu
    > Mail: koffuxu@gmail.com 
    > Created Time: Wed 13 May 2015 11:54:42 AM CST
 ************************************************************************/

#include<iostream>
using namespace std;

class GrandFather{
    public:
        int flag;
        GrandFather(){
            flag = 0;
            cout << "GrandFather flag ="<<flag<<endl;
        }
};

class Father1 : virtual public GrandFather{
    public:
        Father1(){
            flag = 1;
            cout <<"Father1 flag = "<< flag <<endl;
        }
};
class Father2 : virtual public GrandFather{
    public:
        Father2(){
            flag = 2;
            cout <<"Father2 flag = "<< flag <<endl;
        }
};

class Son : public Father1, public Father2{

};

int main(){
    Son * s = new Son();
    cout <<" s->flag = " << s->flag<<endl;
    return 0;
}
