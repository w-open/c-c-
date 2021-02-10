#include<iostream>
using namespace std;

struct A {
    ~A() { throw 1; }
};

struct B {
    ~B() noexcept(false) { throw 2; }
};

struct C {
    B b;
};

int funcA() { A a; }
int funcB() { B b; }
int funcC() { C c; }

int main()
{
    try {
        funcB();
    }
    catch(...) {
        cout << "caught funcB." << endl;
    }
    
    try {
        funcC();
    }
    catch(...) {
        cout << "caught funcC." << endl;
    }
    
    try {
        funcA();
    }
    catch(...) {
        cout << "caught funcA." << endl;
    }
    return 0;
}
