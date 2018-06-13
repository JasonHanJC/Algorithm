//: Binary Tree Level Order Traversal
/*
 Given a binary tree, return the level order traversal of its nodes' values. (ie, from left to right, level by level).
 
 For example:
 Given binary tree [3,9,20,null,null,15,7],
 3
 / \
 9  20
 /  \
 15   7
 return its level order traversal as:
 [
 [3],
 [9,20],
 [15,7]
 ]
 
 Idea: use a queue to store current level
 */

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

func levelOrder(_ root: TreeNode?) -> [[Int]] {
    
    var res = [[Int]]()
    if root == nil {
        return res
    }
    
    var queue = [TreeNode]()
    
    queue.append(root!)
    
    while !queue.isEmpty {
        
        let curSize = queue.count
        var level = [Int]()
        
        for _ in 0..<curSize {
            // Note: not peak but remove the first one
            let curNode = queue.removeFirst()
            
            if curNode.left != nil {
                queue.append(curNode.left!)
            }
            
            if curNode.right != nil {
                queue.append(curNode.right!)
            }
            
            level.append(curNode.val)
        }
        
        res.append(level)
    }
    
    return res
}
