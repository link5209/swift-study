
func binarySearch(sortedKeys: [Int], forKey: Int) -> Int {
    var lo = 0
    var hi = sortedKeys.count
    while hi > lo {
        let mid = lo + (hi - lo) / 2
        if sortedKeys[mid] < forKey {
            lo = mid + 1
        }
        else {
            hi = mid
        }
    }
    return lo
}

print(binarySearch(sortedKeys: [1,2,3], forKey: 3))



// Generic&Comparable 实现
func binarySearch<T: Comparable>(sortedKeys: [T], forKey k: T) -> Int {
    var lo = 0
    var hi = sortedKeys.count
    while (hi > lo) {
        let mid = lo + (hi - lo) / 2
        if sortedKeys[mid] < k {
            lo = mid + 1
        }
        else {
            hi = mid
        }
    }
    return lo
}

print(binarySearch(sortedKeys: [1.0,2.0,3.0], forKey: 3.0))
print(binarySearch(sortedKeys: [1,2,3], forKey: 3))



// class 实现 comparable
class Number: Comparable {
    var value: Double = 0

    init(_ value: Double) {
        self.value = value
    }

    static func < (lhs: Number, rhs: Number) -> Bool {
        return lhs.value < rhs.value
    }

    static func == (lhs: Number, rhs: Number) -> Bool {
        return lhs.value == rhs.value
    }
}

let c1 = Number(1)
let c2 = Number(2)
let c3 = Number(3)

print(binarySearch(sortedKeys: [c1,c2,c3], forKey: c3))




// 使用 protocol，以此兼容各种实现了该protocol的对象都可以使用该函数，提高复用层次

protocol Ordered {
    func precedes(_ other: Ordered) -> Bool
}

func binarySearchX(sortedKeys: [Ordered], forKey: Ordered) -> Int {
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
    func precedes(_ other: Ordered) -> Bool {
        return self < (other as! Int).self
    }
}

print(binarySearchX(sortedKeys: [1,2,3], forKey: 3))


extension Double: Ordered {
    func precedes(_ other: Ordered) -> Bool {
        return self < (other as! Double).self
    }
}

extension Number: Ordered {
    func precedes(_ other: Ordered) -> Bool {
        return self.value < (other as! Number).value
    }
}

let _c1 = Number(1)
let _c2 = Number(2)
let _c3 = Number(3)

print(binarySearchX(sortedKeys: [_c1, _c2, _c3], forKey: _c3))









