

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

/*:
 ##Summary Ranges
 Given a sorted integer array without duplicates, return the summary of its ranges for consecutive numbers.
 For example, given [0,1,2,4,5,7], return ["0->2","4->5","7"].
 
 Idea: brute force
 */

func summaryRanges(_ nums: [Int]) -> [String] {
    
    var res = [String]()
    
    if nums.count == 0 {
        return res
    } else if nums.count == 1 {
        res.append("\(nums[0])")
        return res
    }
    
    var startNum = nums[0]
    
    for i in 1...nums.count - 1 {
        if nums[i] - nums[i - 1] > 1 {
            let endNum = nums[i - 1]
            if endNum == startNum {
                res.append("\(startNum)")
            } else {
                res.append("\(startNum)->\(endNum)")
            }
            startNum = nums[i]
        }
    }
    
    if nums.last == startNum {
        res.append("\(startNum)")
    } else {
        res.append("\(startNum)->\(nums.last!)")
    }
    
    return res
}

summaryRanges([0,1,2,4,5,7])

/*:
 ## Merge Sorted Array
 Given two sorted integer arrays A and B, merge B into A as one sorted array.
 Note: You may assume that A has enough space to hold additional elements from B. The number of elements initialized in A and B are m and n respectively.

 The idea is starting comparing from the tail, and place the res backward
 */

func mergeSortedArray(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
    
    var i = m - 1
    var j = n - 1
    
    while i >= 0 && j >= 0 {
        if nums1[i] > nums2[j] {
            nums1[i + j + 1] = nums1[i]
            i -= 1
        } else {
            nums1[i + j + 1] = nums2[j]
            j -= 1
        }
    }
    
    // if i >= 0, we don't have to do anything
    // only take care about nums2 is not empty
    while j >= 0 {
        nums1[j] = nums2[j]
        j -= 1
    }
}


/*: 
 ##Shortest Word Distance
 Given a list of words and two words word1 and word2, return the shortest distance between these two words in the list.
 For example, Assume that words = ["practice", "makes", "perfect", "coding", "makes"].
 Given word1 = “coding”, word2 = “practice”, return 3. Given word1 = "makes", word2 = "coding", return 1.
 
 Idea: Iterate and update index and distance when encounter word1 or word2
 */

func shortestWordDistance(_ words: [String], _ word1: String, _ word2: String) -> Int {
    
    var m = -1
    var n = -1
    
    var minDis = Int.max
    
    for i in 0...words.count - 1 {
        if words[i] == word1 {
            
            m = i
            if n != -1 {
                minDis = min(minDis, abs(m - n))
            }
            
        } else if words[i] == word2 {
            n = i
            if m != -1 {
                minDis = min(minDis, abs(m - n))
            }
        }
    }
    
    return minDis
}

shortestWordDistance(["practice", "makes", "perfect", "coding", "makes"], "coding", "practice")

/*:
 ##Shortest Word Distance III
 This is a follow-up problem of Shortest Word Distance. The only difference is now word1 could be the same as word2.
 Given a list of words and two words word1 and word2, return the shortest distance between these two words in the list.
 word1 and word2 may be the same and they represent two individual words in the list.
 For example, Assume that words = ["practice", "makes", "perfect", "coding", "makes"].
 Given word1 = “makes”, word2 = “coding”, return 1. Given word1 = "makes", word2 = "makes", return 3.
 
 Iterate and update index and distance when encounter word1 or word2, use
 *			     a temp variable to memorize the previous postion if word1 == word2
 */

func shortestWordDistanceIII(_ words: [String], _ word1: String, _ word2: String) -> Int {
    
    var m = -1
    var n = -1
    
    var distance = Int.max
    
    for (index, word) in words.enumerated() {
        
        let prev = m
        
        if word == word1 {
            m = index
        }
        
        if word == word2 {
            n = index
        }
        
        if m != -1 && n != -1 {
            // word1 == word2
            if word1 == word2 && prev != -1 && prev != m {
                distance = min(distance, abs(m - prev))
            }
            // word1 != word2
            else if m != n {
                distance = min(distance, abs(m - n))
            }
        }
    }
    
    return distance
}

/*:
 ## Intersection of Two Arrays
 Given two arrays, write a function to compute their intersection.
 Example: Given nums1 = [1, 2, 2, 1], nums2 = [2, 2], return [2].
 Just return the same item once. So we can use Set to solve the problem
 */

func intersectionOfArrays(_ array1: [Int], _ array2: [Int]) -> [Int] {

    let resSet = Set<Int>(array1).intersection(array2)
    
    return Array<Int>(resSet)
}

let array1 = [1,2,3,4,5,5,6]
let array2 = [1,5,5,6]

//intersectionOfArrays(array1, array2)

/*:
 ## Intersection of Two Arrays II
 Given two arrays, write a function to compute their intersection.
 Example: Given nums1 = [1, 2, 2, 1], nums2 = [2, 2], return [2, 2].
 
 Use Set is not good in here. Sort two arrays. Iterate to find all common items.
 */

func intersectionOfArraysII(_ array1: [Int], _ array2: [Int]) -> [Int] {
    
    let sorted1 = array1.sorted()
    let sorted2 = array2.sorted()
    
    var i = 0, j = 0
    var res = [Int]()
    
    while i < sorted1.count && j < sorted2.count {
        
        if sorted1[i] == sorted2[j] {
            res.append(sorted1[i])
            i += 1
            j += 1
        } else if sorted1[i] < sorted2[j] {
            i += 1
        } else {
            j += 1
        }
    }
    
    return res
}

intersectionOfArraysII(array1, array2)

/*:
 ## Largest Rectangle in Histogram
 Given n non-negative integers representing the histogram’s bar height where the width
 of each bar is 1, find the area of largest rectangle in the histogram.
 
 
 */


/*:
 ## Contains Duplicate
 Given an array of integers, find if the array contains any duplicates. Your function should return true if any value appears at least twice in the array, and it should return false if every element is distinct.
 
 Idea: Using a set to check deplicates
 */

func containsDuplicates(_ nums: [Int]) -> Bool {
    return nums.count == Set(nums).count
}


/*:
 ## Contains Duplicate II
 Given an array of integers and an integer k, find out whether there are two distinct indices i and j in the array such that nums[i] = nums[j] and the absolute difference between i and j is at most k.
 
 Idea 1: use dictionary to store the each digit's prev index. When a digit appears again, calculate the distance and compare to k.
 
 Idea 2: use two pointer i and j, both start at 0 and not greater than nums.count - 1. The idea is only checking two digits within k distance, so j - i < k.
 */

// O(n) Space O(1)
func containsDuplicateII(_ nums: [Int], _ k: Int) -> Bool {
    
    if nums.count < 2 || k == 0 {
        return false
    }
    
    // key is the integer, value is the index
    var dic = [Int : Int]()
    
    for (index, i) in nums.enumerated() {
        
        if let preIndex = dic[i], index - preIndex <= k {
            return true
        }
        dic[i] = index
    }
    
    return false
}

// O(n) Space O(1)
func containsDuplicateII_2(_ nums: [Int], _ k: Int) -> Bool {
    var i = 0, j = 0
    let k = abs(k)
    
    if k == 0 {
        return false
    }
    
    while j < nums.count && i < nums.count {
        if i != j && nums[i] == nums[j] {
            return true
        }
        
        if j - i < k && j < nums.count - 1 {
            j += 1
            continue
        }
        
        i += 1
    }
    
    return false
}


//containsDuplicateII([1, 2, 3, 4, 5, 6, 3], 3)

/*:
 ##Gas Station
 There are N gas stations along a circular route, where the amount of gas at station i is gas[i].
 
 You have a car with an unlimited gas tank and it costs cost[i] of gas to travel from station i to its next station (i+1). You begin the journey with an empty tank at one of the gas stations.
 
 Return the starting gas station's index if you can travel around the circuit once, otherwise return -1.
 
 Idea: keep updating the left gas after arriving the next gas station. If left gas < 0, update the starting gas station's index. If the sum of all gas is smaller than sum of all cost, return -1
 */

func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
    
    if gas.count != cost.count {
         return -1
    }
    
    var leftGas = 0
    var total = 0
    var startIndex = 0
    
    for (index, curGas) in gas.enumerated() {
        
        leftGas += curGas - cost[index]
        total += curGas - cost[index]
        
        if leftGas < 0 {
            startIndex = index + 1
            leftGas = 0
        }
    }
    
    if total < 0 {
        return -1
    }
    return startIndex
}


/*:
 ## Heaters
 Winter is coming! Your first job during the contest is to design a standard heater with fixed warm radius to warm all the houses.
 
 Now, you are given positions of houses and heaters on a horizontal line, find out minimum radius of heaters so that all houses could be covered by those heaters.
 
 So, your input will be the positions of houses and heaters seperately, and your expected output will be the minimum radius standard of heaters.
 
 Note:
 Numbers of houses and heaters you are given are non-negative and will not exceed 25000.
 Positions of houses and heaters you are given are non-negative and will not exceed 10^9.
 As long as a house is in the heaters' warm radius range, it can be warmed.
 All the heaters follow your radius standard and the warm radius will the same.
 Example 1:
 Input: [1,2,3],[2]
 Output: 1
 Explanation: The only heater was placed in the position 2, and if we use the radius 1 standard, then all the houses can be warmed.
 Example 2:
 Input: [1,2,3,4],[1,4]
 Output: 1
 Explanation: The two heater was placed in the position 1 and 4. We need to use radius 1 standard, then all the houses can be warmed.
 
 */
 
func findRadius(_ houses: [Int], _ heaters: [Int]) -> Int {
    var i = 0, radius = 0
    let houses = houses.sorted(), heaters = heaters.sorted()
    
    for house in houses {
        while i < heaters.count - 1 && abs(heaters[i] - house) >= abs(heaters[i + 1] - house) {
            i += 1
        }
        
        radius = max(radius, abs(house - heaters[i]))
    }
    
    return radius
}

/*:
 ## Max Consecutive Ones
 Given a binary array, find the maximum number of consecutive 1s in this array.
 
 Example 1:
 Input: [1,1,0,1,1,1]
 Output: 3
 Explanation: The first two digits or the last three digits are consecutive 1s.
 The maximum number of consecutive 1s is 3.
 */

func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
    var maxL = 0
    var current = 0
    
    for i in nums {
        if i == 1 {
            current += 1
        } else {
            maxL = max(maxL, current)
            current = 0
        }
    }
    
    maxL = max(maxL, current)
    
    return maxL
}

/*:
 ## Majority Element
 Given an array of size n, find the majority element. The majority element is the element that appears more than ⌊ n/2 ⌋ times.
 
 You may assume that the array is non-empty and the majority element always exist in the array.
 
 Idea 1: Since nums is not empty, and there will always has one elemnt's count > n/2,
 then sort the array and the mid one is the result. O(nlogn)
 
 Idea 2: Boyer–Moore majority vote algorithm
 https://en.wikipedia.org/wiki/Boyer%E2%80%93Moore_majority_vote_algorithm
 Initialize an element m and a counter i with i = 0
 For each element x of the input sequence:
 If i = 0, then assign m = x and i = 1
 else if m = x, then assign i = i + 1
 else assign i = i − 1
 Return m
 */

func majorityElement(_ nums: [Int]) -> Int {
    
    var count = 0
    var res = 0
    
    for i in nums {
        if count == 0 {
            res = i
            count += 1
        } else if i == res {
            count += 1
        } else {
            count -= 1
        }
    }
    
    return res
}

/*:
 ## Majority Element II
 Given an integer array of size n, find all elements that appear more than ⌊ n/3 ⌋ times. The algorithm should run in linear time and in O(1) space.
 
 Idea: Boyer–Moore majority vote algorithm
 Since we are finding the elements that appear more than [n/3], there are no more than 2 possible elements.
 We can change the Boyer–Moore majority vote algorithm that count two elements, note don't forget to check whether the count is correct
 */

func majorityElementII(_ nums: [Int]) -> [Int] {
    
    var count0 = 0, count1 = 0
    var res0: Int?
    var res1: Int?
    
    var res = [Int]()
    
    for num in nums {
        // note the if sequance
        if let res0 = res0, num == res0 {
            count0 += 1
        } else if let res1 = res1 ,num == res1 {
            count1 += 1
        } else if count0 == 0 {
            res0 = num
            count0 += 1
        } else if count1 == 0 {
            res1 = num
            count1 += 1
        } else {
            count0 -= 1
            count1 -= 1
        }
    }
    
    count0 = 0
    count1 = 0
    
    for num in nums {
        if let res0 = res0, num == res0 {
            count0 += 1
        }
        if let res1 = res1, num == res1 {
            count1 += 1
        }
    }
    
    if count0 > nums.count / 3 {
        res.append(res0!)
    }
    
    if count1 > nums.count / 3 {
        res.append(res1!)
    }
    
    return res
}

//majorityElementII([0,-1,2,-1])


/*:
 ## Longest Consecutive Sequence
 Given an unsorted array of integers, find the length of the longest consecutive elements sequence.
 
 For example,
 Given [100, 4, 200, 1, 3, 2],
 The longest consecutive elements sequence is [1, 2, 3, 4]. Return its length: 4.
 
 Your algorithm should run in O(n) complexity.
 
 Idea: use dictionary to keep tracking the sequence and store the length for the boundary points. For example, [1, 2, 3, 4, 5], dic[1] should be 5, and dic[5] should be 5
 */

func longestConsecutive(_ nums: [Int]) -> Int {

    var longest = 0
    var dic = [Int : Int]()
    
    for num in nums {
        
        if dic[num] != nil {
            continue
        } else {
            
            let leftLen = dic[num - 1] ?? 0
            let rightLen = dic[num + 1] ?? 0
            let total = leftLen + rightLen + 1
            
            // update the longest
            longest = max(longest, total)
            
            dic[num] = total
            
            // update the boundary length
            if leftLen != 0 {
                dic[num - leftLen] = total
            }
            
            if rightLen != 0 {
                dic[num + rightLen] = total
            }
        }
    }
    
    return longest
}

//longestConsecutive([0, 1, 2, 3, 4])


/*:
 ## Island Perimeter
 You are given a map in form of a two-dimensional integer grid where 1 represents land and 0 represents water. Grid cells are connected horizontally/vertically (not diagonally). The grid is completely surrounded by water, and there is exactly one island (i.e., one or more connected land cells). The island doesn't have "lakes" (water inside that isn't connected to the water around the island). One cell is a square with side length 1. The grid is rectangular, width and height don't exceed 100. Determine the perimeter of the island.
 
 Example:
 
 [[0,1,0,0],
 [1,1,1,0],
 [0,1,0,0],
 [1,1,0,0]]
 
 Answer: 16
 Explanation: The perimeter is the 16 yellow stripes in the image below:
 ![island.png](island.png)
 
 Idae: The default single island has 4 Perimeter, check its left and top neighbors, if it has, minus number of neighbors * 2
 */


func islandPerimeter(_ grid: [[Int]]) -> Int {
    let n = grid.count
    let m = grid[0].count
    var res = 0
    
    for i in 0..<n {
        for j in 0..<m {
            
            if grid[i][j] == 0 {
                continue
            } else {
                
                res += 4
                // top neighbor
                if i - 1 >= 0 && grid[i - 1][j] == 1 {
                    res -= 2
                }
                
                if j - 1 >= 0 && grid[i][j - 1] == 1 {
                    res -= 2
                }
            }
        }
    }
    
    return res
}

//islandPerimeter([[0,1,0,0],[1,1,1,0],[0,1,0,0],[1,1,0,0]])

/*:
 ## Maximum Size Subarray Sum Equals k
 Given an array nums and a target value k, find the maximum length of a subarray that sums to k. If there isn't one, return 0 instead.
 
 Example 1:
 Given nums = [1, -1, 5, -2, 3], k = 3,
 return 4. (because the subarray [1, -1, 5, -2] sums to 3 and is the longest)
 
 Example 2:
 Given nums = [-2, -1, 2, 1], k = 1,
 return 2. (because the subarray [-1, 2] sums to 1 and is the longest)
 
 Follow Up:
 Can you do it in O(n) time?
 
 Idea: CumSum. Iterate the array, and use dictionary to store the current sum as key and current index as value.
 
 if current sum == k, update the longest size by max(maxLen, currentIndex + 1)
 else check whether the dictionary contains [currentSum - k], it means we find a possible sequence in between the array, then update the longest size be max(maxLen, currentIndex - differIndex)
 for multiple sum, we store the index as left as possible, simply don't update the index in the dictionary
 
 ![MaximumSizeSubarraySumEqualsk](MaximumSizeSubarraySumEqualsk.JPG)
 
 */

func maximumSizeSubarraySumEqualsK(_ nums: [Int], _ k: Int) -> Int {
    
    var sum = 0
    var dic = [Int : Int]()
    var longest = 0
    
    for (i, num) in nums.enumerated() {
        
        sum += num
        
        if sum == k {
            longest = max(longest, i + 1)
        }
        
        if let diffIndex = dic[sum - k] {
            longest = max(longest, i - diffIndex)
        }
        
        if dic[sum] == nil {
            dic[sum] = i
        }
    }
    
    return longest
}

//maximumSizeSubarraySumEqualsK([1], 0)

/*:
 ## Next Permutation
 Implement next permutation, which rearranges numbers into the lexicographically next greater permutation of numbers.
 
 If such arrangement is not possible, it must rearrange it as the lowest possible order (ie, sorted in ascending order).
 
 The replacement must be in-place, do not allocate extra memory.
 
 Here are some examples. Inputs are in the left-hand column and its corresponding outputs are in the right-hand column.
 1,2,3 → 1,3,2
 
 3,2,1 → 1,2,3
 
 1,1,5 → 1,5,1

 ![nextPermutation](nextPermutation.JPG)
 Idea: 
 1. starting from right, find the first one which is less than its previous one, store the index i
 2. then starting from right again, find the first one which is greater than num at index i, store the index j.
 3. swap number at i and j
 4. reverse all number from index i + 1 to nums.count - 1
 
 */

func nextPermutation(_ nums: inout [Int]) {
    
    if nums.count == 1 || nums.count == 0 {
        return
    }
    
    var i = nums.count - 1
    var pre = Int.min
    // first step
    while i >= 0 {
        if nums[i] < pre {
            break
        } else {
            pre = nums[i]
            i -= 1
        }
    }
    
    var j = nums.count - 1
    // second step, note: [3, 2, 1], i will be -1, don't need to swap. Just reverse
    if i > -1 {
        while j >= 0 {
            if nums[j] > nums[i] {
                break
            } else {
                j -= 1
            }
        }
        swap(&nums, i, j)
    }
    
    i += 1
    j = nums.count - 1
    
    while i < j {
        swap(&nums, i, j)
        i += 1
        j -= 1
    }
}

func swap<T>(_ nums: inout [T], _ i: Int, _ j: Int) {
    let tmp = nums[i]
    nums[i] = nums[j]
    nums[j] = tmp;
}

//var nums = [3,2,1]
//nextPermutation(&nums)

/*:
 ## Number of Boomerangs
 Given n points in the plane that are all pairwise distinct, a "boomerang" is a tuple of points (i, j, k) such that the distance between i and j equals the distance between i and k (the order of the tuple matters).
 
 Find the number of boomerangs. You may assume that n will be at most 500 and coordinates of points are all in the range [-10000, 10000] (inclusive).
 
 Example:
 Input:
 [[0,0],[1,0],[2,0]]
 
 Output:
 2
 
 Explanation:
 The two boomerangs are [[1,0],[0,0],[2,0]] and [[1,0],[2,0],[0,0]]
 
 Idea: Since all points are distinct, we can iterate each point, and calculate the distance between other points. Use a dictionary to store the distance as key and number of paired points as value. Then, we calculate the number of permutation for each distance.
 The permutation fomula is n!/(n − r)!, n is the number of all items, r is number of items you choose.
 
 */

func numberOfBoomerangs(_ points: [[Int]]) -> Int {
    var num = 0
    
    for (i, point) in points.enumerated() {
        var dict = [Int: Int]()
        for (j, anotherpoint) in points.enumerated() {
            if i == j {
                continue
            }
            
            let distance = getSqDistance(point, anotherpoint)
            
            if let sameDistancePoints = dict[distance] {
                dict[distance] = sameDistancePoints + 1
            } else {
                dict[distance] = 1
            }
        }
        
        for key in dict.keys {
            // since n choose 2 's permutation, n!/(n - 2)! = n * (n - 1)
            num += dict[key]! * (dict[key]! - 1)
        }
    }
    return num
}

func getSqDistance(_ a: [Int], _ b: [Int]) -> Int {
    let dx = a[0] - b[0]
    let dy = a[1] - b[1]
    return dx * dx + dy * dy
}

/*:
 ## Product of Array Except Self
 Given an array of n integers where n > 1, nums, return an array output such that output[i] is equal to the product of all the elements of nums except nums[i].
 
 Solve it without division and in O(n).
 
 For example, given [1,2,3,4], return [24,12,8,6].
 
 
 Idea: Since it is the product of Array except self, in other words, it is the product of the left side product and right right product of self.
 So, we could use two array to store all left product and all right product. Then, compute the res.
 
 We can optimize the algrithm in less space.
 */

func productExceptSelf(_ nums: [Int]) -> [Int] {
    
    var res = [Int]()
    
    if nums.count < 2 {
        return res
    }
    
    // left products
    // first left product is 1
    res.append(1)
    for i in 1...nums.count - 1 {
        res.append(res[i - 1] * nums[i - 1])
    }
    
    // right products
    var preRightProduct = 1
    var i = nums.count - 2
    while i >= -1 {
        res[i + 1] *= preRightProduct
        preRightProduct *= nums[i + 1]
        i -= 1
    }

    return res
}

// productExceptSelf([1,2,3,4])

/*:
 ## Rotate Array
 Rotate an array of n elements to the right by k steps.
 
 For example, with n = 7 and k = 3, the array [1,2,3,4,5,6,7] is rotated to [5,6,7,1,2,3,4].
 
 Idea 1: use a extra array A to store the nums[n-k-1...n-1], shift the rest to the right, then put A back to the front.
 Idea 2: brote force, shift k time
 Idea 3: step 1, reverse 0...n-1, then reverse 0...k-1, then reverse k...n-1
 */

func rotateArray(_ nums: inout [Int], _ k: Int) {
    
    let n = nums.count
    let k = k % n
    
    reverseArray(&nums, 0, n - 1)
    reverseArray(&nums, 0, k - 1)
    reverseArray(&nums, k, n - 1)

}

func reverseArray(_ nums: inout [Int], _ l: Int, _ r: Int) {
    
    var l = l
    var r = r
    
    if l >= r || l < 0 || r > nums.count - 1 {
        return
    }
    
    while l < r {
        
        let temp = nums[l]
        nums[l] = nums[r]
        nums[r] = temp
        
        l += 1
        r -= 1
    }
}

/*: 
 ## Rotate Image
 You are given an n x n 2D matrix representing an image.
 
 Rotate the image by 90 degrees (clockwise).
 
 */

func rotateImage(_ matrix: inout [[Int]]) {
    
    if matrix.count != matrix[0].count {
        return
    }
    
    let n = matrix.count
    let layer = n/2
    
    for i in 0..<layer {
        let start = i, end = n - i - 1
        for j in start..<end {
            let temp = matrix[i][j]
            matrix[i][j] = matrix[n-1-j][i]
            matrix[n-1-j][i] = matrix[n-i-1][n-1-j]
            matrix[n-i-1][n-1-j] = matrix[j][n-i-1]
            matrix[j][n-i-1] = temp
        }
    }
}

//var array = [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]]
//rotateImage(&array)

/*:
 ## Set Matrix Zeroes
 Given a m x n matrix, if an element is 0, set its entire row and column to 0. Do it in place.
 
 Idea: We can use first row and first col to record the rows and cols that should be set as 0s. 
 Step 1: check whether first row and first col contains 0. Store in the flag
 Step 2: check the rest of the matrix, if matrix[i][j] == 0, set matrix[0][j] = 0 and matrix[i][j] = 0.
 step 3: Acording to the first row and first col, set 0s to correct rows and cols
 step 4: Acording to the flag from step 1, set first row and col to 0s
 
 */

func setZeroes(_ matrix: inout [[Int]]) {

    var firstRowHasZero: Bool = false
    var firstColHasZero: Bool = false
    let row = matrix.count, col = matrix[0].count
    
    // step 1
    for i in 0..<col where matrix[0][i] == 0 {
        firstRowHasZero = true
        break
    }
    
    for i in 0..<row where matrix[i][0] == 0 {
        firstColHasZero = true
        break
    }
    
    // step 2
    for i in 1..<row {
        for j in 1..<col {
            if matrix[i][j] == 0 {
                matrix[i][0] = 0
                matrix[0][j] = 0
            }
        }
    }
    
    // step 3
    for i in 1..<row {
        for j in 1..<col {
            if matrix[i][0] == 0 || matrix[0][j] == 0 {
                matrix[i][j] = 0
            }
        }
    }
    
    // step 4
    if firstColHasZero {
        for i in 0..<row {
            matrix[i][0] = 0
        }
    }
    
    if firstRowHasZero {
        for i in 0..<col {
            matrix[0][i] = 0
        }
    }
}

//var matrix = [[0,0,0,5],[4,3,1,4],[0,1,1,4],[1,2,1,3],[0,0,1,1]]
//setZeroes(&matrix)


/*:
 ## Sliding Window Maximum
 Given an array nums, there is a sliding window of size k which is moving from the very left of the array to the very right. You can only see the k numbers in the window. Each time the sliding window moves right by one position.
 
 For example,
 Given nums = [1,3,-1,-3,5,3,6,7], and k = 3.
 
 Window position                Max
 ---------------               -----
 [1  3  -1] -3  5  3  6  7       3
 1  [3  -1  -3] 5  3  6  7       3
 1   3 [-1  -3  5] 3  6  7       5
 1   3  -1 [-3  5  3] 6  7       5
 1   3  -1  -3 [5  3  6] 7       6
 1   3  -1  -3  5 [3  6  7]      7
 Therefore, return the max sliding window as [3,3,5,5,6,7].

 You may assume k is always valid, ie: 1 ≤ k ≤ input array's size for non-empty array.

 Idea: Use array to store the potential max number's index. The first item of the array is always the max number's index for a window.
 
 */

func slidingWindowMaximun(_ nums: [Int], _ k: Int) -> [Int] {
    
    var indexArray = [Int]()
    var res = [Int]()
    
    for i in 0..<nums.count {
        // check last item in the indexArray
        // if nums[last] <= nums[i], remove the last
        // until nums[last] > nums[i]
        while let last = indexArray.last, nums[last] <= nums[i] {
            indexArray.removeLast()
        }
        // add current one
        indexArray.append(i)
        
        // check the first in the indexArray
        // if first == i - k, means first is not in current window now, remove it
        if let first = indexArray.first, first == i - k {
            indexArray.removeFirst()
        }
        
        // Add the first one in the indexArray to the res
        if i >= k - 1 {
            res.append(nums[indexArray.first!])
        }
    }
    
    return res
}

//slidingWindowMaximun([1,3,-1,-3,5,3,6,7], 3)

/*:
 ## Spiral Matrix
 Given a matrix of m x n elements (m rows, n columns), return all elements of the matrix in spiral order.
 
 For example,
 Given the following matrix:
 
 [
 [ 1, 2, 3 ],
 [ 4, 5, 6 ],
 [ 7, 8, 9 ]
 ]
 You should return [1,2,3,6,9,8,7,4,5].
 */

func spiralOrder(_ matrix: [[Int]]) -> [Int] {
    var res = [Int]()
    
    if matrix.count == 0 || matrix[0].count == 0 {
        return res
    }
    
    let m = matrix.count
    let n = matrix[0].count

    let layers = (min(m, n) + 1) / 2

    for layer in 0..<layers {
        let start = layer
        let endForRow = n - layer - 1, endForCol = m - layer - 1
        print("start: \(start), endForRow : \(endForRow), endForCol: \(endForCol)")
        
        // only one col
        if start == endForRow {
            for i in start...endForCol {
                res.append(matrix[i][start])
            }
        }
        // only one row
        else if start == endForCol {
            for i in start...endForRow {
                res.append(matrix[start][i])
            }
        }
        else {
            // top
            for i in start..<endForRow {
                res.append(matrix[start][i])
            }
            // right
            for i in start..<endForCol {
                res.append(matrix[i][n - start - 1])
            }
            // bottom
            for i in stride(from: endForRow, to: start, by: -1) {
                res.append(matrix[m - start - 1][i])
            }
            // left
            for i in stride(from: endForCol, to: start, by: -1) {
                res.append(matrix[i][start])
            }
        }
    }
    
    return res
}

//spiralOrder([[7],[5], [4]])

/*:
 ## Spiral Matrix II
 Given an integer n, generate a square matrix filled with elements from 1 to n2 in spiral order.
 
 For example,
 Given n = 3,
 
 You should return the following matrix:
 [
 [ 1, 2, 3 ],
 [ 8, 9, 4 ],
 [ 7, 6, 5 ]
 ]
 
 */

func generateSpiralMatrix(_ n: Int) -> [[Int]] {
    
    var res = Array(repeating: Array(repeating: 0, count: n), count: n)
    
    let layers = n/2
    var val = 1
    
    for layer in 0..<layers {
        let start = layer, end = n - layer - 1
        
        // top
        for i in start..<end {
            res[start][i] = val
            val += 1
        }
        // right
        for i in start..<end {
            res[i][n - start - 1] = val
            val += 1
        }
        // bottom
        for i in stride(from: end, to: start, by: -1) {
            res[n - start - 1][i] = val
            val += 1
        }
        // left
        for i in stride(from: end, to: start, by: -1) {
            res[i][start] = val
            val += 1
        }
    }
    
    if n % 2 != 0 {
        res[n/2][n/2] = val
    }
    
    return res
}

//generateSpiralMatrix(4)


