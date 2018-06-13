/**
 Given a binary tree, find the length of the longest path where each node in the path has the same value. This path may or may not pass through the root.
 
 Note: The length of path between two nodes is represented by the number of edges between them.
 
 Example 1:
 
 Input:
 
 5
 / \
 4   5
 / \   \
 1   1   5
 Output:
 
 2
 Example 2:
 
 Input:
 
        1
        / \
        4   5
        / \   \
        4   4   5
 Output:
 
 2
 */
class Solution {
    
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
    
    var maxLen: Int = 0;
    
    func longestUnivaluePath(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        dfs(root, root!.val)
        return maxLen;
    }
    
    func dfs(_ root: TreeNode?, _ val: Int) -> Int {
        if root == nil { return 0 }
        // dfs left first
        let lres = dfs(root!.left, root!.val)
        let rres = dfs(root!.right, root!.val)
        // update maxLen
        maxLen = max(maxLen, lres + rres)
        if root!.val == val { return max(lres, rres) + 1 }
        return 0
    }
}
