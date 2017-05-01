//: Playground - noun: a place where people can play

import UIKit



/**
 ## Add Two Numbers
 * Primary idea: use carry and iterate through both linked lists
 * Time Complexity: O(n), Space Complexity: O(1)
 *
 * Definition for singly-linked list.
 */

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}


func addTwoNumbers(l1: ListNode?, l2: ListNode?) -> ListNode? {
    
    var sum = 0, carry = 0
    
    let dummyHead = ListNode(0)
    var node = dummyHead
    var l1 = l1
    var l2 = l2
    
    while l1 != nil || l2 != nil || carry != 0 {
        sum = carry
        
        if l1 != nil {
            sum += l1!.val
            l1 = l1!.next
        }
        
        if l2 != nil {
            sum += l2!.val
            l2 = l2!.next
        }
        
        carry = sum / 10
        sum = sum % 10
        
        node.next = ListNode(sum)
        node = node.next!
    }
    
    return dummyHead.next
}


/*:
 ## Reverse Linked List
 Reverse a singly linked list.
 */

func reverseList(_ head: ListNode?) -> ListNode? {
    
    if head == nil || head?.next == nil {
        return head
    }
    
    var head = head
    let dummyhead = ListNode(0)
    
    while head != nil {
        
        let next = head!.next
        
        head!.next = dummyhead.next
        dummyhead.next = head
        
        head = next
    
    }
    
    
    return dummyhead.next
}





