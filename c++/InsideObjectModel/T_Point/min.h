#pragma once
template <typename Type>
Type min(const Type& t1, const Type& t2)
{
	std::cout << __FUNCTION__ << std::endl << "Type = " << typeid(Type).name() << std::endl;
	return t1;
}
