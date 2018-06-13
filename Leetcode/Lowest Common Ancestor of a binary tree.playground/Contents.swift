//: Lowest Common Ancestor of a binary tree
/*
 Given a binary tree, find the lowest common ancestor (LCA) of two given nodes in the tree.
 
 According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes v and w as the lowest node in T that has both v and w as descendants (where we allow a node to be a descendant of itself).”
 
             _______3______
            /              \
        ___5__          ___1__
       /      \        /      \
      6        2      0        8
     /  \
    7    4
 For example, the lowest common ancestor (LCA) of nodes 5 and 1 is 3. Another example is LCA of nodes 5 and 4 is 5, since a node can be a descendant of itself according to the LCA definition.
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

extension TreeNode: Equatable {
    static func ==(lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs.val == rhs.val
    }
}

func lowestCommonAncestor(root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
    if root == nil || root == p || root == q {
        return root
    }
    
    let left = lowestCommonAncestor(root: root?.left, p, q)
    let right = lowestCommonAncestor(root: root?.right, p, q)
    
    if left != nil && right != nil {
        return root
    }
    
    return left == nil ? right : left
}
