
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

/*: Balanced Binary Tree
 Given a binary tree, determine if it is height-balanced.
 
 For this problem, a height-balanced binary tree is defined as a binary tree in which the depth of the two subtrees of every node never differ by more than 1.

 */

func isBalanced(_ root: TreeNode?) -> Bool {
    
    return checkHeight(root) != -1
}

func checkHeight(_ root: TreeNode?) -> Int {
    
    if root == nil {
        return 0
    }
    
    let left = checkHeight(root?.left)
    let right = checkHeight(root?.right)
    
    if left == -1 || right == -1 {
        return -1
    }
    
    if abs(left - right) > 1 {
        return -1
    }
    
    return max(left, right) + 1
}


/*: Binary Tree Level Order Traversal
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
 
 
 */

func levelOrder(_ root: TreeNode?) -> [[Int]] {
    
    var res = [[Int]]()
    
    if root == nil {
        return res
    }
    
    var queue = [root]
    while !queue.isEmpty {
        let size = queue.count
        var curLevel = [Int]()
        
        for _ in 0..<size {
            if let curNode = queue.removeFirst() {
                curLevel.append(curNode.val)
                
                if let left = curNode.left {
                    queue.append(left)
                }
                
                if let right = curNode.right {
                    queue.append(right)
                }
            }
        }
        res.append(curLevel)
    }
    return res
}


/*: Binary Tree Level Order Traversal II
 Given a binary tree, return the bottom-up level order traversal of its nodes' values. (ie, from left to right, level by level from leaf to root).
 
 For example:
 Given binary tree [3,9,20,null,null,15,7],
 3
 / \
 9  20
 /  \
 15   7
 return its bottom-up level order traversal as:
 [
 [15,7],
 [9,20],
 [3]
 ]
 
 */

func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
    
    var res = [[Int]]()
    
    if root == nil {
        return res
    }
    
    var queue = [root]
    while !queue.isEmpty {
        let size = queue.count
        var curLevel = [Int]()
        
        for _ in 0..<size {
            if let curNode = queue.removeFirst() {
                curLevel.append(curNode.val)
                
                if let left = curNode.left {
                    queue.append(left)
                }
                
                if let right = curNode.right {
                    queue.append(right)
                }
            }
        }
        res.insert(curLevel, at: 0)
    }
    return res
}

/*:
 Binary Tree Right Side View
 Given a binary tree, imagine yourself standing on the right side of it, return the values of the nodes you can see ordered from top to bottom.
 
 For example:
 Given the following binary tree,
 1            <---
 /   \
 2     3         <---
 \     \
 5     4       <---
 You should return [1, 3, 4].
 */

func rightSideView(_ root: TreeNode?) -> [Int] {
    
    var res = [Int]()
    
    if root == nil {
        return res
    }
    
    var queue = [root]
    while !queue.isEmpty {
        let size = queue.count
        
        if let last = queue.last {
            res.append((last?.val)!)
        }
        
        for _ in 0..<size {
            if let curNode = queue.removeFirst() {

                if let left = curNode.left {
                    queue.append(left)
                }
                
                if let right = curNode.right {
                    queue.append(right)
                }
            }
        }
    }
    return res
}

/*:
 isSameTree
 */

func isSameTree(root1: TreeNode?, root2: TreeNode?) -> Bool {
    
    if root1 == nil && root2 == nil {
        return true
    }
    
    if root1 == nil || root2 == nil || root1?.val != root2?.val {
        return false
    }
    
    return isSameTree(root1: root1?.left, root2: root2?.left) &&
            isSameTree(root1: root1?.right, root2: root2?.right)
}

/*:
 isSymetricTree
 */

func isSymmetric(root: TreeNode?) -> Bool {
    guard let root = root else {
        return true
    }
    return helper(root1: root.left, root2: root.right)
}

func helper(root1: TreeNode?, root2: TreeNode?) -> Bool {
    if root1 == nil && root2 == nil {
        return true
    }
    
    if root1 == nil || root2 == nil || root1?.val != root2?.val {
        return false
    }
    
    return helper(root1: root1?.left, root2: root2?.right) &&
        helper(root1: root1?.right, root2: root2?.left)
}

