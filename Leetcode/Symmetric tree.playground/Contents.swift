//: Given a binary tree, check whether it is a mirror of itself (ie, symmetric around its center).

class TreeNode {
    var left: TreeNode?
    var right: TreeNode?
    var val: Int
    
    init(val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

// recursively
func isSymmetric(_ root: TreeNode?) -> Bool {
    if root == nil {
        return true
    }
    
    return helper(root?.left, root?.right)
}

func helper(_ left: TreeNode?, _ right: TreeNode?) -> Bool {
    // both nil
    if left == nil && right == nil {
        return true
    }
    
    // one nil or vals are not equal
    if left == nil || right == nil || left?.val != right?.val {
        return false
    }
    
    return helper(left?.left, right?.right) && helper(left?.right, right?.left)
}


// iteratively using stack
func isSymmetric_I(_ root: TreeNode?) -> Bool {
    
    if root == nil {
        return true
    }
    
    var stack = [TreeNode]()
    
    if root?.left != nil {
        if root?.right == nil {
            return false
        }
        stack.append((root?.left)!)
        stack.append((root?.right)!)
    } else if root?.right != nil {
        return false
    }
    
    while !stack.isEmpty {
        if stack.count % 2 != 0 {
            return false
        }
        
        let right = stack.removeFirst()
        let left = stack.removeFirst()
        
        stack.popLast()
        
        if left.val != right.val {
            return false
        }
        
        if left.left != nil {
            if right.right == nil {
                return false
            }
            stack.append(left.left!)
            stack.append(right.right!)
        } else if right.right != nil {
            return false
        }
        
        if left.right != nil {
            if right.left == nil {
                return false
            }
            stack.append(left.right!)
            stack.append(right.left!)
        } else if right.left != nil {
            return false
        }
    }
    return true
}
