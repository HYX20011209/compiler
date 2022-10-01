#include<iostream>
using namespace std;
int main()
{
    int a = 2;  //变量声明，变量初始化
    const int c = 1;    //常量声明和初始化
    int b = 3;
    int add = a +b;
    int sub = b - a;
    int mul = a*b;
    int div = b/a;
    int mod = b % a;
    int equal = (a==b);
    int larger = (a>b);
    int smaller = (a<b);
    int not_less = (a>=b);
    int not_more = (a<=b);
    int not_equal = (a!=b);

    int x = 1;
    int y = 0;
    int and_op = (x&&y);
    int or_op = (x||y);
    int not_op = (!x);
    
    cout<<add<<endl;
    cout<<sub<<endl;
    cout<<mul<<endl;
    cout<<div<<endl;
    cout<<mod<<endl;
    cout<<equal<<endl;
    cout<<larger<<endl;
    cout<<smaller<<endl;
    cout<<not_less<<endl;
    cout<<not_more<<endl;
    cout<<not_equal<<endl;

    cout<<and_op<<endl;
    cout<<or_op<<endl;
    cout<<not_op<<endl;
    return 0;
}