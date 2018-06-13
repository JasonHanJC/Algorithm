//: Delete a Node in BST
/*
 Given a root node reference of a BST and a key, delete the node with the given key in the BST. Return the root node reference (possibly updated) of the BST.
 
 Basically, the deletion can be divided into two stages:
 
 Search for a node to remove.
 If the node is found, delete the node.
 Note: Time complexity should be O(height of tree).
 */
// 3 cases:
// The node is a leaf, simply delete the node
// The node has one child, point parant reference to child
// The node has two children, we can switch the left max with the node, or right min with the node.

import Foundation

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
    var isLeaf: Bool {
        return left == nil && right == nil
    }
}

func deleteNode(_ root: TreeNode?, _ key: Int) -> TreeNode? {
    // base case, root == nil
    guard let root = root else {
        return nil
    }
    // search through the tree
    if root.val < key {
        root.right = deleteNode(root.right, key)
    } else if root.val > key {
        root.left = deleteNode(root.left, key)
    } else {
        // if node is a leaf
        if root.isLeaf {
            return nil
        }
        // if node has one child
        if root.left == nil {
            return root.right
        }
        if root.right == nil {
            return root.left
        }
        // if node has two children
        let maxNode = findMax(root.left)
        root.val = maxNode!.val
        root.left = deleteNode(root.left, maxNode!.val)
    }
    return root
}

func findMax(_ node: TreeNode?) -> TreeNode? {
    guard var node = node else {
        return nil
    }
    while node.right != nil {
        node = node.right!
    }
    return node
}

