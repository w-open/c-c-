#include<vector>
using namespace std;

void fun(auto x = 1) {}

struct str {
    auto var = 10;
};

int main() {
    char x[3];
    auto y = x;
    auto z[3] = x;

    vector<auto> v = {1};
}
