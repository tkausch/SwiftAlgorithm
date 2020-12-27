
//: # Generating all Possibilities
//: Our goal in this section is to study methods for running through all of the possibilities in some combinatorial universe, because
//: we often face problems in which an exhaustive examination of all cases is necessary or desirable. For example we want
//: to look at all permutations of a given set.
//:
//: Some authors call this task of *enumerating* or *listing* all of the possibilities. In fact we do not really want to go though all
//: permutations but we want to have them present momentarily in some data structure, so that a program can
//: examine each permution one at a time.
//:
//: So we will speak of *generating* all of the combinatorial objects that we need, and *visiting* each object in turn. Just as
//: we have algorithms for tree traversal, we now look for algorithms that systematically traverse a combinatorial space
//: space of possibilities.

//: ## Generating all n-tuples
//: Let's start small, by considering how to run through all `2^n` strings that consist of n binary digits. Equivalently we want
//: to visit all n-tuples `(a1,...,an)` where each `aj` is either 0 or 1. This task is also, in essence, equivalent to
//: examining all subsets of a given set `{x1,...,xn}`, because we can say that `xj` is in the subset if and only if
//: `aj=1`.
//:
//: Such a problem has a simple solution. All we need to do is start with the binary number `(0...0)2 = 0` and
//: repeatedly add 1 until we reach `(1...11)2 = 2^n-1`.
//:
//: In the first place we can see, that the binary-notation trick extendes to other kind of n-tuples. If we want, for example,
//: to generate all `(a1,...,an)` in which each aj is one of the dicimal digits '{0,1,2,3,4,5,6,7,8,9}', we can simply count
//: from `(0...00)10 = 0` to `(9...99)10 = 10^n-1` in the decimal number system.

public struct Tuple: CustomStringConvertible {
    
    public let a: [Int]
    public let radix: Int
    
    public var  n: Int {
        a.count
    }
    
    init(n: Int, radix: Int) {
        self.a = Array(repeating: 0, count: n)
        self.radix = radix
    }
    
    init(a: [Int], radix: Int) {
        self.a = a
        self.radix = radix
    }
    
    public var description: String {
           return "(" + a.map(String.init).joined(separator: ", ") + ")"
       }
}


extension Tuple {
    
    public struct TupleGenerator: Sequence, IteratorProtocol {
        
        public typealias Element = Tuple
        
        private var t: Tuple?
        
        init(n: Int, radix: Int) {
            self.t = Tuple(a: Array(repeating: 0, count: n), radix: radix)
        }
        
        public mutating func next() -> Tuple? {
            guard let t = self.t else {
                return nil
            }
            let result = t
            self.t = t.addOne()
            return result
        }
        
    }
    
    public func generator() -> TupleGenerator {
        return TupleGenerator(n: a.count, radix: self.radix)
    }
    
    private func addOne() -> Tuple? {
        var piggy = 1
        var result = Array(a.reversed())
        for i in result.indices {
            if piggy == 0 {
                break
            } else {
                let t = piggy + result[i]
                if  t < radix {
                    result[i] = t
                    piggy = 0
                } else {
                    result[i] = 0
                    piggy = 1
                }
            }
        }
        
        if piggy == 1 {
            return nil
        } else {
            return Tuple(a: result.reversed(), radix: radix)
        }
    }
    
}

let t = Tuple(n: 4, radix: 3)
for t in t.generator() {
    print(t)
}

//: The above algorithm is simple and straight forward, but we shouldn't forget that nested loops are even simpler, when `n` is fairly a
//: small constant. When `n = 4` and `radix = 3`  the following is equivalent. These instructions are equal and can be easily expressed.

let m = 0...3
for a1 in m {
    for a2 in m {
        for a3 in m {
            for a4 in m {
                print(Tuple(a: [a1, a2, a3, a4], radix: 3))
            }
        }
    }
}


