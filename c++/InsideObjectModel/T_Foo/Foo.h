#pragma once
template <class Type>
class Foo
{
public:
	Foo() {}
	~Foo() {}
	Type val() {}
	void val(Type v) {}
	
	//template<class Type>
	double bogus_member(Type );
private:
	Type _val;
};

template<class Type>
double Foo<Type>:: bogus_member(Type val)
{
	return this->dbx;
}