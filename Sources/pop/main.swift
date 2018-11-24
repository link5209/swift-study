// extension Collection where Element : Equatable {  
//     public func indexOf(element: Element) -> Index? {  
//         for i in self.indices {  
//             if self[i] == element {  
//                 return i  
//             }  
//         }  
//         return nil  
//     }  
// }


// protocol Ordered {
//     func precedes(_ other: Self) -> Bool
// }

// func binarySearch<T: Ordered>(sortedKeys: [T], forKey k: T) -> Int {
//     var lo = 0
//     var hi = sortedKeys.count
//     while (hi > lo) {
//         let mid = lo + (hi - lo) / 2
//         if sortedKeys[mid].precedes(k) {
//         // if sortedKeys[mid] < k {
//             lo = mid + 1
//         }
//         else {
//             hi = mid
//         }
//     }
//     return lo
// }

class Number: Comparable {
    var value: Double = 0

    static func < (lhs: Number, rhs: Number) -> Bool {
        return lhs.value < rhs.value
    }

    static func == (lhs: Number, rhs: Number) -> Bool {
        return lhs.value == rhs.value
    }
}

let c1 = Number()
let c2 = Number()
c2.value = 2
let c3 = Number()
c3.value = 3

// let bs = binarySearch(sortedKeys: [c1,c2,c3], forKey: c3)
// print("res:", bs);



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

let arr = [3.0, 4.1, 5.0]

// print(binarySearch(sortedKeys: arr, forKey: 5.0))
let bs = binarySearch(sortedKeys: [c1,c2,c3], forKey: c2)
print("res:", bs)

