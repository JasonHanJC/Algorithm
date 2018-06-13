//: Maximum Subarray
/*
 Find the contiguous subarray within an array (containing at least one number) which has the largest sum.
 
 For example, given the array [-2,1,-3,4,-1,2,1,-5,4],
 the contiguous subarray [4,-1,2,1] has the largest sum = 6.
 */

func maxSubArray(_ nums: [Int]) -> Int {
    if nums.count == 0 {
        return 0
    }
    var maxSoFar = nums[0], maxEndingHere = nums[0]
    for i in 1..<nums.count {
        maxEndingHere = max(maxEndingHere + nums[i], nums[i])
        maxSoFar = max(maxEndingHere, maxSoFar)
    }
    return maxSoFar
}

maxSubArray([-2, 1, -3, 4])

// solve by DP
// sub problem, maxSubArray(i), max sub array [0...i]
// connection of maxSubArray(i) and maxSubArray(i-1)
// :   maxSubArray(i) = nums[i] + maxSubArray(i-1) > 0 ? maxSubArray(i-1) : 0
// Init: maxSubArray(0) = nums[0]


func maxSubArrayDP(_ nums: [Int]) -> Int {
    let length = nums.count
    if length == 0 {
        return 0
    }
    
    var res = nums[0]
    var dp = Array(repeating: 0, count: length)
    dp[0] = nums[0]
    
    for i in 1..<length {
        dp[i] = nums[i] + (dp[i - 1] > 0 ? dp[i - 1] : 0)
        res = max(res, dp[i])
    }
    return res
}

maxSubArrayDP([-2, 1, -3, 4])
