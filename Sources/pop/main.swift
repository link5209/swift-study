
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

// print("r0:", binarySearch(sortedKeys: [1,2,3], forKey: 3))

// binarySearch(sortedKeys: [1.0,2.0,3.0], forKey: 3.0)

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

print("r0 Int:", binarySearchX(sortedKeys: [1,2,3], forKey: 3))


extension Double: Ordered {
    func precedes(_ other: Ordered) -> Bool {
        return self < (other as! Double).self
    }
}

print("r0 Double:", binarySearchX(sortedKeys: [1.0,2.0,3.0], forKey: 3.0))

