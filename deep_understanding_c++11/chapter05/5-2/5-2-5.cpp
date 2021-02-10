#include<memory>
using namespace std;

int main()
{
    int *p = new int;
    declare_reachable(p);
    int *q = (int *)((long long)(p)^2012);

    q = undeclare_reachable<int>((int *)((long long)q^2012));
    *q = 10;
}
