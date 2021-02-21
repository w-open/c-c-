#include<iostream>

#include "ClassPoint.h"

using std::cout;
using std::cin;
using std::endl;

int main()
{
	float dims[] = { 5.2f, 2.3f, 3.4f };
	Point<float, 3> point(dims);
	cout << point;

	cout << "sizeof = " << sizeof(point) << endl;

	return 0;
}