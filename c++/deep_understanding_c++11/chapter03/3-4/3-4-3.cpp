class ConvertTo {};
class Convertable {
public:
    explicit operator ConvertTo() const { return ConvertTo(); }
};

void Func(ConvertTo ct) {}
void test() {
    Convertable c;
    ConvertTo ct(c);
    ConvertTo ct2 = c;
    ConvertTo ct3 = static_cast<ConvertTo>(c);
    Func(c);
}

