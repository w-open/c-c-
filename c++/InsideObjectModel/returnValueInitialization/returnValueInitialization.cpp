#include<iostream>

using namespace std;

class X {
public:
	X() { cout << this <<"X()" << endl; }
	X(const X& x) { cout << "X(const X& x)" << endl; }
	~X() { cout << "~X()" << endl; }

	void printf() { cout << "printf()" << endl; }

};


X foo()
{
	X xx;

	return xx;
}

int main(int argc, char* argv[])
{
	X xx;

	xx = foo();

	foo().printf();

	X(*pf)() = foo;

	return 0;
}