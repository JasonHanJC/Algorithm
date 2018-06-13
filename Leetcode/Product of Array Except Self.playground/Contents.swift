//: Product of Array Except Self
/*
 Given an array of n integers where n > 1, nums, return an array output such that output[i] is equal to the product of all the elements of nums except nums[i].
 
 Solve it without division and in O(n).
 
 For example, given [1,2,3,4], return [24,12,8,6].
 
 Follow up:
 Could you solve it with constant space complexity? (Note: The output array does not count as extra space for the purpose of space complexity analysis.)
 */

/*
 for num at index i, the product is the product[0...i-1] * product[i+1...size-1]
 
 so we can use two arrays to store the left products and right products,
 the res[i] = left[i] * right[i]
 */

func productsExceptSelf(_ nums: [Int]) -> [Int] {
    if nums.count < 2 {
        return [Int]()
    }
    var left = Array(repeating: 1, count: nums.count)
    // compute left products
    for i in 1..<nums.count {
        left[i] = left[i - 1] * nums[i - 1]
    }
    
    var i = nums.count - 2
    var right = Array(repeating: 1, count: nums.count)
    while i > -1 {
        right[i] = right[i + 1] * nums[i + 1]
        i -= 1
    }
    
    for i in 0..<left.count {
        left[i] = left[i] * right[i]
    }
    
    return left
}


func productsExceptSelfII(_ nums: [Int]) -> [Int] {
    if nums.count < 2 {
        return [Int]()
    }
    var left = Array(repeating: 1, count: nums.count)
    // compute left products
    for i in 1..<nums.count {
        left[i] = left[i - 1] * nums[i - 1]
    }
    
    var i = nums.count - 1
    var preRight = 1
    while i > -1 {
        left[i] = left[i] * preRight
        preRight = nums[i] * preRight
        i -= 1
    }
    
    return left
}

productsExceptSelf([1, 2, 3, 4])
