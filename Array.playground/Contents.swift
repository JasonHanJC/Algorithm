

import UIKit

func twoSum(_ a:[Int], b:Int) -> [(Int, Int)] {
    
    var dic = [Int : Int]()
    
    var res = [(Int, Int)]()
    for i in 0..<a.count {
        if let newK = dic[a[i]] {
            res.append((newK, i))
        } else {
            dic[b - a[i]] = i
        }
    }
    return res
}

twoSum([7, 2, 23, 8, -1, 0, 11, 6] , b: 10)

/*:
 ## Two Sum with sorted array
 
 */

func twoSumWithSorted(_ a: [Int], b: Int) -> (Int, Int)? {
    
    var l = 0
    var r = a.count - 1
    
    while l < r {
        let sum = a[l] + a[r]
        
        if sum == b {
            return (l , r)
        } else if sum < b {
            l += 1
        } else {
            r -= 1
        }
    }
    
    return nil
}

let a = [2, 3, 4, 4, 7, 8, 9, 10, 12, 14, 21, 22, 100]
twoSumWithSorted(a, b: 10)

/*:
 ## Two Sum Structure
 
 */

class TwoSum {
    
    private var dic = [Int : Int]()
    
    func add(_ a: Int) {
        if let num = dic[a] {
            dic[a] = num + 1
        } else {
            dic[a] = 1
        }
    }
    
    func find(_ val: Int) -> Int {
        for (a ,number) in dic {
            let target = val - a
            if target == a && number < 2 {
                continue
            }
            if dic[target] != nil {
                return 1
            }
        }
        return 0
    }
}

let twoSum = TwoSum()

twoSum.add(1)
twoSum.add(3)
twoSum.add(4)
twoSum.add(8)
twoSum.add(6)
twoSum.add(10)

twoSum.find(8)

/*:
 ## Three Sum
 
 */

func threeSum(_ nums: [Int], target: Int) -> [[Int]]? {
    
    if (nums.count < 3) {
        return nil;
    }
    
    var res = [[Int]]()
    
    let sortedNums = nums.sorted()
    
    
    
    for i in 0..<sortedNums.count - 2 {
        
        // check the duplicate for first number
        if i == 0 || sortedNums[i] != sortedNums[i - 1] {
            var j = i + 1
            var k = sortedNums.count - 1
    
            while j < k {
    
                if sortedNums[i] + sortedNums[j] + sortedNums[k] == target {
    
                    res.append([sortedNums[i], sortedNums[j], sortedNums[k]])
    
                    j += 1
                    k -= 1
    
                    // check dupliacte for second and third number
                    while j < k && sortedNums[j] == sortedNums[j - 1] {
                        j += 1
                    }
                    while j < k && sortedNums[k] == sortedNums[k + 1] {
                        k -= 1
                    }
                } else if sortedNums[i] + sortedNums[j] + sortedNums[k] < target {
                    j += 1
                } else {
                    k -= 1
                }
            }
        }
    }
    
    return res
}


let res = threeSum([-1, 0, 1, 2, -1, -4], target: 0)


/*:
 ## Four sum
 */

func fourSum(_ nums: [Int], target: Int) -> [[Int]] {
    
    var res = [[Int]]()
    
    if nums.count < 4 {
        return res
    }
    
    let sorted = nums.sorted()
    
    for i in 0..<sorted.count - 3 {
        guard i == 0 || sorted[i] != sorted[i-1] else {
            continue
        }
        
        let threeSum = target - sorted[i]
        
        for j in i + 1..<sorted.count - 2 {
            guard j == 0 || sorted[j] != sorted[j-1] else {
                continue
            }
            
            let twoSum = threeSum - sorted[j]
            
            var l = j + 1
            var r = sorted.count - 1
            
            while l < r {
                if sorted[l] + sorted[r] == twoSum {
                    
                    res.append([sorted[i], sorted[j], sorted[l], sorted[r]])
                    
                    l += 1
                    r -= 1
                    
                    while l < r && sorted[l] == sorted[l-1] {
                        l += 1
                    }
                    while l < r && sorted[r] == sorted[r+1] {
                        r -= 1
                    }
                } else if sorted[l] + sorted[r] > twoSum {
                    r -= 1
                } else {
                    l += 1
                }
            }
        }
    }
    
    return res
}


fourSum([1, 0, -1, 0, -2, 2], target: 0)


/*:
 ## Three sum closet
 
 return the closet sum value for target
 */

func threeSumCloset(_ nums:[Int], target: Int) -> Int {
    
    var res = 0
    var minDiff = Int.max
    
    let sorted = nums.sorted()
    
    for i in 0..<sorted.count - 2 {
        // remove duplicates
        guard i == 0 || sorted[i] != sorted[i - 1] else {
            continue
        }
        
        var j = i + 1
        var k = nums.count - 1
        
        while j < k {
            
            let sum = sorted[i] + sorted[j] + sorted[k]
            let diff = abs(target - sum)
            
            if diff == 0 {
                return sum
            }
            
            if minDiff > diff {
                res = sum
                minDiff = diff
            }
            
            if sum > target {
                repeat {
                    k -= 1
                } while j < k && sorted[k] == sorted[k + 1]
            } else {
                repeat {
                   j += 1
                } while j < k && sorted[j] == sorted[j - 1]
            }
        }
    }
    
    return res
}

threeSumCloset([-1, 2, 1, -4], target: 1)

/*:
 ## Minimum Size Subarray Sum
 
 Given an array of n positive integers and a positive integer s, find the minimal length of a subarray of which the sum ≥ s. If there isn’t one, return 0 instead.
 For example, given the array [2,3,1,2,4,3] and s = 7, the subarray [4,3] has the minimal length of 2 under the problem constraint.
 */

func minSubArrayLen(_ nums: [Int], s: Int) -> Int {
    
    var start = 0
    var i = 0
    var sum = 0
    var len  = nums.count
    
    var exist: Bool = false
    
    while i <= nums.count {
        
        if sum < s {
            if i == nums.count {
                break
            }
            
            sum += nums[i]
            i += 1
            
        } else {
            
            exist = true
            
            // check the min possibility
            if start == i - 1 {
                return 1
            }
            
            len = min(len, i - start)
            sum -= nums[start]
            start += 1
        }
    }
    
    if exist == true {
        return len
    } else {
        return 0
    }
}

minSubArrayLen([2,3,1,2,4,3], s: 7)

/*:
 ##Remove Duplicates from Sorted Array
 Given a sorted array, remove the duplicates in place such that each element appear only once and return the new length. Do not allocate extra space for another array, you must do this in place with constant memory.
 For example, given input array A = [1,1,2], your function should return length = 2, and A is now [1,2].
 
 The easist way is using the length minus dupliacted time
 */

func removeDuplicatesFromSortedArray(_ nums: [Int]) -> Int {
    
    var count = 0
    for i in 0..<nums.count - 1 {
        if nums[i] == nums[i + 1] {
            count += 1
        }
    }
    
    return nums.count - count
}

// use in place mothed
func removeDuplicatesFromSortedArraySolution2(_ nums: inout [Int]) -> Int {
    
    var j = 0
    for i in 0..<nums.count - 1 {
        if nums[i] != nums[j] {
            j += 1
            nums[j] = nums[i]
        }
    }
    
    return j + 1
}

var removeDuplicatesFromSortedArraySolution2Array = [1,1,2,2,3,4]
removeDuplicatesFromSortedArraySolution2(&removeDuplicatesFromSortedArraySolution2Array)

/*:
 ##Remove Duplicates from Sorted Array II
 Follow up for "Remove Duplicates": What if duplicates are allowed at most twice? For example, given sorted array A = [1,1,1,2,2,3], your function should return length
 = 5, and A is now [1,1,2,2,3].
 So this problem also requires in-place array manipulation.
 
 keep a index, compare between the element at that index, the element at index - 1, and the element moving forward
 
 [1, 1, 1, 1, 2, 2, 3]
 after transfer
 [1, 1, 2, 2, 3, 2, 3]
 
 */
func removeDuplicatesFromSortedArray_2(_ nums:inout [Int]) -> Int {
    // edge case
    if nums.count <= 2 {
        return nums.count
    }
    
    var pre = 1
    for cur in 2 ..< nums.count {
        if nums[pre] == nums[cur] && nums[pre - 1] == nums[cur] {
            continue
        } else {
            pre += 1
            nums[pre] = nums[cur]
        }
    }
    
    return pre + 1
}

var input = [1,1,1,1,2,2,3]
removeDuplicatesFromSortedArray_2(&input)


/*:
 ## Remove Element
 Given an array and a value, remove all instances of that value in place and return the new length. (Note: The order of elements can be changed. It doesn’t matter what you leave beyond the new length.)
 
 if just return the length, you can just count the number of the removed target, the length - count
 but is you want to return the new array in place
 the basic idea is going througt the array, using the non-target to replace the target, and keep tracking the new array length
 */

func removeElementSolution_1(_ nums: inout [Int], target: Int) -> ArraySlice<Int> {
    
    var j = 0
    for i in 0...nums.count - 1 {
        
        if nums[i] != target {
            nums[j] = nums[i]
            j += 1
        }
    }

    let res =  nums[0...j-1]
    return res
}

var input_1 = [1,1,1,1,2,2,3]
removeElementSolution_1(&input_1, target: 1)

/*:
 ## Move Zeroes
 Given an array nums, write a function to move all 0’s to the end of it while maintaining the relative order of the non-zero elements.
 For example, given nums = [0, 1, 0, 3, 12], after calling your function, nums should be [1, 3, 12, 0, 0].
 */

func moveZeros(_ nums: inout [Int]) {
    
    var j = 0
    for i in 0...nums.count - 1 {
        
        if nums[i] != 0 {
            nums[j] = nums[i]
            j += 1
        }
    }
    
    while j < nums.count {
        nums[j] = 0
        j += 1
    }
}

var moveZerosArray = [1, 0, 0, 2, 3, 4]
moveZeros(&moveZerosArray)


/*:
 ## Container With Most Water
 
 Given n non-negative integers a1, a2, ..., an, where each represents a point at coordi- nate (i, ai). n vertical lines are drawn such that the two endpoints of line i is at (i, ai) and (i, 0). Find two lines, which together with x-axis forms a container, such that the container contains the most water.
 
 Idea: use two pointer left and right, if leftVal < rightVal, left ++, else right--, until left >= right. Keep tracking the size, min(leftVal, rightVal) * (right - left)
 */

// func containerWithMostWater


func containerWithMostWater(_ nums: [Int]) -> Int {
    
    var maxSize = 0
    
    guard nums.count > 1 else {
        return maxSize
    }
    
    var l = 0
    var r = nums.count - 1
    
    while l < r {
        
        let curSize = min(nums[l], nums[r]) * (r - l)
        maxSize = max(maxSize, curSize)
        
        if nums[l] < nums[r] {
            l += 1
        } else {
            r -= 1
        }
    }
    
    return maxSize
}

containerWithMostWater([1, 0, 0, 2, 3, 4])


/*:
 ## Candy
 There are N children standing in a line. Each child is assigned a rating value. You are giving candies to these children subjected to the following requirements:
 1. Each child must have at least one candy. 2. Children with a higher rating get more candies than their neighbors.
 What is the minimum candies you must give?
 
 Tip: The same rating will not have the same candies. only consider higher rating
 */

func candy(_ ratings: [Int]) -> Int {
    
    if ratings.count == 1 {
        return 1
    }
    
    var res = 0
    
    // give everyone a candy
    var candy = Array(repeating: 1, count: ratings.count)
    
    // left to right
    for i in 0...ratings.count - 2 {
        if ratings[i] < ratings[i + 1] {
            candy[i + 1] = candy[i] + 1
        }
    }

    // right to left
    for r in (1...ratings.count - 1).reversed() {
        if ratings[r] < ratings[r - 1] {
            candy[r - 1] = max(candy[r] + 1, candy[r - 1])
        }
    }
    
    for i in 0...candy.count - 1 {
        res += candy[i]
    }
    
    return res
}

candy([1,2,2])

/*:
 ##Trapping Rain Water
 Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it is able to trap after raining.
 For example, given [0,1,0,2,1,0,1,3,2,1,2,1], return 6.
 
 Idea: left to right, keep tracking the current highest bar, calculate the possible water trap by highest height - current bar height, store them in a array.
 right to left, same as above
 compare two possible traping water arrays, the min(left, right) is the real traping wather vol
 */

func trappingRainWater(_ barHeight: [Int]) -> Int {
    
    if barHeight.count < 3 {
        return 0
    }
    
    var left = Array(repeating: 0, count: barHeight.count)
    var right = Array(repeating: 0, count: barHeight.count)
    
    var maxBar = 0
    
    // left to right
    for i in 0...barHeight.count - 2 {
        maxBar = max(maxBar, barHeight[i])
        
        if barHeight[i + 1] < maxBar {
            left[i + 1] = maxBar - barHeight[i + 1]
        }
    }
    
    maxBar = 0
    
    // right to left
    for i in (1...barHeight.count - 1).reversed() {
         maxBar = max(maxBar, barHeight[i])
        
        if barHeight[i - 1] < maxBar {
            right[i - 1] = maxBar - barHeight[i - 1]
        }
    }
    
    // calculate the water volume
    var res = 0
    for i in 0...left.count - 1 {
        res += min(left[i], right[i])
    }
    
    return res
}

trappingRainWater([0,1,0,2,1,0,1,3,2,1,2,1])










