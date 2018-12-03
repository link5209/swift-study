
// 使用 Self，让compiler去智能分析


protocol Ordered {
    func precedes(_ other: Self) -> Bool
}

func binarySearch<T: Ordered>(sortedKeys: [T], forKey: T) -> Int {
    var lo = 0
    var hi = sortedKeys.count
    while hi > lo {
        let mid = lo + (hi - lo) / 2
        if sortedKeys[mid].precedes(forKey) {
            lo = mid + 1
        }
        else {
            hi = mid
        }
    }
    return lo
}

extension Int: Ordered {
    func precedes(_ other: Int) -> Bool {
        return self < other
    }
}

print(binarySearch(sortedKeys: [1,2,3], forKey: 3))



class Number: Ordered {
    var value: Int

    init(_ value: Int) {
        self.value = value
    }

    func precedes(_ other: Number) -> Bool {
        return value < other.value
    }
}
let c1 = Number(1)
let c2 = Number(2)
let c3 = Number(3)

print(binarySearch(sortedKeys: [1,2,3], forKey: 3))



// Ordered使用了Self,其实就是 associated type，与Comparable一个道理
// public protocol Comparable : Equatable {

//     /// Returns a Boolean value indicating whether the value of the first
//     /// argument is less than that of the second argument.
//     ///
//     /// This function is the only requirement of the `Comparable` protocol. The
//     /// remainder of the relational operator functions are implemented by the
//     /// standard library for any type that conforms to `Comparable`.
//     ///
//     /// - Parameters:
//     ///   - lhs: A value to compare.
//     ///   - rhs: Another value to compare.
//     public static func < (lhs: Self, rhs: Self) -> Bool
// }


// https://github.com/apple/swift/blob/master/stdlib/public/core/Comparable.swift
// extension Comparable {
//   /// Returns a Boolean value indicating whether the value of the first argument
//   /// is greater than that of the second argument.
//   ///
//   /// This is the default implementation of the greater-than operator (`>`) for
//   /// any type that conforms to `Comparable`.
//   ///
//   /// - Parameters:
//   ///   - lhs: A value to compare.
//   ///   - rhs: Another value to compare.
//   @inlinable
//   public static func > (lhs: Self, rhs: Self) -> Bool {
//     return rhs < lhs // 这里揭示了为什么自定义类型需要自己实现 public static func < (lhs: Self, rhs: Self) -> Bool
//   }
// }

// extension Comparable 的默认实现让swift的内置value type 共享一份实现逻辑


/// You can use special versions of some sequence and collection operations
/// when working with a `Comparable` type. For example, if your array's
/// elements conform to `Comparable`, you can call the `sort()` method without
/// using arguments to sort the elements of your array in ascending order.
///
///     var measurements = [1.1, 1.5, 2.9, 1.2, 1.5, 1.3, 1.2]
///     measurements.sort()
///     print(measurements)
///     // Prints "[1.1, 1.2, 1.2, 1.3, 1.5, 1.5, 2.9]"


// protocol 的多继承, pop
// public protocol Comparable : Equatable {}

// https://github.com/apple/swift/blob/master/stdlib/public/core/Equatable.swift

// public protocol Equatable {
//   /// Returns a Boolean value indicating whether two values are equal.
//   ///
//   /// Equality is the inverse of inequality. For any values `a` and `b`,
//   /// `a == b` implies that `a != b` is `false`.
//   ///
//   /// - Parameters:
//   ///   - lhs: A value to compare.
//   ///   - rhs: Another value to compare.
//   static func == (lhs: Self, rhs: Self) -> Bool
// }

// extension Equatable {
//   /// Returns a Boolean value indicating whether two values are not equal.
//   ///
//   /// Inequality is the inverse of equality. For any values `a` and `b`, `a != b`
//   /// implies that `a == b` is `false`.
//   ///
//   /// This is the default implementation of the not-equal-to operator (`!=`)
//   /// for any type that conforms to `Equatable`.
//   ///
//   /// - Parameters:
//   ///   - lhs: A value to compare.
//   ///   - rhs: Another value to compare.
//   // transparent because sometimes types that use this generate compile-time
//   // warnings, e.g. that an expression always evaluates to true
//   @_transparent
//   public static func != (lhs: Self, rhs: Self) -> Bool {
//     return !(lhs == rhs)
//   }
// }

class StreetAddress {
    let number: String
    let street: String
    let unit: String?
    init(_ number: String, _ street: String, unit: String? = nil) {
        self.number = number
        self.street = street
        self.unit = unit
    }
}

extension StreetAddress: Equatable {
    static func == (lhs: StreetAddress, rhs: StreetAddress) -> Bool {
        return
            lhs.number == rhs.number &&
            lhs.street == rhs.street &&
            lhs.unit == rhs.unit
    }
}
// The `StreetAddress` type now conforms to `Equatable`. You can use `==` to
// check for equality between any two instances or call the
// `Equatable`-constrained `contains(_:)` method.
let addresses = [StreetAddress("1490", "Grove Street"),
                 StreetAddress("2119", "Maple Avenue"),
                 StreetAddress("1400", "16th Street")]
let home = StreetAddress("1400", "16th Street")
print(addresses[0] == home)
// Prints "false"
print(addresses.contains(home))
// Prints "true"


// constraint protocol （addresses.contains(home)）

// extension Array where Element : Equatable {
//     public func contains(_ element: Element) -> Bool
// }




// 链式调用
extension Collection where Element : Ordered, Index == Int {
    
    func binarySearch(forKey: Element) -> Int {
        var lo = 0
        var hi = self.count
        while (hi > lo) {
            let mid = lo + (hi - lo) / 2
            if self[mid].precedes(forKey) {
                lo = mid + 1
            }
            else {
                hi = mid
            }
        }
        return lo
    }
}

print("r2:", [c1,c2,c3].binarySearch(forKey: c3))










