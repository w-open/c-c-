#include<iostream>
#include<typeinfo>
using namespace std;

int main() {
    int i;
    decltype(i) j = 0;
    cout << typeid(j).name() << endl;

    float a;
    double b;
    decltype(a + b) c;
    cout << typeid(c).name() << endl;
    return 0;
}
