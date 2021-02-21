#include<iostream>
#include "Snow_White.h"

using namespace std;

class Foo
{
public:
	Foo() { cout << __FUNCTION__ << endl; }
	Foo(int a) {};
	~Foo() {};
};

class Bar 
{
public:
	Bar() { cout << __FUNCTION__ << endl; }
	Foo foo;
	char* str = nullptr;
};

void foo_bar()
{
	Bar bar;

	if (bar.str)
	{

	}
}
int main(int argc, char* aegv[])
{
	foo_bar();

	Snow_White a;
	Snow_White a1(1024);

	return 0;
}