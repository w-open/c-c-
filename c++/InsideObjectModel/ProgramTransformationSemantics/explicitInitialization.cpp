#include<iostream>

using namespace std;

class X {
public:
	X() = default;
	X(const X& x) { cout << __FUNCTION__ << endl; }

};


X foo()
{
	X x0;

	X x1{ x0 };
	X x2 = x0;
	X x3 = X(x0);

	return x0;
}


int main(int argc, char* argv[])
{
	foo();

	return 0;
}