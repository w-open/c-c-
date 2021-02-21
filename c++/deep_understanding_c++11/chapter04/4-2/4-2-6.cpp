#include<iostream>
using namespace std;

int main() {
    unsigned int a = 4294967295;
    unsigned int b = 1; 
    auto c = a + b;

    cout << "a = " << a << endl;
    cout << "b = " << b << endl;
    cout << "a + b = " << c << endl; 
    
    return 0;
}
