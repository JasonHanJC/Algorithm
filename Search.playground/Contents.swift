//: Playground - noun: a place where people can play

import UIKit

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


findMedianSortedArrays([1, 9, 12, 15, 26, 38], [2, 13, 17, 30, 45, 55, 56, 57, 78])


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

searchInsertPosition([1,3,5,6], 0)

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

findMinInRotatedSortedArray([6,7,1,2,3,4])


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

findMinInRotatedSortedArrayII([6,7,1,2,3,4,6,6,6])



