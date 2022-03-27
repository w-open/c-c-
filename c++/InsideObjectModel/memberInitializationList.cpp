#include<iostream>
class X {
public:
	X(int val): j(val), i(j) { } //有陷阱的写法
	void print() { std::cout << i << "\t" << j << std::endl; }
private:
	int i;
	int j;
};

class Y {
public:
	Y(int val) : j(val) { i = j; } //修改后的写法
	void print() { std::cout << i << "\t" << j << std::endl; }
private:
	int i;
	int j;
};

int main(int argc, char* argv[])
{
	X x{ 3 };
	Y y{ 5 };

	x.print();
	y.print();

	return 0;
}