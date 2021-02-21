#include<iostream>

#include "ZooAnimal.h"
#include "Bear.h"

int main(int argc, char* argv[])
{
	std::cout << "/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/\n " << std::endl;
	ZooAnimal za(string("Zoey"));
	ZooAnimal* pza = &za;

	std::cout << "/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/\n " << std::endl;
	Bear b(string("Yogi"), 5);
	Bear* pb = &b;
	Bear& rb = *pb;

	std::cout << "/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/\n " << std::endl;
	Bear b1;
	ZooAnimal za1 = b1;
	za1.rotate();

	std::cout << "\n/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/\n " << std::endl;
	return 0;
}