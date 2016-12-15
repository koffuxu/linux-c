/*************************************************************************
    > File Name: 01_hanoi_test.cpp
    > Author: koffuxu
    > Mail: koffuxu@gmail.com 
    > Created Time: Thu, Dec 15, 2016  8:25:23 PM
 ************************************************************************/

#include<iostream>
using namespace std;

//把n个盘子，从X，借助Y，移动到Z
void move(int n, char x, char y, char z) {
    if(n == 1)
        cout<<x<<" ---> "<<z<<endl;
    else {
        //
        move((n-1), x, z, y);
        cout<<x<<" ---> "<<z<<endl;
        move((n-1), y, x, z);
    }
}
int main(){
    int n;
    char x='x', y='y', z='z';
    cout<<"please input the number of Hanoi:";
    cin >> n;

    move(n,'x', 'y', 'z');
    return 0;
}
