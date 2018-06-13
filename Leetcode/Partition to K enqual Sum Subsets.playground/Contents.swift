//: Partition to K Equal Sum Subsets
/*
 Given an array of integers nums and a positive integer k, find whether it's possible to divide this array into k non-empty subsets whose sums are all equal.
 
 Example 1:
 Input: nums = [4, 3, 2, 3, 5, 2, 1], k = 4
 Output: True
 Explanation: It's possible to divide it into 4 subsets (5), (1, 4), (2,3), (2,3) with equal sums.
 
 Notes:
 1 <= k <= len(nums) <= 16.
 0 < nums[i] < 10000.
 */

/*
 case:
 if k == 1, return true
 if k > nums.count, return false
 // get the target, P1 = P2 = P3 = ... = Pk, so target = (P1 + ... + PK) / k = Sum / k
 if Sum % k != 0, return false
 target = Sum / k
 
 use a array visited[Bool] to track the visited num item.
 use curSum to track the current sum
 use curNum to track the number of item
 
In below code a recursive method is written which tries to add array element into some subset. If sum of this subset reaches required sum, we iterate for next part recursively, otherwise we backtrack for different set of elements. If number of subsets whose sum reaches the required sum is (K-1), we flag that it is possible to partition array into K parts with equal sum, because remaining elements already have a sum equal to required sum.
 */

func canPartitionKSubsets(_ nums: [Int], _ k: Int) -> Bool {
    if k == 1 { return true }
    if k > nums.count || k <= 0 { return false }
    var sum = 0
    for num in nums {
        sum += num
    }
    if sum % k != 0 { return false }
    let target = sum / k
    var visited = Array(repeating: false, count: nums.count)
    // return canPartitionKSubsetsRecursive(nums, k, 0, &visited, 0, target, 0)
    return helper(nums, target, 0, 0, k, &visited)
}

func canPartitionKSubsetsRecursive(_ nums: [Int], _ k: Int, _ startIndex: Int, _ visited: inout [Bool], _ curSum: Int, _ target: Int, _ curNum: Int) -> Bool {
    if k == 1 { return true }
    if curSum == target && curNum > 0 {
        return canPartitionKSubsetsRecursive(nums, k-1, 0, &visited, 0, target, 0)
    }
    var curNum = curNum
    for i in startIndex..<nums.count {
        if visited[i] == false {
            visited[i] = true
            curNum += 1
            if canPartitionKSubsetsRecursive(nums, k, i+1, &visited, curSum+nums[i], target, curNum) {
                return true
            }
            visited[i] = false
        }
    }
    return false
}

func helper(_ nums: [Int], _ target: Int, _ startIndex: Int, _ curSum: Int, _ k: Int, _ visited: inout [Bool]) -> Bool {
    if k == 1 { return true }
    if curSum > target { return false }
    if curSum == target {
        return helper(nums, target, 0, 0, k - 1, &visited)
    }
    
    for i in startIndex ..< nums.count {
        if visited[i] { continue }
        visited[i] = true
        if helper(nums, target, i + 1, curSum + nums[i], k, &visited) {
            return true
        }
        visited[i] = false
    }
    
    return false
}

canPartitionKSubsets([2,2,2,2,3,4,5], 4)

