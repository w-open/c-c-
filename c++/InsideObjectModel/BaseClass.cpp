#include<iostream>

using namespace std;

class Base
{
public:
	Base()
	{
		cout << __FUNCTION__ << endl;
	} 
};

class Derived : public Base
{

};

int main(int argc, char* argv[])
{
	Derived d;

	return 0;
}