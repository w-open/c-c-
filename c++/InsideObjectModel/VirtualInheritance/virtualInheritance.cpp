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
class Point3d : public virtual Point2d {
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

class Vertex: public virtual Point2d{
public:
	Vertex() {}
	virtual ~Vertex() {}
protected:
	Vertex* next;
};

class Vertex3d : public Point3d, public Vertex {
public:
	Vertex3d() {}
	virtual ~Vertex3d() {}
protected:
	float mumble;
};

int main(int argc, char* argv[])
{
	Vertex3d v3d;

	return 0;
}