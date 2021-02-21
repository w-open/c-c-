#include<iostream>

using namespace std;

struct Base1 { int val1; };
struct Base2 { int val2; };
struct Derived : Base1, Base2 {};
struct Derived2 : Base1, Base2 { int val; };

void func1(int Derived::* dmp, Derived* pd)
{
	pd->*dmp;
}

void func2(Derived* pd)
{
	int Base2::* bmp = &Base2::val2;
	cout << bmp;
}

void print_offset()
{
	printf("&Base1::val1 = %p\n", &Base1::val1);
	printf("&Base2::val2 = %p\n", &Base2::val2);
	printf("&Derived::val1 = %p\n", &Derived::val1);
	printf("&Derived::val2 = %p\n", &Derived::val2);
	printf("&Derived2::val = %p\n", &Derived2::val);
}

int main(int argc, char* argv[])
{
	Derived d;
	Derived* pd = &d;
	func2(pd);

	print_offset();
	return 0;
}
