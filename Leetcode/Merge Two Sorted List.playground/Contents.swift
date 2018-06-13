//: Merge Two Sorted Lists
// Merge two sorted linked lists and return it as a new list. The new list should be made by splicing together the nodes of the first two lists.

class ListNode {
    var val: Int
    var next: ListNode?
    init(val: Int) {
        self.val = val
        self.next = nil
    }
}

func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    
    if l1 == nil {
        return l2
    }
    
    if l2 == nil {
        return l1
    }
    
    let dummy = ListNode(val: 0)
    var tail = dummy
    var l1 = l1, l2 = l2
    
    while l1 != nil && l2 != nil {
        if l1!.val < l2!.val {
            tail.next = l1
            l1 = l1!.next
        } else {
            tail.next = l2
            l2 = l2!.next
        }
        tail = tail.next!
    }
    
    tail.next = l1 != nil ? l1 : l2
    
    return dummy.next
}
