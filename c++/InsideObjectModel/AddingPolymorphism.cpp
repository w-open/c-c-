#include<iostream>
using namespace std;

class Point2d {
public:
	Point2d(float x = 0.0, float y = 0.0) :
		_x(x), _y(y) { }

	float x() const { return _x; }
	float y() const { return _y; }

	void x(float newX) { _x = newX; }
	void y(float newY) { _y = newY; }

	// 加上z的保留空间（当前什么也没做）
	virtual float z() const { return 0.0; }
	virtual void z(float newZ) { }

	virtual void operator += (const Point2d& rhs)
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

	//参数引用的是Point2d&而非Point3d&
	void operator += (const Point2d& rhs)
	{
		Point2d::operator+=(rhs);
		_z += rhs.z();
	}

protected:
	float _z;
};


void foo(Point2d& p1, Point2d& p2)
{
	p1 += p2;
}

int main(int argc, char* argv[])
{
	Point2d p2(1, 2), p2_1(1, 2);
	Point3d p3(3, 4, 5);
	return 0;
}