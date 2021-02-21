#include<map>
using namespace std;

int hash(char *);

map<char *, decltype(hash)> dict_key;
map<char *, decltype(hash(nullptr))> dict_key1;

