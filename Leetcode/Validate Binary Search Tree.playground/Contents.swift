//: Determine if a Binary Tree is a Binary Search Tree (BST)
/*
 Write a function isBST(BinaryTree *node) to verify if a given binary tree is a Binary Search Tree (BST) or not.
 */

import Foundation


class TreeNode{
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

// recursive way, the idea is to keep tracking the <minNode, maxNode> for current root

func isValidBST(_ root: TreeNode?) -> Bool {
    return helper(root, nil, nil)
}

func helper(_ root: TreeNode?, _ max: Int?, _ min: Int?) -> Bool {
    
    guard let root = root else {
        return true
    }
    
    if let max = max, root.val >= max {
        return false
    }
    
    if let min = min, root.val <= min {
        return false
    }
    
    print("\(root.val) \(String(describing: max)) \(String(describing: min))")
    
    return helper(root.left, root.val, min) && helper(root.right, max, root.val)
}

let root = TreeNode(10)
let node_1 = TreeNode(6)
let node_2 = TreeNode(5)
let node_3 = TreeNode(3)
let node_4 = TreeNode(2)
let node_5 = TreeNode(1)

root.left = node_2
node_2.right = node_1
node_2.left = node_4
node_4.left = node_5
node_4.right = node_3

//isValidBST(root)


// iterator : inorder traversal

func isValidBST_I(_ root: TreeNode?) -> Bool {
    if root == nil {
        return true
    }

    var p = root
    var pre: TreeNode? = nil
    var stack = [TreeNode]()
    while !stack.isEmpty || p != nil {
        // store the left smaller val
        while p != nil {
            stack.append(p!)
            p = p!.left
        }
        
        let cur = stack.removeLast()
        if let pre = pre, pre.val >= cur.val {
            return false
        }
        pre = cur
        p = cur.right
    }
    return true
}

isValidBST_I(root)


var array = ["a", "b", "c", "d"]

extension Array {
    mutating func shuffle() {
        for i in 0 ..< (count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swapAt(i, j)
        }
    }
}





