// 1. 翻转列表k pair
// “链表翻转。给出一个链表和一个数k，比如链表1→2→3→4→5→6，k=2，则翻转后2→1→4→3→6→5，若k=3,翻转后3→2→1→6→5→4，若k=4，翻转后4→3→2→1→6→5，用程序实现。”

class Node {
    var val: Int
    var next: Node?
    init(_ val: Int, _ next: Node? = nil) {
        self.val = val
        self.next = next
    }
}

// flip list by k pair
func flip(_ head: Node?, _ k: Int) -> Node? {
    
    if (head == nil || k <= 1) {
        return head
    }
    let dummyHead = Node(-1)
    var h1 = head, h2 = head, n = 1
    while(h2 != nil && h2!.next != nil) {
        if n == k {
            let nextH1 = h2!.next
            h2?.next = nil
            appendNodes(dummyHead, reverse(h1));
            h2 = nextH1
            h1 = nextH1
            n = 1
        }
        n += 1
        h2 = h2!.next
    }
    appendNodes(dummyHead, reverse(h1));
    return dummyHead.next
}

func appendNodes(_ head: Node, _ a: Node?) {
    var head = head
    while head.next != nil {
        head = head.next!
    }
    head.next = a
}

// reverse list
func reverse(_ head: Node?) -> Node? {
    var pre: Node? = nil
    var h = head
    while(h != nil) {
        let next = h!.next
        
        h!.next = pre
        pre = h!
        
        h = next
    }
    return pre
}

func printList(_ head: Node?) {
    var listString = "";
    var head = head
    while(head != nil) {
        listString += "\(head!.val) -> ";
        head = head!.next
    }
    print(listString)
}

let node5 = Node(5);
let node4 = Node(4, node5)
let node3 = Node(3, node4)
let node2 = Node(2, node3)
let node1 = Node(1, node2)
printList(node1)
printList(flip(node1, 5))
