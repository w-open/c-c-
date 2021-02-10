template<typename T> struct MyTemplate{};

int main() {
    MyTemplate<struct {int a;}> t;
    return 0;
}
