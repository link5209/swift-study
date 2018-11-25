
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

print("r0:", binarySearch(sortedKeys: [1,2,3], forKey: 3))



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

print("r1:", binarySearch(sortedKeys: [1,2,3], forKey: 3))


// 链式调用

extension Collection where Element : Ordered, Index == Int {
    
    func binarySearch(forKey k: Element) -> Int {
        var lo = 0
        var hi = self.count
        while (hi > lo) {
            let mid = lo + (hi - lo) / 2
            if self[mid].precedes(k) {
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

