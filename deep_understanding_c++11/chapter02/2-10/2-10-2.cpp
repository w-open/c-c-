struct Object{
    virtual void fun() = 0;
};

struct Base:public Object {
    void fun() final;
};

struct Derived: public Base {
    void fun();
};
