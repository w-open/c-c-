template<typename T1, typename T2>
double Sum(T1 & t1, T2 & t2) {
    auto s = t1 + t2;
    return s;
}

int main() {
    int a = 3;
    long b = 5;
    float c = 1.0f, d = 2.3f;

    auto e = Sum<int, long>(a, b);
    auto f = Sum<float, float>(c, d);
    return 0;
}
