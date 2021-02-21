class Info {
public:
    Info() { InitRest(); }
    Info(int i): Info() { type = i; }
    Info(char e): Info() { name = e; }
private:
    void InitRest() {}
    int type {1};
    char name {'a'};
};

