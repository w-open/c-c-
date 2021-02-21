class PI {
public:
    double operator*(float v) {
        return (double)val*v;
    }
    const float val = 3.1415927f;
};

int main() {
    float radius = 1.7e10;
    PI pi;
    auto circumference = 2 * (pi * radius);
}
