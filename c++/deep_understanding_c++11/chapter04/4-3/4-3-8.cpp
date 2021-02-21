#include<type_traits>
using namespace std;

typedef double (*func)();

int main() {
    result_of<func()>::type f;
    return 0;
}
