#pragma once
#include<string>

using namespace std;

class ZooAnimal
{
public:
	ZooAnimal() = default;
	ZooAnimal(string name, int loc = 0);
	virtual ~ZooAnimal();
	
	virtual void rotate();

protected:
	int _loc;
	string _name;
};

