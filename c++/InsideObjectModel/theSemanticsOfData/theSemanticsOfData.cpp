#include<iostream>
using namespace std;

class X{};
class Y: public virtual X{};
class Z: public virtual X{};
class A: public Y, public Z {};

int main(int argc, char* argv[])
{
	cout << "sizeof X is:" << sizeof(X) << endl;
	cout << "sizeof Y is:" << sizeof(Y) << endl;
	cout << "sizeof Z is:" << sizeof(Z) << endl;
	cout << "sizeof A is:" << sizeof(A) << endl;

	cout << "\n\n";
	X a, b;
	cout << "the address of a is "<< &a <<endl;
	cout << "the address of b is " << &b << endl;


	cout << "\n\n";
	Y y;
	Z z;



	return 0;
}