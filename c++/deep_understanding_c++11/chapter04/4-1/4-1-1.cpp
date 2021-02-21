template <int i> class X{};
template <class T> class Y{};

Y<X<1> > x1;
Y<X<2>> x2;
