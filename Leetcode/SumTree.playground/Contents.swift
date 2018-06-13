//: Check if a given Binary Tree is SumTree
/*
 Write a function that returns true if the given Binary Tree is SumTree else false. A SumTree is a Binary Tree where the value of a node is equal to sum of the nodes present in its left subtree and right subtree. An empty tree is SumTree and sum of an empty tree can be considered as 0. A leaf node is also considered as SumTree.
 
 Following is an example of SumTree.
 
            26
           /   \
          10     3
        /    \     \
       4      6      3
 */

/*
 if root == nil or (root.left and root.right are both nil) return true
 
 else:
    calculate the sum of left and sum of the right
    if leftSum + rightSum != node.val return false
    else
        return isSumTree(left) && isSumTree(right)
 */
 

class TreeNode{
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
    
    var isLeaf: Bool {
        return self.left == nil && self.right == nil
    }
}

// O(n^2)

func isSumTree(_ root: TreeNode?) -> Bool {
    
    if root == nil {
        return true
    }
    
    if root!.left == nil && root!.right == nil {
        return true
    }
    
    let ls = sum(root!.left)
    let rs = sum(root!.right)
    
    if root!.val != ls + rs {
        return false
    } else {
        return isSumTree(root?.right) && isSumTree(root?.left)
    }
}

func sum(_ node: TreeNode?) -> Int {
    guard let node = node else {
        return 0
    }
    return node.val + sum(node.left) + sum(node.right)
}


let node1 = TreeNode(26)
let node2 = TreeNode(10)
let node3 = TreeNode(3)
node1.left = node2
node1.right = node3
let node4 = TreeNode(4)
let node5 = TreeNode(6)
let node6 = TreeNode(3)
node2.left = node4
node2.right = node5
node3.right = node6

// isSumTree(node1)

/* better solution O(n)
 note that if a node's left subtree is a sum tree, this node's left sum is equal to
 case 1: if left node is nil, ls = 0
 case 2: if left node is a leaf, ls = leftNode.val
 case 3: otherwise, ls = 2 * leftNode.val
 */


func isSumTree_better(_ root: TreeNode?) -> Bool {
    
    if root == nil || root!.isLeaf {
        return true
    }
    
    if isSumTree_better(root!.left) && isSumTree_better(root!.right) {
        var ls = 0
        var rs = 0
        // get left sum
        if root!.left == nil {
            ls = 0
        } else if root!.left!.isLeaf {
            ls = root!.left!.val
        } else {
            ls = root!.left!.val * 2
        }
        
        if root!.right == nil {
            rs = 0
        } else if root!.right!.isLeaf {
            rs = root!.right!.val
        } else {
            rs = root!.right!.val * 2
        }
        
        if root!.val == ls + rs {
            return true
        } else {
            return false
        }
    }
    
    return false
}

isSumTree_better(node1)

