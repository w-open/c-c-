#include<iostream>
class X {
public:
	X(int val): j(val), i(j) { } //�������д��
	void print() { std::cout << i << "\t" << j << std::endl; }
private:
	int i;
	int j;
};

class Y {
public:
	Y(int val) : j(val) { i = j; } //�޸ĺ��д��
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