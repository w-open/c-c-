#include<iostream>

#include"ScopeRules.h"

using namespace std;

int foo(int a) {
	cout << "foo(int a)..." << endl;
	return 0;
}

double foo(double d) {
	cout << "foo(double d)..." << endl;
	return 0.0;
}

int main() {
	ScopeRules<int> sr0;

	// scope of the template instantion
	sr0.invariant();

	sr0.type_dependent();

	return 0;
}