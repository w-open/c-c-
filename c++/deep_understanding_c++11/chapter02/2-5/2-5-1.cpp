#include<cassert>
using namespace std;

char* ArrayAlloc(int n)
{
    assert(n > 0);
    return new char [n];
}

int main(int argc, char* argv[])
{
    char* a = ArrayAlloc(0);
    return 0;
}
