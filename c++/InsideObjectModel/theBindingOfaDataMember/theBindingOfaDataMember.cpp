#include<iostream>

using namespace std;

float x = 5;

class Point3d {
public:
	Point3d(float x, float y, float z)
	{
		this->x = x;
		this->y = y;
		this->z = z;
	}

	float X() const { return x; }
	void X(float new_x) { x = new_x; }
//private:
	float x, y, z;
};

template<typename class_type, typename data_type1, typename data_type2>
char* access_order(data_type1 class_type::* mem1, data_type2 class_type::* mem2)
{
	assert(mem1 != mem2);
	return mem1 < mem2 ? "member 1 occurs first": "member 1 occurs first";
}

int main(int argc, char* argv[])
{
	Point3d p(1, 2, 3);
	p.X(2);

	cout << p.X() << endl;

	access_order<Point3d, float, float>(&p.x, &p.y);

	return 0;
}