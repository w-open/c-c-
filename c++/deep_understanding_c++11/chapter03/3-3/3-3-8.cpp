#include<iostream>
#include<utility>
using namespace std;

struct Maythrow {
    Maythrow() {}
    Maythrow(const Maythrow &) {
        cout << "Maythrow copy constructor." << endl;
    }
    
    Maythrow(Maythrow &&) {
        cout << "Maythrow move constructor." << endl;
    }
};

struct Nothrow {
    Nothrow() {}
    Nothrow(const Nothrow &) noexcept {
        cout << "Nothrow copy constructor." << endl;
    }
    
    Nothrow(Nothrow &&) noexcept {
        cout << "Nothrow move constructor." << endl;
    }
};

int main()
{
    Maythrow m;
    Nothrow n;

    Maythrow mt = move_if_noexcept(m);
    Nothrow nt = move_if_noexcept(n);

    return 0;
}
