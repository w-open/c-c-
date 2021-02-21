#include<iostream>
using namespace std;

class String
{
public:
	String(const char ptr[])
	{
		str = (char *)(ptr);
	}

private:
	char* str;
	int len;
};

class Word
{
public:

private:
	int _occurs;
	String _word;
};

int main(int argc, char* argv[])
{
	String noun("book");
	String verb = noun;
	return 0;
}