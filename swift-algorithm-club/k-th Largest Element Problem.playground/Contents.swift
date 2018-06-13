//: k-th largest element problem.
// You're given an integer array a. Write an algorithm that finds the k-th largest element in the array.

// For example, the 1-st largest element is the maximum value that occurs in the array. If the array has n elements, the n-th largest element is the minimum. The median is the n/2-th largest element.

// First way, sort the array, and then return array[count - k], O(nlogn)
// Faster way, use the idea of binary search and quick sort. In quick sort, we choose a random pivot, and then place all elements which are smaller than pivot to the left of the pivot, and place all elements which are greater than pivot to the right of the pivot. After this partition, the array is not sorted but the pivot is at the right position with index pIndex.(In quicksort, we continously and recusively do the partition for the left part and right part). If the pIndex is greater the k-th, we get the k-th elment is smaller than pivot, and it in the left side of the pivot, otherwise it in the right side of the pivot. Then I do the some thing to the left or right part, until we find a pivot with index equal to k-th. Since we only partition smaller and smaller slice of the array. The running time is O(n)

import Foundation

func findKthLargest(_ nums: [Int], _ k: Int) -> Int {

    var a = nums
    return helper(&a, low: 0, high: a.count - 1, k: nums.count - k)
}

func helper(_ nums: inout [Int], low: Int, high: Int, k: Int) -> Int {
    if low < high {
        let pIndex = partition(&nums, low: low, high: high)
        if pIndex == k {
            return nums[pIndex]
        } else if pIndex < k {
            return helper(&nums, low: pIndex+1, high: high, k: k)
        } else {
            return helper(&nums, low: low, high: pIndex-1, k: k)
        }
    } else {
        return nums[low]
    }
}

func partition(_ nums: inout [Int], low: Int, high: Int) -> Int {
    //print("before: \(nums)")
    func randomPivot() -> Int {
        let randomIndex = random(low, high)
        let pivot = nums[randomIndex]
        swap(&nums, a: randomIndex, b: high)
        return pivot
    }
    
    let pivot = randomPivot()
    var i = low
    for j in low..<high {
        if nums[j] <= pivot {
            swap(&nums, a: i, b: j)
            i += 1
        }
    }
    // swap back the pivot
    swap(&nums, a: i, b: high)

    return i
}

func random(_ lower: Int, _ upper: Int) -> Int {
    let randomNumber = Int(arc4random_uniform(UInt32(upper - lower))) + lower
    return randomNumber
}

func swap(_ nums: inout [Int], a: Int, b: Int) {
    guard a >= 0 && a < nums.count && b >= 0 && b < nums.count else {
        return
    }
    (nums[a], nums[b]) = (nums[b], nums[a])
    //print(nums)
}


//var array = [-1, 0, 6, 7, 9, 11, 23, 92]
//swap(&array, a: 0, b: 1)
findKthLargest([ 7, 92, 23, 9, -1, 0, 11, 6 ], 1)
