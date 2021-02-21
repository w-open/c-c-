#include<iostream>
//#include<typeinfo>

#include "min.h"
#include "Point.h"

using namespace std;

Point<float>* _freeList_float = nullptr;
Point<double>* _freeList_double = nullptr;

int main(int argc, char* argv[])
{
	std::cout << "\n\n template min..." << std::endl;
	std::cout << min(1.0, 2.0);

	std::cout << "\n\n template Point..." << std::endl;
	Point<float> point(2.5f);
	std::cout << point <<" size_t :" <<sizeof(point);

	Point<float>::Status s; //OK
	//Point::Status s; //error

	cout << "&Point<float> = " << &_freeList_float << endl;
	cout << "&Point<double> = " << &_freeList_double << endl;

	Point<float>* ptr = nullptr;
	const Point<float>& ref = 0;
	cout << ref << endl;

	Point<float>* p = new Point<float>;

	return 0;
}