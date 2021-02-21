#include<iostream>
using namespace std;

const char* hello() { return __func__; }
const char* world() { return __func__; }

int main(int argc, char *argv[])
{
    cout << hello() << ", " << world() << endl;
    return 0;    
}
