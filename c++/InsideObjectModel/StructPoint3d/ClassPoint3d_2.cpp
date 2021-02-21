template<typename type>
class Point3d
{
public:
	Point3d(type x = 0.0, type y = 0.0, type z = 0.0)
		:_x(x), _y(y), _z(z) {}

	type x() const { return _x; }
	type y() const { return _y; }
	type z() const { return _z; }

	void x(type xval) { _x = xval; }
	void y(type yval) { _y = yval; }
	void z(type zval) { _z = zval; }

	//...etc...
private:
	type _x;
	type _y;
	type _z;
};
