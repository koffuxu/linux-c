/*************************************************************************
    > File Name: 05_list_base.c
    > Author: koffuxu
    > Mail: koffuxu@gmail.com 
    > Created Time: Thu 04 Dec 2014 03:36:57 PM CST
 ************************************************************************/

#include<stdio.h>
typedef struct node{
    char name[10];
    int score;
    struct node *link;
}stud;
//crate list

