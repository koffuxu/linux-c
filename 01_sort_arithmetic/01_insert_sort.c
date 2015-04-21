/*************************************************************************
    > File Name: 01_insert_sort.c
    > Author: koffuxu
    > Mail: koffuxu@gmail.com 
    > Created Time: Mon 15 Dec 2014 06:16:37 PM CST
 ************************************************************************/

#include<stdio.h>
void insertSort(int *a, int len){
    int i,j,temp;
    //i 控制轮数;j控制该轮里面的交换游标 

    for(i = 1; i<len; i++){
        temp = a[i];
        for(j=i-1;j>=0;j--){
           
            
            if(a[j]>temp){
                a[j+1] = a[j];
            }
            else
            {
                break;
            }

        }
        a[j+1] = temp;
    }
}
void selectSort(int *a, int len){
    int i,j,temp,x;
    for(i=0;i<len;i++){
        for(j=0;j<len-i-1;j++){
            if(a[j]>a[j+1])
                x = j;
        }
        temp = a[j];
        a[j] = a[x];
        a[x] = temp;
    }
}
int main(void){
    int arrary[7] = {2,6,1,3,5,9,7};
    int i;
   insertSort(arrary,7);
 //   selectSort(arrary,7);
   for(i=0;i<7;i++)
       printf("%d ",arrary[i]);
   return 0;
}
