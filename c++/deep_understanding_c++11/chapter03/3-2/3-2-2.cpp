class Info {
public:
    Info() { InitRest(); }
    Info(int i): type(i) { InitRest(); }
    Info(char e): name(e) { InitRest(); }
private:
    void InitRest() {}
    int type {1};
    char name {'a'};
};

