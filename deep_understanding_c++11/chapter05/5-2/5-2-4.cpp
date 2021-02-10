int main()
{
    int *p = new int;
    int *q = (int *)(reinterpret_cast<long long>(p)^2012);

    q = (int *)(reinterpret_cast<long long>(q)^2012);
    *q = 10;
}
