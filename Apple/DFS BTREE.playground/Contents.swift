//: Playground - noun: a place where people can play


class TreeNode<Element> where Element : Comparable, Element : Hashable {
    var val: Element
    var left: TreeNode?
    var right: TreeNode?
    
    init(_ val: Element) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

struct Node {
    var val: Int
}


let node = Node(val: 1)
