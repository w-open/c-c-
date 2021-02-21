#include<iostream>
using namespace std;

class Widget
{
public:
	virtual void flib() const { cout << __FUNCTION__ << endl; }
};

class Bell : public Widget
{
public:
	void flib() const
	{ 
		cout << __FUNCTION__ << endl;
	}
};

class Whistle : public Widget
{
public:
	void flib() const 
	{ 
		cout << __FUNCTION__ << endl;
	}
};

void flib(const Widget& widget) { widget.flib(); }

int main(int argc, char* argv[])
{
	Bell b;
	Whistle w;
	flib(b);
	flib(w);

	return 0;
}