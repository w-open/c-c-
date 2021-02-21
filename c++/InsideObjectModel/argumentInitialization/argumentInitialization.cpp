#include<iostream>

using namespace std;

class X {
public:
	X() { cout << "X()" << endl; }
	X(const X& x) { cout << "X(const X& x)" << endl; }
	~X() { cout << "~X()" << endl; }

};


void foo(X x0)
{

}


int main(int argc, char* argv[])
{
	X xx;

	foo(xx);

	return 0;
}