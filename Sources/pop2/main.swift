
// Sequence

struct Countdown: Sequence, IteratorProtocol {
    var count: Int

    mutating func next() -> Int? {
        if count == 0 {
            return nil
        } else {
            defer { count -= 1 }
            return count
        }
    }
}

// let threeToGo = Countdown(count: 3)
// for i in threeToGo {
//     print(i)
// }


// LinkedList
class Node {
    let value: Any
    var next: Node?

    init(value: Any, next: Node?) {
        self.value = value
        self.next = next
    }
}

class LinkedList: Sequence {
    var head: Node?

    func makeIterator() -> LinkedListIterator {
        return LinkedListIterator(self)
    }
}

struct LinkedListIterator: IteratorProtocol {
    var current: Node?

    init(_ linkedList: LinkedList) {
        self.current = linkedList.head
    }

    mutating func next() -> Node? {
        if let thisCurrent = current {
            current = thisCurrent.next
            return thisCurrent
        }
        else {
            return nil
        }
    }
}

let node3 = Node(value: 3, next: nil)
let node2 = Node(value: 2, next: node3)
let node1 = Node(value: 1, next: node2)

let linkedList = LinkedList()
linkedList.head = node1

for node in linkedList {
    print(node.value)
}


// map,reduce,filter
print(linkedList.map {($0.value as! Int) * 2})

for node in (linkedList.filter {($0.value as! Int) < 3}) {
    print(node.value)
}


var numbers = [1, 2, 3, 4, 5]
numbers.append(44)

protocol abc {
    var a: Int {get}
}


// protocol associated type, Self 的超集，


