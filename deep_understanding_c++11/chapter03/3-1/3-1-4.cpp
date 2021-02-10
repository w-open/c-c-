struct A {
    A(int i) {}
    A(double d, int i) {}
    A(float f, int i, const char *c) {}
};

struct B: A {
    using A::A;
    virtual void ExtraInterface() {}
};
