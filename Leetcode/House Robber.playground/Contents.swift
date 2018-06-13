//: house robber
/* You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security system connected and it will automatically contact the police if two adjacent houses were broken into on the same night.

 Given a list of non-negative integers representing the amount of money of each house, determine the maximum amount of money you can rob tonight without alerting the police.
 */

/*
 这道题的本质相当于在一列数组中取出一个或多个不相邻数，使其和最大。那么我们对于这类求极值的问题首先考虑动态规划Dynamic Programming来解，我们维护一个一位数组dp，其中dp[i]表示到i位置时不相邻数能形成的最大和，那么递推公式怎么写呢，我们先拿一个简单的例子来分析一下，比如说nums为{3, 2, 1, 5}，那么我们来看我们的dp数组应该是什么样的，首先dp[0]=3没啥疑问，再看dp[1]是多少呢，由于3比2大，所以我们抢第一个房子的3，当前房子的2不抢，所以dp[1]=3，那么再来看dp[2]，由于不能抢相邻的，所以我们可以用再前面的一个的dp值加上当前的房间值，和当前房间的前面一个dp值比较，取较大值当做当前dp值，所以我们可以得到递推公式dp[i] = max(num[i] + dp[i - 2], dp[i - 1]), 由此看出我们需要初始化dp[0]和dp[1]，其中dp[0]即为num[0]，dp[1]此时应该为max(num[0], num[1])
 */

func rob(_ nums: [Int]) -> Int {
    
    if nums.count == 0 {
        return 0
    }
    
    if nums.count == 1 {
        return nums[0]
    }
    
    // create dp array
    var dp = Array(repeating: 0, count: nums.count)
    
    // init dp[0], and dp[1]
    dp[0] = nums[0]
    dp[1] = max(nums[0], nums[1])
    
    for i in 2..<nums.count {
        dp[i] = max(dp[i-2] + nums[i], dp[i-1])
    }
    return dp[dp.count-1]
}



//: house robber II
/* After robbing those houses on that street, the thief has found himself a new place for his thievery so that he will not get too much attention. This time, all houses at this place are arranged in a circle. That means the first house is the neighbor of the last one. Meanwhile, the security system for these houses remain the same as for those in the previous street.
 
 Given a list of non-negative integers representing the amount of money of each house, determine the maximum amount of money you can rob tonight without alerting the police.
 */
/*
 Since the array became a cycle, the first one and the last one can't be robbered at same time. Two cases: robber first one but not last one, 0...nums.count - 2; robber last one but not first one.
 */

func robII(_ nums: [Int]) -> Int {
    if nums.count == 0 {
        return 0
    }
    
    if nums.count == 1 {
        return nums[0]
    }
    
    let c1 = helper(nums, start: 0, end: nums.count-2)
    let c2 = helper(nums, start: 1, end: nums.count-1)
    
    return max(c1, c2)
}

func helper(_ nums: [Int], start: Int, end: Int) -> Int {
    
    if start == end {
        return nums[start]
    }
    
    // create dp array
    var dp = Array(repeating: 0, count: nums.count)
    
    // init dp[0], and dp[1]
    dp[start] = nums[start]
    dp[start+1] = max(nums[start], nums[start+1])
    
    var i = start+2
    while i <= end {
        dp[i] = max(dp[i-2] + nums[i], dp[i-1])
        i += 1
    }
    return dp[end]
}


//: House Robber III
/*
 The thief has found himself a new place for his thievery again. There is only one entrance to this area, called the "root." Besides the root, each house has one and only one parent house. After a tour, the smart thief realized that "all houses in this place forms a binary tree". It will automatically contact the police if two directly-linked houses were broken into on the same night.
 
 Determine the maximum amount of money the thief can rob tonight without alerting the police.
 
 Example 1:
   3
  / \
 2   3
  \   \
   3   1
 Maximum amount of money the thief can rob = 3 + 3 + 1 = 7.
 Example 2:
     3
    / \
   4   5
  / \   \
 1   3   1
 Maximum amount of money the thief can rob = 4 + 5 = 9.
 
 The houses form a binary tree. If the root is robbed, its left and right can not be robbed.
 */

/*
 Dynamic programming:
 Two properties of dp:
 1. Overlapping subproblem (calculate fibonacci)
 2. Optimal substructure (shortest path)
 */

class TreeNode: Hashable {
    var hashValue: Int {
        return (left?.hashValue)! ^ val.hashValue ^ (right?.hashValue)!
    }
    
    static func ==(lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs.val == rhs.val
    }
    
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}


// Time Limit Exceeded
func robIII(root: TreeNode?) -> Int {
    if root == nil {
        return 0
    }
    
    var val = 0
    if root?.left != nil {
        val += robIII(root: root?.left?.left) + robIII(root: root?.left?.right)
    }
    if root?.right != nil {
        val += robIII(root: root?.right?.left) + robIII(root: root?.right?.right)
    }
    
    return max(val + root!.val, robIII(root: root?.left)+robIII(root: root?.right))
}

// Use dictionary to store the results.
var dic = [TreeNode: Int]()
func robIII_1(root: TreeNode?) -> Int {
    return robIII_1_helper(root)
}

func robIII_1_helper(_ root: TreeNode?) -> Int {
    if root == nil {
        return 0
    }
    
    if let val = dic[root!] {
        return val
    }
    
    var val = 0
    if root!.left != nil {
        val += robIII(root: root!.left?.left) + robIII(root: root!.left?.right)
    }
    if root!.right != nil {
        val += robIII(root: root!.right?.left) + robIII(root: root!.right?.right)
    }
    
    let maxVal = max(val + root!.val, robIII(root: root!.left)+robIII(root: root!.right))
    dic[root!] = maxVal
    
    return maxVal
}

// Use array to store the max val when root is robbered and not robbered
func robIII_2(root: TreeNode?) -> Int {
    let (a, b) = robSub(root)
    return max(a, b)
}

func robSub(_ root: TreeNode?) -> (Int, Int) {
    if root == nil {
        return (0, 0)
    }
    
    // a is for root robbered, b is for root not robbered
    var maxVal = (0, 0)
    let left = robSub(root?.left)
    let right = robSub(root?.right)
    
    maxVal.0 = root!.val + left.1 + right.1
    maxVal.1 = max(left.0, left.1) + max(right.0, right.1)
    
    return maxVal
}









