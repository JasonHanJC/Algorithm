// check a linkedlist isPalindome

// 快慢指针先找到中间，然后翻转后半部分
class Node {
    var val: String
    var next: Node?
    init(_ val: String) {
        self.val = val
        self.next = nil
    }
}

func islinkedListPalindrome(_ head: Node?) -> Bool {
    if head == nil {
        return true
    }

    var s = head, f = head
    while f != nil {
        s = s!.next
        f = f!.next?.next
    }

    // s is the middle
    var r = reverse(s)
    s = head
    while s != nil && r != nil {
        if s!.val != r!.val {
            return false
        }
        s = s!.next
        r = r!.next
    }

    return true
}

func reverse(_ head: Node?) -> Node? {
    var pre: Node? = nil
    var h = head
    while h != nil {
        let next = h!.next
        h!.next = pre
        pre = h

        h = next
    }

    return pre
}

func printList(_ head: Node?) {
    var h = head
    var s = ""
    while h != nil {
        s += h!.val + " -> "
        h = h!.next
    }
    print(s) 
}


let node1 = Node("a")
let node2 = Node("e")
let node3 = Node("r")
let node4 = Node("u")
let node5 = Node("e")
let node6 = Node("a")

node1.next = node2
node2.next = node3
node3.next = node4
node4.next = node5
node5.next = node6

print(islinkedListPalindrome(node1))