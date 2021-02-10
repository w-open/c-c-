class Init{
public:
    Init(): a(0) {}
    Init(int d): a(d) {}
private:
    int a;
    const static int b = 0;
    int c = 1;
    static int d = 0;
    static const double e = 1.3;
    static const char * const f = "e";
};
