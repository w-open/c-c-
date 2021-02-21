#include<iostream>
using namespace std;

class String
{
public:
	String(const char ptr[])
	{
		str = (char*)(ptr);
	}

private:
	char* str;
	int len;
};

class Word
{
public:
	Word(const char ptr[]) :_word(ptr)
	{
		_occurs = 1;
	}
	~Word(){}
private:
	int _occurs;
	String _word;
};

int main(int argc, char* argv[])
{
	Word noun("book");
	Word verb = noun;
	return 0;
}