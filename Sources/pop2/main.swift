// Comparable 实现

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

// let arr = [3.0, 4.1, 5.0]
print("r0:", binarySearch(sortedKeys: [2.1,3.4, 4.0], forKey: 4.0))


extension Collection where Element : Comparable, Index == Int {

   public func binarySearch(forKey: Element) -> Int {
       var lo = 0
       var hi = self.count
       while (hi > lo) {
           let mid = lo + (hi - lo) / 2
           if self[mid] < forKey {
               lo = mid + 1
           }
           else {
               hi = mid
           }
       }
       return lo
   }
}

print("r1:", [2.1,3.4, 4.0].binarySearch(forKey: 4.0))


// 实现 comparable
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

print("r2:", [c1,c2,c3].binarySearch(forKey: c1))




// protocol associated type, Self 的超集，


