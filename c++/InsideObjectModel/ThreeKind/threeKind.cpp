#include<iostream>
using namespace std;

class X
{
public:
	X() { cout << "X()" << endl; }
	X(X& x) { cout << "X(X& x)" << endl; }
	~X() { cout << "~X()" << endl; }
private:

};

void foo(X x) { cout << "foo(X x)" << endl; }
X foo_bar()
{
	X xx;
	return xx;
}

int main(int argc, char* argv[])
{
	X x;
	X xx = x;

	foo(xx);

	return 0;
}