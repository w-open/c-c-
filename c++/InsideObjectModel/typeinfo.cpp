#include<iostream>
#include<typeinfo>
using namespace std;

class B{};
class D: public B {};

void main()
{
	B* pb = new B;
	D* pd = new D;

	cout << "pb's type name = " << typeid(pb).name() << endl;
	cout << "pd's type name = " << typeid(pd).name() << endl;

	cout << "pb's type rawname = " << typeid(pb).raw_name() << endl;
	cout << "pd's type rawname = " << typeid(pd).raw_name() << endl;

	return;
}