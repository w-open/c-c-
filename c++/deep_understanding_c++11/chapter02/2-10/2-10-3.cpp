struct Base {
    virtual void Turing() = 0;
    virtual void dijkstra() = 0;
    virtual void VNeumann(int g) = 0;
    virtual void DKnuth() const;
    void Print();
};

struct DerivedMid: public Base {
    // void VNeumann(double g);
    //
};

struct DerivedTop: public DerivedMid {
    void Turing() override;
    void Dikjstra() override;
    void VNeumann(double g) override;
    void DKnuth() override;
    void Print() override;
};
