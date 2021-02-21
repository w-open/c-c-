template<class T, class U = double>
void f(T t = 0, U u = 0);

void g() {
    f(1, 'c');
    f(1);
    f();
    f<int>();
    f<int, char>();
}
