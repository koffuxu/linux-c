/*************************************************************************
    > File Name: 04_priority_test.cpp
    > Author: koffuxu
    > Mail: koffuxu@gmail.com 
    > Created Time: 2016年05月12日 星期四 11时34分47秒
 ************************************************************************/

#include<iostream>
#include<queue>
#include<utility>
#include<stdlib.h>
#include<iomanip>
using namespace std;

//1,常用方式：通过数组实例化为priority queue
int test_func_1() {
    int a[5] = {1, 2, 3, 5, 4 };
    //FIFO
    priority_queue<int> pq(a, a+5);
    while(!pq.empty()){
        cout << pq.top() << " ";
        pq.pop();
    }
    return 1;
}

//2,测试自定义类型
struct Node {
    int b;
};
typedef Node MyNode;
struct Cmp {
    bool operator()(const MyNode &t1, const MyNode &t2){
        return t1.b < t2.b;
    }
};
int test_func_2() {
   int n;
   cout<<"how much interge you want type:";
   cin >> n;
   MyNode *iNode = new MyNode[10];
   for(int i=0; i<n; i++){
       cin>>iNode[i].b;
   }
   //定义优先队列
   priority_queue<MyNode, vector<MyNode>, Cmp> pq_node(iNode, iNode+n);
   cout<<"print the prority queue: ";
   while(!pq_node.empty()){
       cout<<pq_node.top().b<<" ";
       pq_node.pop();
   }
   return 1;
}

//3，Ugly Number 测试, 输出第1500个
//prime factor is:2,3,5; 1 was included
typedef pair<unsigned long, int> node_type;
int search_ugly_number(int index) {
    int count = index;
    unsigned long result[count];
    priority_queue<node_type, vector<node_type>, greater<node_type> > u_pq;
    u_pq.push(make_pair(1,2));
    for(int i=0; i<count; i++) {
        node_type node = u_pq.top();
        u_pq.pop();
        switch(node.second){
            case 2: u_pq.push(make_pair(node.first*2, 2));
            case 3: u_pq.push(make_pair(node.first*3, 3));
            case 5: u_pq.push(make_pair(node.first*5, 5));
        }
        result[i] = node.first;
    }
    int n;
    cin >> n;
    while(count > n > 0 ) {
        cout << "the "<<n<<"th ugly number: "<<result[n-1]<<endl;
        cin >> n;
        /* TODO
         * if(n == 'q'){
            cout << "bye-bye";
            break;
        }*/
    }
    return 1;
}

int main(int args, char* argv[]) {
    //test_func_1();
    //test_func_2();
    //search_ugly_number(100);
    cout  << "the Magic Number is:" <<hex<<(int)'M'<<hex<<(int)'P'<<hex<<(int)'T';
    return 0;
}
