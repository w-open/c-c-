#include<iostream>
using namespace std;

struct TestStruct {
    TestStruct():name(__func__){}
    const char* name;
};

int main(int argc, char *argv[])
{
    TestStruct ts;
    cout << ts.name << endl;
    return 0;    
}
