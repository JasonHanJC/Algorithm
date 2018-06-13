//: Maximum Product Subarray
/*
 Find the contiguous subarray within an array (containing at least one number) which has the largest product.
 
 For example, given the array [2,3,-2,4],
 the contiguous subarray [2,3] has the largest product = 6.
 */

// store the premin and premax and update it every time with nums[i]

func maxProductSub(_ nums: [Int]) -> Int {
    
    if nums.count == 0 {
        return 0
    }
    
    var preMin = nums[0], preMax = nums[0], maxSoFar = nums[0]
    for i in 1..<nums.count {
        // update preMin and preMax
        let copyMin = preMin
        preMin = min(min(preMax * nums[i], preMin * nums[i]), nums[i])
        preMax = max(max(preMax * nums[i], copyMin * nums[i]), nums[i])
        maxSoFar = max(preMax, maxSoFar)
    }
    
    return maxSoFar
}

maxProductSub([2,3,-2,4])





