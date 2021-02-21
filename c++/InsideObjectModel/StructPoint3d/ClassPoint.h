#pragma once

#include<iostream>
#include<cassert>

template <typename type, int dim>
class Point
{
public:
	Point() = default;
	Point(type coords[dim]):_dim(dim)
	{
		for (int index = 0; index < dim; index++)
		{
			_coords[index] = coords[index];
		}
	}

	type& operator[](int index)
	{
		assert(index < _dim&& index >= 0);
		return _coords[index];
	}

	type operator[](int index) const
	{
		assert(index < _dim&& index >= 0);
		return _coords[index];
	}
	//...etc...
private:
	int _dim;
	type _coords[dim];
};

template<typename type, int dim>
std::ostream& operator << (std::ostream& os, const Point<type, dim>& pt)
{
	os << "(";
	for (int index = 0; index < dim - 1; index++)
		os << pt[index] << ", ";
	os << pt[dim - 1];
	os << ")";

	return os;
}
