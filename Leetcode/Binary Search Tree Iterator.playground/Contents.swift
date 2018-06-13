//: Binary Search Tree Iterator
/*
 Implement an iterator over a binary search tree (BST). Your iterator will be initialized with the root node of a BST.
 
 Calling next() will return the next smallest number in the BST.
 
 Note: next() and hasNext() should run in average O(1) time and uses O(h) memory, where h is the height of the tree.
 
 */

class TreeNode {
    var val : Int
    var left : TreeNode?
    var right : TreeNode?
    
    init(val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

class BSTIterator {
    
    private var stack = [TreeNode]()
    
    init(root: TreeNode?) {
        pushLeft(root)
    }
    
    func hasNext() -> Bool {
        return !stack.isEmpty
    }
    
    func next() -> TreeNode? {
        if let top = stack.last {
            pushLeft(top.right)
            return top
        } else {
            return nil
        }
    }
    
    private func pushLeft(_ node: TreeNode?) {
        var node = node
        while node != nil {
            stack.append(node!)
            node = node!.left
        }
    }
}

/**
 * Your BSTIterator will be called like this:
 * BSTIterator i = new BSTIterator(root);
 * while (i.hasNext()) v[f()] = i.next();
 */
