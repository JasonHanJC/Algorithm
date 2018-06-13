//: Find minimum in sorted array i & ii
// binary search. choose mid, if nums[mid] >= nums[start], the min is in the right side, start = mid + 1; otherwise, the min is in the left side, end = mid; when start >= end, return nums[start]


// i: array has no duplicates

func findMinI(_ nums: [Int]) -> Int {
    
    var start = 0, end = nums.count - 1
    
    while start < end {
        // if it is sorted
        if nums[start] < nums[end] {
            return nums[start]
        }
        
        let mid = (start + end) / 2
        
        if nums[mid] >= nums[start] {
            start = mid + 1
        } else {
            end = mid
        }
    }
    
    return nums[start]
}


// ii: array has duplicates
// since array has duplicates, when nums[start] == nums[mid], you can't tell left or right.
// for example, 3333123, 3123333.
// just increase start by one.

func findMinII(_ nums: [Int]) -> Int {
    var start = 0, end = nums.count - 1
    
    while start < end {
        // if it is sorted
        if nums[start] < nums[end] {
            return nums[start]
        }
        
        let mid = (start + end) / 2
        
        if nums[mid] > nums[start] {
            start = mid + 1
        } else if nums[mid] < nums[start] {
            end = mid
        } else {
            start += 1
        }
    }
    
    return nums[start]
}
