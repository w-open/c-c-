#include <iostream>
#include "ZooAnimal.h"

ZooAnimal::ZooAnimal(string name, int loc)
{
	_name = name;
	_loc = loc;

	std::cout << "ZooAnimal::ZooAnimal()" << std::endl;
}

ZooAnimal::~ZooAnimal()
{
	std::cout << "ZooAnimal::~ZooAnimal()" << std::endl;
}

void ZooAnimal::rotate()
{
	std::cout << "ZooAnimal::rotate()" << std::endl;
}
