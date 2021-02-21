#include<iostream>

#include "Concrete.h"
using namespace std;


class Point2d {
public:
	Point2d(float x = 0.0, float y = 0.0) :
		_x(x), _y(y) { }

	float x() const { return _x; }
	float y() const { return _y; }

	void x(float newX) { _x = newX; }
	void y(float newY) { _y = newY; }

	void operator += (const Point2d& rhs)
	{
		_x += rhs.x();
		_y += rhs.y();
	}

protected:
	float _x, _y;
};

// inheritance from concrete class
class Point3d : public Point2d {
public:
	Point3d(float x = 0.0, float y = 0.0, float z = 0.0) :
		Point2d(x, y), _z(z) { }

	float z() const { return _z; }

	void z(float newZ) { _z = newZ; }

	void operator += (const Point3d& rhs)
	{
		Point2d::operator+=(rhs);
		_z += rhs.z();
	}

protected:
	float _z;
};



int main(int argc, char* argv[])
{
	Point2d p2(1, 2);
	Point3d p3(3, 4, 5);

	cout << "\n\n";

	cout << "sizeof(Concrete) is:" << sizeof(Concrete) << endl;
	cout << "sizeof(Concrete3) is:" << sizeof(Concrete3) << endl;


	return 0;
}