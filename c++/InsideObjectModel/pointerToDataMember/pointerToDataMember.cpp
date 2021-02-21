#include<iostream>
#include<typeinfo>

using namespace std;

class Point3d {
public:
	Point3d() = default;
	virtual ~Point3d() {}

	static Point3d origin;
	float x, y, z;
};

static Point3d origin;

int main(int argc, char* argv[])
{
	Point3d p3d;

	printf("&Point3d::x = %p\n", &Point3d::x);
	printf("&Point3d::y = %p\n", &Point3d::y);
	printf("&Point3d::z = %p\n", &Point3d::z);

	cout << "&Point3d::x = " << &Point3d::x << endl;
	cout << "&Point3d::y = " << &Point3d::y << endl;
	cout << "&Point3d::z = " << &Point3d::z << endl;

	cout << typeid(&Point3d::z).name() << endl;

	float Point3d::* p1 = 0;

	cout << typeid(p1).name() << endl;

	return 0;
}