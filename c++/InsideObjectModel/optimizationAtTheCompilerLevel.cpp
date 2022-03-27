#include<iostream>
#include<ctime>

using namespace std;

class Test {
	friend Test foo(double);
public:
	Test() { memset(array, 0, 100 * sizeof(double)); }
	Test(const Test& t) { memcpy(this, &t, sizeof(Test)); }
private:
	double array[100];
};

Test foo(double val)
{
	Test local;

	local.array[0] = val;
	local.array[99] = val;
	
	return local;
}

int main(int argc, char* argv[])
{
	clock_t timeStart = clock();
	for (int cnt = 0; cnt < 10000000; cnt++)
	{
		Test t = foo(double(cnt));
	}

	clock_t timeEnd = clock();
	cout << "run time is:" << (double(timeEnd) - timeStart)/CLOCKS_PER_SEC << endl;

	return 0;
}