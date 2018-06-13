//: Binary Tree Upside down

/*
 Given a binary tree where all the right nodes are either leaf nodes with a sibling (a left node that shares the same parent node) or empty, flip it upside down and turn it into a tree where the original right nodes turned into left leaf nodes. Return the new root.
 For example:
 Given a binary tree {1,2,3,4,5},
     1
    / \
   2   3
  / \
 4   5
 return the root of the binary tree [4,5,2,#,#,3,1].
     4
    / \
   5   2
      / \
     3   1
 */

/*
 transform:
     1             1             4
    / \           /             / \
   2   3  -->    2 - 3   -->   5   2
  / \           /                 / \
 4   5         4 - 5             3   1
 
 */
func upsideDown(_ root: TreeNode?) -> TreeNode? {
    
    if root == nil {
        return nil
    }
    
    var cur: TreeNode? = root
    var next: TreeNode? = nil
    var prev: TreeNode? = nil
    var tempRight: TreeNode? = nil
    
    while cur != nil {
        // store the left
        next = cur!.left
        
        // break the connection
        // set new left
        cur!.left = tempRight
        tempRight = cur!.right
        cur!.right = prev
        
        // move to next
        prev = cur
        cur = next
    }
    return prev
}

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}
