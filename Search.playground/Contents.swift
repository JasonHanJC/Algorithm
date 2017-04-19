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


