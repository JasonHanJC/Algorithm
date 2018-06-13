//: Convert a given tree to its Sum Tree
/*
 Given a Binary Tree where each node has positive and negative values. Convert this to a tree where each node contains the sum of the left and right sub trees in the original tree. The values of leaf nodes are changed to 0.
 
 For example, the following tree
 
               10
            /      \
           -2        6
          /   \      /  \
        8     -4    7    5
 should be changed to
 
            20(4-2+12+6)
            /      \
        4(8-4)      12(7+5)
        /   \      /  \
       0      0    0    0
 */

class TreeNode {
    var val : Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ val: Int) {
        self.val = val
        self.right = nil
        self.left = nil
    }
    
    var isLeaf: Bool {
        return self.left == nil && self.right == nil
    }
}

func printInorder(_ node: TreeNode?) {
    guard let node = node else {
        return
    }
    printInorder(node.left)
    print(node.val)
    printInorder(node.right)
}

func convertToSumTree(_ root: TreeNode?) -> Int {
    
    if root == nil {
        return 0
    }
    
    // store the old val
    let oldVal = root!.val
    
    root!.val = convertToSumTree(root!.left) + convertToSumTree(root!.right)
    
    return oldVal + root!.val
}


let node1 = TreeNode(10)
let node2 = TreeNode(-2)
let node3 = TreeNode(6)
node1.left = node2
node1.right = node3
let node4 = TreeNode(8)
let node5 = TreeNode(-4)
let node6 = TreeNode(7)
let node7 = TreeNode(5)
node2.left = node4
node2.right = node5
node3.left = node6
node3.right = node7
printInorder(node1)

print()

convertToSumTree(node1)

printInorder(node1)

