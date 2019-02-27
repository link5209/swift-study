
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

        // 这里揭示了为什么自定义类型需要自己实现 public static func < (lhs: Self, rhs: Self) -> Bool
        // 逻辑学，所有的Comparable函数实现都通过 < 函数定义推导
        // extension 提供所有遵守了Comparable的类型的默认实现
//   @inlinable
//   public static func > (lhs: Self, rhs: Self) -> Bool {
//     return rhs < lhs
//   }
// }


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
// 使得protocols更加小巧，紧凑
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
//   // transparent because sometimes types that use this generate compile-time
//   // warnings, e.g. that an expression always evaluates to true
//   @_transparent
//   public static func != (lhs: Self, rhs: Self) -> Bool {
//     return !(lhs == rhs)
//   }
// }


// Equatable的实现和应用
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

let addresses = [StreetAddress("1490", "Grove Street"),
                 StreetAddress("2119", "Maple Avenue"),
                 StreetAddress("1400", "16th Street")]
let home = StreetAddress("1400", "16th Street")
print(addresses[0] == home)
// Prints "false"
print(addresses.contains(home))
// Prints "true"


// extension constrained by protocol （addresses.contains(home)）

// extension Array where Element : Equatable {
//     public func contains(_ element: Element) -> Bool
// }


// https://github.com/apple/swift/blob/master/stdlib/public/core/SequenceAlgorithms.swift

// extension Sequence where Element : Equatable {
//   @inlinable
//   public func contains(_ element: Element) -> Bool {
//     if let result = _customContainsEquatableElement(element) {
//       return result
//     } else {
//       return self.contains { $0 == element }
//     }
//   }
// }


// Element 是个什么鬼？see below 👇

// public struct Array<Element> {

// }



// quickSort
extension Array {
    var decompose: (head: Element, tail: [Element])? {
        return count > 0 ? (self[0], Array(self[1..<count])) : nil
    }
}

func quickSort(input: [Int]) -> [Int] {
    if let (pivot, rest) = input.decompose {
        let lesser = rest.filter {$0 < pivot}
        let greater = rest.filter {$0 >= pivot}
        return quickSort(input: lesser) + [pivot] + quickSort(input: greater)
    }
    else {
        return []
    }
}

print(quickSort(input: [5,78,35,24,26,2,6,7,5,2,7,4]))


// self[1..<count] 使用了下面的方法👇
// extension Array : RandomAccessCollection, MutableCollection {
//     public subscript(bounds: Range<Int>) -> ArraySlice<Element> {

//     }
// }



/// A slice of an `Array`, `ContiguousArray`, or `ArraySlice` instance.
///
/// The `ArraySlice` type makes it fast and efficient for you to perform
/// operations on sections of a larger array. Instead of copying over the
/// elements of a slice to new storage, an `ArraySlice` instance presents a
/// view onto the storage of a larger array. And because `ArraySlice`
/// presents the same interface as `Array`, you can generally perform the
/// same operations on a slice as you could on the original array.
///
/// For more information about using arrays, see `Array` and `ContiguousArray`,
/// with which `ArraySlice` shares most properties and methods.
///
/// Slices Are Views onto Arrays
// public struct ArraySlice<Element> {

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



// extension Collection where Element : Ordered, Index == Int
// 利用了 associatedtype 的能力























