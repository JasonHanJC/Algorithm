//: Search for a range
/*
 Given an array of integers sorted in ascending order, find the starting and ending position of a given target value.
 
 Your algorithm's runtime complexity must be in the order of O(log n).
 
 If the target is not found in the array, return [-1, -1].
 
 For example,
 Given [5, 7, 7, 8, 8, 10] and target value 8,
 return [3, 4].
 */

// use two binary search to get the lower and upper bound

func searchForRange(_ nums: [Int], _ target: Int) -> [Int] {
    // target is not in the nums
    var res = Array(repeating: -1, count: 2)
    
    if target < nums[0] || target > nums[nums.count-1] {
        return res
    }
    
    // search for the lower bound
    var low = 0, high = nums.count - 1
    while low < high {
        
        let mid = (low + high) / 2
        
        if nums[mid] < target {
            low = mid + 1
        } else {
            high = mid
        }
    }
    if nums[low] != target {
        return res
    }
    res[0] = low
    
    // search for the upper bound
    
    high = nums.count - 1
    while low < high {
        
        let mid = (low + high) / 2 + 1
        
        if nums[mid] > target {
            high = mid - 1
        } else {
            low = mid
        }
    }
    
    res[1] = low
    
    return res
}

searchForRange([5, 7, 7, 8, 8, 10], 8)
