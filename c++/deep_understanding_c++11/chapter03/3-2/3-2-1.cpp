class Info {
public:
    Info():type(1), name('a') { InitRest(); }
    Info(int i): type(i), name('a') { InitRest(); }
    Info(char e): type(1), name(e) { InitRest(); }
private:
    void InitRest() {}
    int type;
    char name;
};

