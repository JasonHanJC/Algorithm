//: Playground - noun: a place where people can play

/*:
 ## Median of Two Sorted Arrays
 
 There are two sorted arrays A and B of size m and n respectively. Find the median of the
 two sorted arrays. The overall run time complexity should be O(log (m+n)).
 
 Tips: Use binary search. Search kth number in A and B, k is (m + n) / 2.
 
 First, we need make A be the shorter array. Because later we want to remove the correct portion.
 Then, we compare the medians of A and B, if medianA < medianB, we remove all items smaller than
 medianA, and continue next comparison. If medianA > medianB, we remove all items smaller then medianB,
 and continue next comparision. Until, one array is empty or k = 1.
 If one array is empty, return the first item of the other array. If k = 1, return the smaller one of the 
 first items.
 */

func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    
    let m = nums1.count
    let n = nums2.count
    
    return (findKth(nums1, nums2, (m + n + 1)/2 ) + findKth(nums1, nums2, (m + n + 2)/2 )) / 2.0

}

func findKth(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> Double {

    let m = nums1.count, n = nums2.count
    
    // compare length
    if m > n {
        return findKth(nums2, nums1, k)
    }
    
    // is shorter array empty
    if m == 0 {
        return Double(nums2[k - 1])
    }
    
    // is k == 1
    if k == 1 {
        return Double(min(nums1[k - 1], nums2[k - 1]))
    }
    
    // campare
    let i = min(k / 2, m)
    let j = min(k / 2, n)
    
    if nums1[i - 1] < nums2[j - 1] {
        return findKth(Array(nums1[i...m - 1]), nums2, k - i)
    } else {
        return findKth(nums1, Array(nums2[j...n - 1]), k - j)
    }
}


//findMedianSortedArrays([1, 9, 12, 15, 26, 38], [2, 13, 17, 30, 45, 55, 56, 57, 78])


/*:
 ##Search Insert Position
 Given a sorted array and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order. You may assume no duplicates in the array.
 Here are few examples.
 [1,3,5,6], 5 -> 2
 [1,3,5,6], 2 -> 1
 [1,3,5,6], 7 -> 4
 [1,3,5,6], 0 -> 0
 
 Idea: binary search. log(n)
 brute force. O(n)
 */

func searchInsertPosition(_ nums: [Int], _ target: Int) -> Int {
    
    if nums.count == 0 {
        return 0
    }
    
    var i = 0
    var j = nums.count - 1
    
    while i <= j {
        
        let mid = (i + j) / 2
        
        if nums[mid] == target {
            return mid
        } else if nums[mid] < target {
            i = mid + 1
        } else {
            j = mid - 1
        }
    }
    
    return i
}

//searchInsertPosition([1,3,5,6], 0)

/*:
 ##Find Minimum in Rotated Sorted Array
 Suppose a sorted array is rotated at some pivot unknown to you beforehand. (i.e., 0 1 2 4 5 6 7 might become 4 5 6 7 0 1 2).
 Find the minimum element.You may assume no duplicate exists in the array.
 */

func findMinInRotatedSortedArray(_ nums:[Int]) -> Int {
    
    if nums.count == 0 {
        return -1
    }
    
    var i = 0
    var j = nums.count - 1
    
    while i <= j {
        // no rotate or only one item
        if nums[i] <= nums[j] {
            return nums[i]
        }
        
        let mid = (i + j) / 2
        
        // compare to the left one
        if nums[i] > nums[mid] {
            // if nums[i] > nums[mid], nums[mid] could be the smallest one. So we should include mid 
            // in the next checking
            j = mid
        } else {
            // because the most left one is relatively the min one, if nums[mid] > nums[i]
            // nums[mid] is totally not the smallest one. So, we should start from mid + 1
            i = mid + 1
        }
    }
    
    return -1
}

//findMinInRotatedSortedArray([6,7,1,2,3,4])


/*:
 ##Find Minimum in Rotated Sorted Array II
 Follow up for "Find Minimum in Rotated Sorted Array": What if duplicates are allowed?
 
 The new case is the most left one == the most right one [3, 1, 3]
 Remove either one
 */

func findMinInRotatedSortedArrayII(_ nums:[Int]) -> Int {
    
    if nums.count == 0 {
        return -1
    }
    
    var i = 0
    var j = nums.count - 1
    
    while i <= j {
        
        while nums[i] == nums[j] && abs(i - j) > 1 {
            i += 1
        }
        
        if nums[i] <= nums[j] {
            return nums[i]
        }
        
        let mid = (i + j) / 2
        
        
        if nums[i] > nums[mid] {
            j = mid
        } else {
            i = mid + 1
        }
    }
    
    return -1
}

//findMinInRotatedSortedArrayII([6,7,1,2,3,4,6,6,6])


/*:
 ##Search for a Range
 Given a sorted array of integers, find the starting and ending position of a given target value. Your algorithm’s runtime complexity must be in the order of O(log n). If the target is not found in the array, return [-1, -1]. For example, given [5, 7, 7, 8, 8, 10] and target value 8, return [3, 4].
 
 Use binary search to get the left index and then the right index
 */

func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
    
    var res = [-1, -1]
    
    if nums.count == 0 {
        return res
    }
    
    // find left
    res[0] = findIndex(nums, target, true)
    // find right
    res[1] = findIndex(nums, target, false)
    
    return res
}

func findIndex(_ nums: [Int], _ target: Int, _ isLeft: Bool) -> Int {
    
    var i = 0
    var j = nums.count - 1
    
    while i <= j {
        
        let mid = (i + j) / 2
        
        if nums[mid] == target {
            // for [1] case
            if i == j {
                return i
            }
            
            if isLeft {
                j = mid
            } else {
                if i + 1 == j {
                    if nums[i] == nums[j] {
                        return j
                    } else {
                        return i
                    }
                }
                i = mid
            }
        } else if nums[mid] > target {
            j = mid - 1
        } else {
            i = mid + 1
        }
    }
    
    return -1
}

//searchRange([1], 1)


/*: 
 ## Search in Rotated Sorted Array
 Suppose a sorted array is rotated at some pivot unknown to you beforehand. (i.e., 0 1 2 4 5 6 7 might become 4 5 6 7 0 1 2).
 You are given a target value to search. If found in the array return its index, other- wise return -1. You may assume no duplicate exists in the array.
 
 Idea: Understand rotared array: 
 The regular array: [0 1 2 4 5 6 7]
 There are three cases when rotate the array
 Case 1: [6 7 0 1 2 4 5], the mid is 1, 1 < 6, nums[left...mid - 1] is not sorted, nums[mid + 1...right] is sorted
 Case 2: [2 4 5 6 7 0 1], the mid is 6, 2 < 6, nums[left...mid - 1] is sorted, but nums[mid + 1...right] is not sorted
 Case 3: [5 6 7 0 1 2 4], the mid is 0, nums[left...mid - 1] and nums[mid + 1...right] are both sorted.
 
 So, there is always one part of the array is sorted. So we can check whether target is in the part which is sorted, otherwise the target is the another part which could be sorted or not.
 
 The case:
 
 if nums[mid] == target, return mid
 
 if nums[mid] > nums[left] (case 1, right part is always sorted)
    if nums[mid] < target <= nums[right] (in the right part)
        left = mid + 1
    else 
        right = mid - 1
 
 else (case 2, left part is always sorted)
    if nums[left] <= target < nums[mid] (in the left part)
        right = mid - 1
    else 
        left = mid + 1
 
 */

func searchInRotatedSortedArray(_ nums: [Int], _ target: Int) -> Int {
    
    if nums.count == 0 {
        return -1
    }
    
    var i = 0
    var j = nums.count - 1
    
    while i <= j {
        
        let mid = (i + j) / 2
        
        if nums[mid] == target {
            return mid
        }
        
        if nums[mid] < nums[i] {
            
            if nums[mid] < target && nums[j] >= target {
                i = mid + 1
            } else {
                j = mid - 1
            }
        } else {
            
            if nums[mid] > target && nums[i] <= target {
                j = mid - 1
            } else {
                i = mid + 1
            }
        }
    }
    
    return -1
}

//searchInRotatedSortedArray([6,7,1,2,3,4,5], 4)

/*:
 ## Search in Rotated Sorted Array II
 Follow up for "Search in Rotated Sorted Array": what if duplicates are allowed? Write
 a function to determine if a given target is in the array.
 
 Compare to the last question. There is a new case: if nums[mid] == muns[left].
 
 example: [3 3 3 1 2 3]
          [3 3 3 3 1 2]
 
          [3 1 2 3 3 3 3]
          [3 3 3 3 1 2 3]
 when nums[mid] == muns[left], we can't the left and right part are both hard to said it is sorted. we need to skip the duplicate. 

 if nums[mid] == muns[left]
    left += 1
 
 worst case, [3 3 3 3 3 3], target = 1, the complex become O(n)
 */

func searchInRotatedSortedArrayII(_ nums: [Int], _ target: Int) -> Int {

    if nums.count == 0 {
        return -1
    }
    
    var i = 0
    var j = nums.count - 1
    
    while i <= j {
        
        let mid = (i + j) / 2
        
        if nums[mid] == target {
            return mid
        }
        
        if nums[mid] < nums[i] {
            
            if nums[mid] < target && nums[j] >= target {
                i = mid + 1
            } else {
                j = mid - 1
            }
        } else if nums[mid] > nums[i] {
            
            if nums[mid] > target && nums[i] <= target {
                j = mid - 1
            } else {
                i = mid + 1
            }
        } else {
            i += 1
        }
    }
    
    return -1
}

// searchInRotatedSortedArrayII([1,3,1,1,1], 3)

/*:
 ## Square root of an integer
 Given an integer x, find square root of it. If x is not a perfect square, then return floor(√x).
 
 Idea: 1 * 1 = 1, and 1 / 2 = 0
 2 * 2 = 4, and 4 / 2 = 2
 3 * 3 = 9, and 9 / 2 = 4
 4 * 4 = 16, and 16 / 2 = 8
 ...
 n * n = x
 We can see that except s == 1, n is always <= x/2.
 So, n is 1 when x = 1, otherwise n is between 1 and x/2.
 
 Then we can use binary search to find the square root.
 
 */

func sqrt(_ x: Int) -> Int {
    if x < 0 {
        return -1
    }
    if x == 0 {
        return x
    }
    
    var left = 1, right = x/2
    var ans = 1
    while left <= right {
        let mid = left + (right - left) / 2
        let exp = mid * mid
        if exp == x {
            return mid
        }
        
        if exp < x {
            left = mid + 1
            ans = mid
        } else {
            right = mid - 1
        }
    }
    
    return ans
}


/*
 ## Search a 2D Matrix
 Write an efficient algorithm that searches for a value in an m x n matrix. This matrix has the following properties:
 
 Integers in each row are sorted from left to right.
 The first integer of each row is greater than the last integer of the previous row.
 For example,
 
 Consider the following matrix:
 
 [
 [1,   3,  5,  7],
 [10, 11, 16, 20],
 [23, 30, 34, 50]
 ]
 Given target = 3, return true.
 
 We can treat the matrix as a sorted array.
 n*m matrix convert to an array: matrix[x][y] -> a[x*m + y]
 an array convert to a m*n matrix: a[x] -> matrix[x/m][x%m]
 O(log(m*n))
 */

func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
    let n = matrix.count
    let m = matrix[0].count
    
    var l = 0, r = m * n - 1
    while l <= r {
        let mid = (l + r) / 2
        if matrix[mid/m][mid%m] == target {
            return true
        } else if matrix[mid/m][mid%m] < target {
            l = mid + 1
        } else {
            r = mid - 1
        }
    }
    
    return false;
}

/*
 ## Search a 2D Matrix II
 Write an efficient algorithm that searches for a value in an m x n matrix. This matrix has the following properties:
 
 Integers in each row are sorted in ascending from left to right.
 Integers in each column are sorted in ascending from top to bottom.
 For example,
 
 Consider the following matrix:
 
 [
 [1,   4,  7, 11, 15],
 [2,   5,  8, 12, 19],
 [3,   6,  9, 16, 22],
 [10, 13, 14, 17, 24],
 [18, 21, 23, 26, 30]
 ]
 Given target = 5, return true.
 
 Given target = 20, return false.
 
 */

func searchMatrixII(_ matrix: [[Int]], _ target: Int) -> Bool {
    guard matrix.count > 0 else {
        return false
    }
    
    var row = 0, col = matrix[0].count - 1
    
    while row < matrix.count && col >= 0 {
        if matrix[row][col] == target {
            return true
        } else if matrix[row][col] < target {
            row += 1
        } else {
            col -= 1
        }
    }
    
    return false
}



/*
 ## Find Peak Element
 A peak element is an element that is greater than its neighbors.
 
 Given an input array where num[i] ≠ num[i+1], find a peak element and return its index.
 
 The array may contain multiple peaks, in that case return the index to any one of the peaks is fine.
 
 You may imagine that num[-1] = num[n] = -∞.
 
 For example, in array [1, 2, 3, 1], 3 is a peak element and your function should return the index number 2.
 
 click to show spoilers.
 
 Note:
 Your solution should be in logarithmic complexity.
 */


/*:
 ## Find the closest element in Binary Search Tree
 Given a binary search tree and a target node K. The task is to find the node with minimum absolute difference with given target value K.
 
 */



/*:
 ## Find the closest element in Binary Search Tree II
 Given a binary search tree and a target node K. The task is to find the node with minimum absolute difference with given target value K.
 
 Follow up:
 Assume that the BST is balanced, could you solve it in less than O(n) runtime (where n = total nodes)?
 
 */


































