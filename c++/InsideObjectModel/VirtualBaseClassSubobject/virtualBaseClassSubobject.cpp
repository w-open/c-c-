#include<iostream>

using namespace std;

class ZooAnimal {};

class Raccon :public virtual ZooAnimal {
public:
	Raccon() {}
	Raccon(int val) {}
private:
};

class RedPanda :public Raccon {
public:
	RedPanda() {}
	RedPanda(int val) {}
private:

};

int main(int argc, char* argv[])
{
	Raccon racc;

	return 0;
}