#include<iostream>
using namespace std;

template <typename T>
void TempFun(T a) {
    cout << a << endl;
}

int main() {
    TempFun(1);
    TempFun("1");
    return 0;
}
