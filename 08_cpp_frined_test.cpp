/*************************************************************************
    > File Name: 08_cpp_frined_test.cpp
    > Author: koffuxu
    > Mail: koffuxu@gmail.com 
    > Created Time: Tue 21 Apr 2015 11:54:15 AM CST
 ************************************************************************/

#include<iostream>
#include<math.h>
using namespace std;

class Point
{
    public:
        Point(double xx, double yy){
            x = xx;
            y = yy;
        }
        void getXY();
        friend double distanceXY(Point& a, Point& b);//friend function

    private:
        double x, y;
};

void Point::getXY()
{
    cout<<"x="<<Point::x<<"; y="<<Point::y<<endl;
}
double distanceXY(Point& a, Point& b)
{
    double dx, dy;
    dx = (a.x - b.x);
    dy = (a.y - b.y);
    return sqrt(dx*dx + dy*dy);
}

int main()
{
    
    Point p1(4.0, 3.0);
    Point p2(0, 0);
    p1.getXY();
    double d = distanceXY(p1, p2);
    cout<<"distance is:"<<d<<endl;
    cout<<"1 left shit 3 is:"<<(1<<3)<<endl;
    return 0;
}
