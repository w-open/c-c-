double foo();
float * bar();

const auto a = foo();
const auto & b = foo();
volatile auto *c = bar();

auto d = a;
auto & e = a;
auto f = c;
volatile auto & g = c;
