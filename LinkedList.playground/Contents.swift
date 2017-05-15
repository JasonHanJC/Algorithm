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

/*:
 ## Merge Two Sorted Lists
 Merge two sorted linked lists and return it as a new list. The new list should be made by splicing together the nodes of the first two lists.
 
*/

func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    
    let dummyHead = ListNode(0)
    var p = dummyHead
    
    var l1 = l1
    var l2 = l2
    
    while l1 != nil && l2 != nil {
        
        if l1!.val > l2!.val {
            p.next = l2!
            l2 = l2!.next
        } else {
            p.next = l1!
            l1 = l1!.next
        }
        
        p = p.next!
    }
    
    p.next = l1 ?? l2
    
    return dummyHead.next
}

/*:
 ## Merge k Sorted Lists
 
 Merge k sorted linked lists and return it as one sorted list. Analyze and describe its complexity.
 
 Idea: Divide and conquer
 The idea is to pair up K lists and merge each pair in linear time using O(1) space. After first cycle, K/2 lists are left each of size 2*N. After second cycle, K/4 lists are left each of size 4*N and so on. We repeat the procedure until we have only one list left.
 
 */

func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
    
    guard lists.count > 0 else {
        return nil
    }
    
    var left = 0
    var right = lists.count - 1
    
    while right > 0 {
        left = 0
        while left < right {
            lists[left] = mergeTwoLists(lists[left], lists[right])
            left += 1
            right -= 1
        }
    }
    
    return lists[0]
}




