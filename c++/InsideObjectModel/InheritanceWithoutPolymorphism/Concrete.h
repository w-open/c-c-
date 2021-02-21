class Concrete {
public:

private:
	int val;
	char c1;
	char c2;
	char c3;
};

class Concrete1 {
public:

private:
	int val;
	char c1;

};

class Concrete2: public Concrete1 {
public:

private:
	char c2;
};

class Concrete3 : public Concrete2 {
public:

private:
	char c3;
};