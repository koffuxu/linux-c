#include <stdio.h>
int main()
{
    enum phone{
        Apple,
        Huawei,
        Xiaomi,
        Meizu,
    };
    enum phone p1, p2;
    p1 = Apple;
    p2 = Meizu;
    printf("P1 usd phone brand is %d \n",p1);
    printf("P2 usd phone brand is %d \n",p2);
    return 0;
}
