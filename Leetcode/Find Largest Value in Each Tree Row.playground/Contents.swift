//: Find Largest Value in Each Tree Row
/*
 You need to find the largest value in each row of a binary tree.
 
 Example:
 Input:
 
        1
       / \
      3   2
     / \   \
    5   3   9
 
 Output: [1, 3, 9]
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

func findLargestValueEachRow(_ root: TreeNode?) -> [Int] {
    var res = [Int]()
    if root == nil {
        return res
    }
    
    var queue = [TreeNode]()
    queue.append(root!)
    
    while !queue.isEmpty {
        let size = queue.count
        var maxVal = Int.min
        for _ in 0..<size {
            let front = queue.removeFirst()
            maxVal = max(maxVal, front.val)
            
            if let left = front.left {
                queue.append(left)
            }
            if let right = front.right {
                queue.append(right)
            }
        }
        res.append(maxVal)
    }
    return res
}
