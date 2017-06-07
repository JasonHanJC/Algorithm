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
    
    var lists = lists
    
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

/*:
 ## Odd Even Linked List
 Given a singly linked list, group all odd nodes together followed by the even nodes. Please note here we are talking about the node number and not the value in the nodes.
 
 You should try to do it in place. The program should run in O(1) space complexity and O(nodes) time complexity.
 
 Example:
 Given 1->2->3->4->5->NULL,
 return 1->3->5->2->4->NULL.
 
 Note:
 The relative order inside both the even and odd groups should remain as it was in the input.
 The first node is considered odd, the second node even and so on ...
 
 Idea: use a node to store the odd head and a node to store the even head. Iterate the linked list, link the odd node to the odd head, link the even node to even head. Finaly, link the even head to the odd tail.
 */

func oddEvenList(_ head: ListNode?) -> ListNode? {
    
    if head == nil || head!.next == nil || head!.next!.next == nil {
        return head
    }
    
    var odd = head
    let evenHead = head!.next
    var even = head!.next
    
    while even != nil && even!.next != nil {
        odd!.next = odd!.next!.next
        even!.next = even!.next!.next
        
        odd = odd!.next
        even = even!.next
    }
    odd!.next = evenHead
    
    return head;
}

/*:
 ## Palindrome Linked List
 Given a singly linked list, determine if it is a palindrome.
 
 Follow up:
 Could you do it in O(n) time and O(1) space?

 Idea: Revise the right half of the list, the campare the left part and right part.
 */

func isPalindrome(_ head: ListNode?) -> Bool {
    
    if head == nil || head!.next == nil {
        return true
    }
    
    var slow = head, fast = head
    
    while fast != nil && fast!.next != nil {
        slow = slow!.next
        fast = fast!.next!.next
    }
    
    var revisedRight = reverseList(slow)
    
    slow = head
    
    while revisedRight != nil && slow != nil {
        if revisedRight!.val != slow!.val {
            return false
        }
        revisedRight = revisedRight!.next
        slow = slow!.next
    }
    
    return true
}

/*:
 ## Partition List
 Given a linked list and a value x, partition it such that all nodes less than x come before nodes greater than or equal to x.
 
 You should preserve the original relative order of the nodes in each of the two partitions.
 
 For example,
 Given 1->4->3->2->5->2 and x = 3,
 return 1->2->2->4->3->5.
 */

func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
    
    if head == nil || head!.next == nil {
        return head
    }
    
    let smallHead = ListNode(0), greatHead = ListNode(0)
    var s = smallHead, g = greatHead
    
    var head = head
    
    while head != nil {
        if head!.val < x {
            s.next = head
            s = s.next!
        } else {
            g.next = head
            g = g.next!
        }
        
        head = head!.next
    }
    
    // Don't forget to set nil to the last node.next
    g.next = nil
    s.next = greatHead.next
    
    return smallHead.next
}

/*:
 ## Remove Duplicates from Sorted List
 Given a sorted linked list, delete all duplicates such that each element appear only once.
 
 For example,
 Given 1->1->2, return 1->2.
 Given 1->1->2->3->3, return 1->2->3.
 
 */

func deleteDuplicates(_ head: ListNode?) -> ListNode? {
    
    var node = head
    
    while node != nil && node!.next != nil {
        if node!.val == node!.next!.val {
            node!.next = node!.next!.next
        } else {
            node = node!.next
        }
    }
    
    return head
}

/*:
 ## Remove Duplicates from Sorted List II
 Given a sorted linked list, delete all duplicates such that each element appear only once.
 
 Given a sorted linked list, delete all nodes that have duplicate numbers, leaving only distinct numbers from the original list.
 
 For example,
 Given 1->2->3->3->4->4->5, return 1->2->5.
 Given 1->1->1->2->3, return 2->3.
 
 */

func deleteDuplicatesII(_ head: ListNode?) -> ListNode? {
    if head == nil || head!.next == nil {
        return head
    }
    
    let dummyHead = ListNode(0)
    dummyHead.next = head
    var d = dummyHead
    
    while d.next != nil && d.next!.next != nil {
        if d.next!.val == d.next!.next!.val {
            let pre = d.next!
            while d.next != nil && d.next!.val == pre.val  {
                d.next = d.next!.next
            }
        } else {
            d = d.next!
        }
    }
    
    return dummyHead.next
}

/*:
 ## Remove Nth Node From End of List
 Given a linked list, remove the nth node from the end of list and return its head.
 
 For example,
 
 Given linked list: 1->2->3->4->5, and n = 2.
 
 After removing the second node from the end, the linked list becomes 1->2->3->5.
 Note:
 Given n will always be valid.
 Try to do this in one pass.
 
 Idea: fast and slow pointers, create a n step gap between slow and fast. move slow and fast together until fast = nil, then slow is the point you want.
 
 Example:
 n = 2
 
 || - || - || - || - || - || - nil
                ^               ^
                slow           fast
 */

func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
    let dummy = ListNode(0)
    dummy.next = head
    var prev: ListNode? = dummy
    var post: ListNode? = dummy
    
    // move post
    for _ in 0 ..< n {
        post = post!.next
    }
    
    // move prev and post at the same time
    while post!.next != nil {
        prev = prev!.next
        post = post!.next
    }
    
    prev!.next = prev!.next!.next
    
    return dummy.next
}

/*:
 ## Reorder List
 Given a singly linked list L: L0→L1→…→Ln-1→Ln,
 reorder it to: L0→Ln→L1→Ln-1→L2→Ln-2→…
 
 You must do this in-place without altering the nodes' values.
 
 For example,
 Given {1,2,3,4}, reorder it to {1,4,2,3}.
 
 Idea: Find the middle node, reverse the second half list, then merge two lists
 */

func reorderList(_ head: ListNode?) {
    
    if head == nil || head!.next == nil {
        return
    }

    var slow = head, fast = head
    
    // find the second half
    while fast != nil && fast!.next != nil {
        slow = slow!.next
        fast = fast!.next!.next
    }
    
    var second = slow!.next
    slow!.next = nil
    
    var first = head
    
    // reverse the second
    second = reverseList(second)
    
    while first != nil && second != nil {
        let fNext = first!.next
        let sNext = second!.next
        
        first!.next = second
        second!.next = fNext
        
        first = fNext
        second = sNext
    }
}

/*:
 ## Reverse Nodes in k-Group
 Given a linked list, reverse the nodes of a linked list k at a time and return its modified list.
 
 k is a positive integer and is less than or equal to the length of the linked list. If the number of nodes is not a multiple of k then left-out nodes in the end should remain as it is.
 
 You may not alter the values in the nodes, only nodes itself may be changed.
 
 Only constant memory is allowed.
 
 For example,
 Given this linked list: 1->2->3->4->5
 
 For k = 2, you should return: 2->1->4->3->5
 
 For k = 3, you should return: 3->2->1->4->5

 */

func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
    
    if head == nil || head!.next == nil {
        return head
    }
    
    let dummyHead = ListNode(0)
    dummyHead.next = head
    var p = dummyHead
    var prev = head, post = head
    
    while post != nil {
        
        var i = 0
        while post != nil && i != k - 1 {
            post = post!.next
            i += 1
        }
        
        if i != k - 1 || post == nil {
            break
        }
        
        let rest = post!.next
        post!.next = nil
        
        p.next = reverseList(prev)
        p = prev!
        p.next = rest
        prev = rest
        post = rest
    }
    
    return dummyHead.next
}

/*:
 ## Rotate List
 Given a list, rotate the list to the right by k places, where k is non-negative.
 
 For example:
 Given 1->2->3->4->5->NULL and k = 2,
 return 4->5->1->2->3->NULL.
 
 Note: k could be greater than the length of the list.
 */

func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
    
    if head == nil {
        return head
    }
    
    var prev = head
    var post = head
    let len = getLength(head)
    var k = k % len
    
    // create the k gap
    while k > 0 {
        post = post!.next
        k -= 1
    }
    
    while post != nil && post!.next != nil {
        post = post!.next
        prev = prev!.next
    }
    
    // make new head
    post!.next = head
    let newhead = prev!.next
    prev!.next = nil
    
    return newhead
}

func getLength(_ head: ListNode?) -> Int {
    
    var len = 0
    var p = head
    
    while p != nil {
        p = p!.next
        len += 1
    }
    
    return len
}



