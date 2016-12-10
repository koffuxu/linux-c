/*************************************************************************
    > File Name: 09_cpp_constractor_copy.cpp
    > Author: koffuxu
    > Mail: koffuxu@gmail.com 
    > Created Time: Tue 21 Apr 2015 04:54:32 PM CST
 ************************************************************************/
//refer to http://www.cnblogs.com/BlueTzar/articles/1223313.html

#include<iostream>
#include<string.h>
using namespace std;
//1,constractor copy = 3 shallow copy >>可以理解为软链接；而深copy，开辟了新的资源
//2,deep copy
//3,shallow copy

class ShallowExample{

    private: 
        int a;
    public:
        ShallowExample(int b){
            a = b;
        }
        void show(){
            cout<<"CExample value:"<<a<<endl;
        }
        //1,copy constractor
        //X(const X& b)
        ShallowExample(const ShallowExample& t){
            a = t.a;
        }

};
//deep copy
class DeepExample{
    private:
        int a;
        char* str;
    public:
        DeepExample(int _a, char* _str){
            a = _a;
            str = new char[a];
            strcpy(str,_str);
        }
        DeepExample(const DeepExample& _de){
            a = _de.a;
            str = new char[a];  //alloc heap space ,nend manual delete.
            strcpy(str,_de.str);
        }
        void show(){
            cout<<str<<endl;
        }
        ~DeepExample(){
            delete str;     //recycle
        }

};

int main(){
    ShallowExample c1(100);
    ShallowExample c2 = c1;
    c2.show();
    DeepExample d1(20,"halo world");
    DeepExample d2 = d1;
    d2.show();;
    return 0;
}
