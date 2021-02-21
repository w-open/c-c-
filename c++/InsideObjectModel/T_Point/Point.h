#pragma once
template <typename Type>
class Point
{
public:
	enum Status{ unallocated, normalized };
	static Point<Type>* _freeList;
	static int _chunkSize;

	Point(Type x = 0.0, Type y = 0.0, Type z = 0.0)
		:_x(x), _y(y), _z(z)
	{
		std::cout << __FUNCTION__ << "..." << "Type = " << typeid(Type).name() << std::endl;
	}

	~Point()
	{
		std::cout << __FUNCTION__ << "..." << "Type = " << typeid(Type).name() << std::endl;
	}

	void* operator new(size_t size)
	{
		std::cout << __FUNCTION__ << "..." << "Type = " << typeid(Type).name() << " size = " << size <<std::endl;

		return nullptr;
	}

	void operator delete(void* ptr)
	{
		std::cout << __FUNCTION__ << "..." << "Type = " << typeid(Type).name() << std::endl;

		return;
	}

	Type x() const { return _x; }
	Type y() const { return _y; }
	Type z() const { return _z; }

	void x(Type xval) { _x = xval; }
	void y(Type yval) { _y = yval; }
	void z(Type zval) { _z = zval; }

	//template<typename type>
	//friend std::ostream& operator<<(std::ostream& os, const Point<type>& pd);

private:

	Type _x, _y, _z;
};

template<typename Type>
std::ostream& operator<<(std::ostream& os, const Point <Type>& pd)
{
	os << "(" << pd.x() << ", " << pd.y() << ", " << pd.z() << ")" << std::endl;
	return os;
}
