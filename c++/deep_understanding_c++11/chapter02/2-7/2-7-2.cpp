#include<string>

using namespace std;

struct C {
    C(int i):c(i){};
    int c;
};

struct init {
    int a = 1;
    string b("hello");
    C c(1);
};
