struct Rational: Comparable, Hashable {
    let num: Int
    let den: Int

    init(_ value: Int) {
        num = value
        den = 1
    }

    init(_ num: Int, _ den: Int) {
        precondition(den != 0)
        let sign = den < 0 ? -1 : 1
        let divisor = Rational.gcd(abs(num), abs(den))
        self.num = sign * num / divisor
        self.den = abs(den) / divisor
    }

    var isZero: Bool { num == 0 }
    var isInteger: Bool { den == 1 }
    var intValue: Int { num / den }

    static func gcd(_ a: Int, _ b: Int) -> Int {
        b == 0 ? max(a, 1) : gcd(b, a % b)
    }

    static func / (lhs: Rational, rhs: Rational) -> Rational {
        Rational(lhs.num * rhs.den, lhs.den * rhs.num)
    }

    static func * (lhs: Rational, rhs: Rational) -> Rational {
        Rational(lhs.num * rhs.num, lhs.den * rhs.den)
    }

    static func - (lhs: Rational, rhs: Rational) -> Rational {
        Rational(lhs.num * rhs.den - rhs.num * lhs.den, lhs.den * rhs.den)
    }

    static func + (lhs: Rational, rhs: Rational) -> Rational {
        Rational(lhs.num * rhs.den + rhs.num * lhs.den, lhs.den * rhs.den)
    }

    static func < (lhs: Rational, rhs: Rational) -> Bool {
        lhs.num * rhs.den < rhs.num * lhs.den
    }

    static let zero = Rational(0)
}
