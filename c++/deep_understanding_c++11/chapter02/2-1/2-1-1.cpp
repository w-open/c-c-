#include<iostream>
using namespace std;

int main(int argc, char *argv[])
{
    cout << "Standard Clib: " << __STDC_HOSTED__ << endl;
    cout << "Standard C: " << __STDC__ << endl;
    cout << "ISO/IEC" << __STDC_ISO_10646__ << endl;
   // cout << "C Standard version: " << __STDC_VERSION__ << endl;
    return 0;    
}
