
func binarySearch<T: Comparable>(sortedKeys: [T], forKey k: T) -> Int {
    var lo = 0
    var hi = sortedKeys.count
    while (hi > lo) {
        let mid = lo + (hi - lo) / 2
        // if sortedKeys[mid].precedes(k) {
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
let bs = binarySearch(sortedKeys: [2.1,3.4, 4.0], forKey: 4.0)
print("res:", bs)


//extension Collection where Element : Comparable, Index == Int {
//
//    public func binarySearch(forKey: Element) -> Int {
//        var lo = 0
//        var hi = self.count
//        while (hi > lo) {
//            let mid = lo + (hi - lo) / 2
//            if self[mid] < forKey {
//                lo = mid + 1
//            }
//            else {
//                hi = mid
//            }
//        }
//        return lo
//    }
//}
//
//let r2 = [2.1,3.4, 4.0].binarySearch(forKey: 3.4)
//print("r2:", r2)
//
//
//
// class Number: Comparable {
//     var value: Double = 0
//
//     init(_ value: Double) {
//         self.value = value
//     }
//
//     static func < (lhs: Number, rhs: Number) -> Bool {
//         return lhs.value < rhs.value
//     }
//
//     static func == (lhs: Number, rhs: Number) -> Bool {
//         return lhs.value == rhs.value
//     }
// }
//
// let c1 = Number(1)
// let c2 = Number(2)
// let c3 = Number(3)
//
//let r3 = [c1,c2,c3].binarySearch(forKey: c3)
//print("r3:", r3)


protocol Ordered {
    func precedes(_ other: Self) -> Bool
}

func binarySearch<T: Ordered>(sortedKeys: [T], forKey k: T) -> Int {
    var lo = 0
    var hi = sortedKeys.count
    while (hi > lo) {
        let mid = lo + (hi - lo) / 2
        if sortedKeys[mid].precedes(k) {
//        if sortedKeys[mid] < k {
            lo = mid + 1
        }
        else {
            hi = mid
        }
    }
    return lo
}

class Number: Ordered {
     var value: Double = 0

     init(_ value: Double) {
         self.value = value
     }

    func precedes(_ other: Number) -> Bool {
        return value < other.value
    }
 }

 let c1 = Number(1)
 let c2 = Number(2)
 let c3 = Number(3)

let r1 = binarySearch(sortedKeys: [c1,c2,c3], forKey: c3)
print("r1:", r1)


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

let r4 = [c1,c2,c3].binarySearch(forKey: c2)
print("r4:", r4)

