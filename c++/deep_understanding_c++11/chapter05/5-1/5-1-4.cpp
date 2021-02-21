#include<iostream>
using namespace std;

enum C { C1 = 1, C2 = 2 };
enum D { D1 = 1, D2 = 2, Dbig = 0xFFFFFFF0U };
enum E { E1 = 1, E2 = 2, Ebig = 0xFFFFFFFFFLL };

int main()
{
    cout << sizeof(C1) << endl;
    
    cout << Dbig << endl;
    cout << sizeof(D1) << endl;
    cout << sizeof(Dbig) << endl;
    
    cout << Ebig << endl;
    cout << sizeof(E1) << endl;
    cout << sizeof(Dbig) << endl;

    return 0;
}
