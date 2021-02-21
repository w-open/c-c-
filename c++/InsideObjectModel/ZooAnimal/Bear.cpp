#include<iostream>
#include "Bear.h"
Bear::Bear()
{

}

Bear::Bear(string name, int cell_block)
	:ZooAnimal(name), _cell_block(cell_block)
{
	std::cout << "Bear::Bear(string name, int cell_block)" << std::endl;
}

Bear::~Bear() 
{
	std::cout << "Bear::~Bear() " << std::endl;
}

void Bear::rotare()
{
	std::cout << "Bear::rotare()" << std::endl;
}

void Bear::dance()
{
	std::cout << "Bear::dance() " << std::endl;
}