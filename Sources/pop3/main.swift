indirect enum LinkedListNode<T> {
    case value(element: T, next: LinkedListNode<T>)
    case end
}

extension LinkedListNode: Sequence {

    func makeIterator() -> LinkedListIterator<T> {
        return LinkedListIterator(current: self)
    }
}

struct LinkedListIterator<T>: IteratorProtocol {
    var current: LinkedListNode<T>

    mutating func next() -> T? {
        switch current {
        case let .value(element, next):
            current = next
            return element
        case .end:
            return nil
        }
    }
}

let thirdNode = LinkedListNode<String>.value(element: "C", next: LinkedListNode<String>.end)
let secondNode = LinkedListNode<String>.value(element: "B", next: thirdNode)
let linkedList = LinkedListNode<String>.value(element: "A", next: secondNode)

for node in linkedList {
    print(node)
}

print(linkedList.map {$0 + "!"})
print(linkedList.filter {$0 < "C"})
print(linkedList.sorted())



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

// generic

func quickSortX<T: Comparable>(input: [T]) -> [T] {
    if let (pivot, rest) = input.decompose {
        let lesser = rest.filter {$0 < pivot}
        let greater = rest.filter {$0 >= pivot}
        return quickSortX(input: lesser) + [pivot] + quickSortX(input: greater)
    }
    else {
        return []
    }
}

print(quickSortX(input: ["d","w","r","a","t","t","a","y","a","e","x"]))



















