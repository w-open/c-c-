#include<iostream>
using namespace std;

class ZooAnimal
{
public:
	ZooAnimal() { cout << __FUNCTION__ << endl; }
	virtual ~ZooAnimal() { cout << __FUNCTION__ << endl; }
	virtual void draw() const { cout << __FUNCTION__ << endl; }
	virtual void animate() { cout << __FUNCTION__ << endl; }
private:
};

class Bear : public ZooAnimal
{
public:
	Bear() { cout << __FUNCTION__ << endl; }
	~Bear() { cout << __FUNCTION__ << endl; }
	void draw() const { cout << __FUNCTION__ << endl; }
	void animate() { cout << __FUNCTION__ << endl; }
	
	virtual void dance() { cout << __FUNCTION__ << endl; }
private:
};

void draw(const ZooAnimal &zoey) { zoey.draw(); }



void foo()
{
	Bear yogi;
	ZooAnimal franny = yogi;
	draw(yogi);
	draw(franny);
}

int main(int argc, char* argv[])
{
	
	ZooAnimal zoo;
	Bear yogi;

	yogi.dance();
	
	Bear winnie = yogi;

	foo();

	return 0;
}