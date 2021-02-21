#pragma once
#include<iostream>

using std::cout;
using std::endl;


class Foo
{
public:
	Foo()
	{
		cout << "Foo()" << endl;
	}

	Foo(int val, Foo* pnext = nullptr):_val(val), _pnext(pnext)
	{
		cout << "Foo(int val, Foo* pnext = nullptr)" << endl;
	}

	int _val = 0;
	Foo* _pnext = nullptr;
};

