#include<iostream>
using namespace std;

class Dopey
{
public:
	Dopey()
	{
		cout << __FUNCTION__ << endl;
	}
};

class Sneezy
{
public:
	Sneezy(int a)
	{
		cout << __FUNCTION__ << endl;;
	}

	Sneezy()
	{
		cout << __FUNCTION__ << endl;
	}
};

class Bashful
{
public:
	Bashful()
	{
		cout << __FUNCTION__ << endl;
	}
};

class Snow_White
{
public:
	Snow_White()
	{
		cout << __FUNCTION__ << endl;
	}

	Snow_White(int a) :mumble(a), sneezy(1024)
	{
		cout << "Snow_White(int a)" << endl;
	}

	Dopey dopey;
	Sneezy sneezy;
	Bashful bashful;

private:
	int mumble;
};