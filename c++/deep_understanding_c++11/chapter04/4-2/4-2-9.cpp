int x;
int *y = &x;
double foo();
int &bar();

auto *  a = &x;
auto &  b = x;
auto c = y;
auto * d = y;
auto * e = &foo();
auto & f = foo();
auto g = bar();
auto & h = bar(); 
