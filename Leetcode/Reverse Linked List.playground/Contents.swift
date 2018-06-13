//: Reverse Linked List
/*
 Reverse a singly linked list.
 */

class ListNode {
    var val: Int
    var next: ListNode?
    init(val: Int) {
        self.val = val
        self.next = nil
        
    }
}

func reverseList(_ head: ListNode?) -> ListNode? {
    if head == nil {
        return head
    }
    
    var newHead: ListNode? = nil
    var head = head
    
    while head != nil {
        
        let next = head!.next
        head!.next = newHead
        newHead = head
        
        head = next
        
    }
    
    return newHead
}


func reverseListR(_ head: ListNode?) -> ListNode? {
    if head == nil {
        return head
    }
    var newHead: ListNode? = nil
    return reverse(head, &newHead)
}

func reverse(_ head: ListNode?, _ newHead: inout ListNode?) -> ListNode? {
    if head == nil {
        return newHead
    }
    let next = head!.next
    head!.next = newHead
    newHead = head
    return reverse(next, &newHead)
}
