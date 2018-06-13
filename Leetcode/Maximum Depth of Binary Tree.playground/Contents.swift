//: Maximum Depth of Binary Tree
// This can be solved by BFS or DFS

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

// DFS can be done recusively

func maxDepthDFS(_ root: TreeNode?) -> Int {
    if root == nil {
        return 0
    }
    
    // return 1 plus the max depth of left and right branch
    return 1 + max(maxDepthDFS(root?.left), maxDepthDFS(root?.right))
}

// BFS can be done by using a queue

func maxDepthBFS(_ root: TreeNode?) -> Int {
    if root == nil {
        return 0
    }
    
    var res = 0
    var queue = [TreeNode]()
    queue.append(root!)
    
    while !queue.isEmpty {
        res += 1
        
        let size = queue.count
        for _ in 0..<size {
            let curNode = queue.removeFirst()
            
            if curNode.left != nil {
                queue.append(curNode.left!)
            }
            if curNode.right != nil {
                queue.append(curNode.right!)
            }
        
        }
    }
    return res
}
