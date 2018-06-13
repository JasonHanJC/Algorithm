import Foundation

class TreeNode {
    var value: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ val: Int) {
        self.value = val
        self.left = nil
        self.right = nil
    }
}

let root = TreeNode(4);
let node1 = TreeNode(2);
let node2 = TreeNode(3);
let node3 = TreeNode(5);
let node4 = TreeNode(6);
let node5 = TreeNode(7);
let node6 = TreeNode(8);
let node7 = TreeNode(9);

root.left = node1
root.right = node2
node1.left = node3
node3.left = node4
node3.right = node5
node5.left = node6
node5.right = node7

func printTree(_ root: TreeNode?) {
    if root == nil {
        print("nil")
        return;
    }

    var queue = [TreeNode]()
    queue.append(root!)

    while !queue.isEmpty {
        let size = queue.count
        var printString = String()
        for _ in 0..<size {
            let curNode = queue.removeFirst()
            printString += "\(curNode.value) "

            if curNode.left != nil {
                queue.append(curNode.left!)
            }
            if curNode.right != nil {
                queue.append(curNode.right!)
            }
        }
        print(printString)
    }
}


// get depth: dfs with recursive or bfs with queue
func getDepth(_ root: TreeNode?) -> Int {
    if root == nil {
        return 0
    }
    return max(getDepth(root?.left), getDepth(root?.right)) + 1
}

// 求二叉树第k层的节点个数
func getKLevelNodeCount(_ root: TreeNode?, _ k: Int) -> Int {
    if root == nil || k < 1 {
        return 0;
    }
    if k == 1 {
        return 1
    }
    return getKLevelNodeCount(root?.left, k - 1) + getKLevelNodeCount(root?.right, k - 1)
}

// 求二叉树第k层的叶子节点个数
func getKLevelLeafCount(_ root: TreeNode?, _ k: Int) -> Int {
    if root == nil || k < 1 {
        return 0;
    }
    if k == 1 {
        // 是叶子节点才返回1
        if root?.left == nil && root?.right == nil {
            return 1
        } else {
            return 0
        }
    }
    return getKLevelNodeCount(root?.left, k - 1) + getKLevelNodeCount(root?.right, k - 1)
}

// 判断两棵树的结构是否相同，不用考虑数据内容
func compareStructure(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
    if root1 == nil && root2 == nil { return true }
    if root1 == nil || root2 == nil { return false }

    let left = compareStructure(root1?.left, root2?.left)
    let right = compareStructure(root1?.right, root2?.right)
    return left && right
}

// 求二叉树的镜像
func mirrorTree(_ root: TreeNode?) {
    if root == nil { return }

    let left = root?.left
    let right = root?.right
    root?.left = right
    root?.right = left

    if root?.left != nil {
        mirrorTree(root?.left)
    }
    if root?.right != nil {
        mirrorTree(root?.right)
    }
}

// 求两个节点的最低公共祖先节点
func lowestCommonAncestor(_ root: TreeNode?, _ target1: TreeNode?, _ target2: TreeNode?) -> TreeNode? {
    if root == nil || target1 == nil || target2 == nil { return nil }
    if root?.value == target1?.value {
        return root
    }
    if root?.value == target2?.value {
        return root
    }

    let leftRes = lowestCommonAncestor(root?.left, target1, target2)
    let rightRes = lowestCommonAncestor(root?.right, target1, target2)
    if (leftRes != nil) && (rightRes != nil) {
        return root
    }
    return (leftRes != nil) ? leftRes : rightRes
}

// 求任意两节点距离
// 先找到两个的LCA，然后分别计算共同祖先和节点的距离
func findLevel(_ root: TreeNode?, _ target: TreeNode?) -> Int {
    if root == nil || target == nil { return -1 }
    if root?.value == target?.value { return 0 }
    var level = findLevel(root?.left, target)
    if level == -1 {
        level = findLevel(root?.right, target)
    }
    if level != -1 {
        return level + 1
    }
    return -1
}

func distanceNodes(_ root: TreeNode?, _ target1: TreeNode?, _ target2: TreeNode?) -> Int {
    if let lca = lowestCommonAncestor(root, target1, target2) {
        let dis1 = findLevel(lca, target1)
        let dis2 = findLevel(lca, target2)
        return dis1 + dis2
    } else {
        return -1
    }
}

// 找出二叉树中某个节点的所有祖先节点， print out所有父节点
func findAncestors(_ root: TreeNode?, _ target: TreeNode?) -> Bool {
    if root == nil || target == nil {
        return false;
    }
    if root?.value == target?.value { return true }
    if (findAncestors(root?.left, target) || findAncestors(root?.right, target)) {
        print(root?.value ?? "")
        return true
    }
    return false
}


// 判断二叉树是不是完全二叉树
// 若设二叉树的深度为h，除第 h 层外，其它各层 (1～h-1) 的结点数都达到最大个数，第 h 层所有的结点都连续集中在最左边，这就是完全二叉树。
// BFS, except level h, 1 ~ h - 1 should have 2^(h - 1) nodes
func isCompleteBinaryTree(_ root: TreeNode?) -> Bool {
    if root == nil { return true }
    var isLevelFull = true // is one level full
    var queue = [TreeNode]()
    queue.append(root!)
    var level = 0;
    while !queue.isEmpty {
        let size = queue.count;
        if size < Int(truncating: NSDecimalNumber(decimal: pow(2, level))) {
            if isLevelFull {
                isLevelFull = false
            } else {
                return false
            }
        }
        for _ in 0..<size {
            let curNode = queue.removeFirst()
            if let left = curNode.left {
                queue.append(left)
            }
            if let right = curNode.right {
                queue.append(right)
            }
        }
        level += 1
    }
    return true;
}

// Convert Sorted Array to Binary Search Tree
// For this problem, a height-balanced binary tree is defined as a binary tree in which the depth of the two subtrees of every node never differ by more than 1.
func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
    if nums.count == 0 { return nil }
    
    let middle = nums.count / 2
    let root = TreeNode(nums[middle])
    if middle == 0 { return root }
    root.left = sortedArrayToBST(Array(nums[0...(middle - 1)]))
    root.right = sortedArrayToBST(Array(nums[(middle + 1)...]))
    return root
}








