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
print(linkedList.sorted(by: >))
