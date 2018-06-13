//: Serialize and Deserialize a Binary tree

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

/*
 
    3
 
  /   \
 
 2     4
 
 
 3 2 4 null null null null
 */

class Coder {
    
    
    
    static func serialize(_ root: TreeNode) -> String {
        guard root != nil else {
            return ""
        }
        
        
    }
    
    
    static func deserialize(_ s: String) -> TreeNode {
        
        
        
    }
    
}
