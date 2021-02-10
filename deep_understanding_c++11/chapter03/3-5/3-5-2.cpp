#include<vector>
#include<string>
using namespace std;

enum Gender {boy, girl};
class People {
public:
    People(initializer_list<pair<string, Gender>> l) {
        auto i = l.begin();
        for(; i != l.end(); ++i)
            data.push_back(*i);
    }
private:
    vector<pair<string,Gender>> data;
};

People ship2012 = {{"Garfield", boy}, {"HelloKitty", girl}};
