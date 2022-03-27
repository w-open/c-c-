#include<iostream>
using namespace std;
class X 
{ 
public: 
	int i; 
};

class A : public virtual X 
{ 
public: 
	int j; 
};

class B : public virtual X
{
public:
	double d;
};

class C : public A, public B
{
public:
	int k;
};

void foo(A*const  pa)
{
	pa->i = 1024;
}

int main(int argc, char* argv[])
{
	foo(new A);
	foo(new C);

	X x;
	A a;
	B b;
	C c;

	cout << "siezof(Class X) = " << sizeof(x) << endl;
	cout << "siezof(Class A) = " << sizeof(a) << endl;
	cout << "siezof(Class B) = " << sizeof(b) << endl;
	cout << "siezof(Class C) = " << sizeof(c) << endl;

	return 0;
}