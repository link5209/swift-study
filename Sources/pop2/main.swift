     // struct Countdown: Sequence, IteratorProtocol {
     //     var count: Int

     //     mutating func next() -> Int? {
     //         if count == 0 {
     //             return nil
     //         } else {
     //             defer { count -= 1 }
     //             return count
     //         }
     //     }
     // }

     // let threeToGo = Countdown(count: 3)
     // for i in threeToGo {
     //     print(i)
     // }



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




// protocol associated type, Self 的超集，


