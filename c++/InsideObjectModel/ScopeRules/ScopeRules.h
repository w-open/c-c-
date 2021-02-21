#pragma once
//scope of the template definition

extern double foo(double);

template<class Type>
class ScopeRules
{
public:
	void invariant() {
		_member = foo(_val);
	}

	Type type_dependent() {
		return foo(_member);
	}

private:
	int _val;
	Type _member;
};
