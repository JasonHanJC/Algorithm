//: Minimum Depth of Binary Tree
// For every node, check if it is a leaf node. If yes, then return 1. If not leaf node then if left subtree is NULL, then recur for right subtree. And if right subtree is NULL, then recur for left subtree. If both left and right subtrees are not NULL, then take the minimum of two heights.

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

func minDepth(_ root: TreeNode?) -> Int {
    
    if root == nil {
        return 0
    }
    
    if root?.left == nil && root?.right == nil {
        return 1
    }
    
    if root?.left == nil {
        return 1 + minDepth(root?.right)
    }
    
    if root?.right == nil {
        return 1 + minDepth(root?.left)
    }
    
    return 1 + min(minDepth(root?.left), minDepth(root?.right))
}

