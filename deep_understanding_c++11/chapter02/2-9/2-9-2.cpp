class P;
template <typename T> class People {
    friend T;
};

People<P> pp;
People<int> pi;
