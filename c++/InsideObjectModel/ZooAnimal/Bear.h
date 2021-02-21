#pragma once
#include "ZooAnimal.h"
class Bear: public ZooAnimal
{
public:
	Bear();
	Bear(string name, int cell_block);
	~Bear();

	void rotare();
	virtual void dance();

protected:
	enum Dances{};
	Dances _dance_known;
	int _cell_block;
};

