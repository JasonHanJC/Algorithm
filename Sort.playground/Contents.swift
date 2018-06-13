import Foundation

/*:
 # Merge Intervals
 
 Given a collection of intervals, merge all overlapping intervals.
 
 For example,
 Given [1,3],[2,6],[8,10],[15,18],
 return [1,6],[8,10],[15,18].
 
 Idea: sort the interval and then campare
 */

class Interval {
    var start: Int
    var end: Int
    init(start: Int, end: Int) {
        self.start = start
        self.end = end
    }
}

func mergeIntervals(_ intervals: [Interval]) -> [Interval] {
    
    if intervals.count < 2 {
        return intervals
    }
    
    // sort interval
    let sortedIntervals = intervals.sorted() {
        if $0.start == $1.start {
            return $0.end < $1.end
        } else {
            return $0.start < $1.start
        }
    }
    
    var res = [sortedIntervals.first!]
    
    for i in 1..<sortedIntervals.count {
        let interval = sortedIntervals[i]
        let preInterval = res.last!
        
        if preInterval.end >= interval.start {
            preInterval.end = interval.end > preInterval.end ? interval.end : preInterval.end
        } else {
            res.append(interval)
        }
    }
    
    return res
}


/*:
 # Wiggle Sort
 
 Given an unsorted array nums, reorder it in-place such that nums[0] <= nums[1] >= nums[2] <= nums[3]....
 
 For example, given nums = [3, 5, 2, 1, 6, 4], one possible answer is [1, 6, 2, 5, 3, 4].
 
 如果i是奇数，nums[i] >= nums[i - 1]
 如果i是偶数，nums[i] <= nums[i - 1]
 */



/*:
 ## meetingRoom II
 Given an array of meeting time intervals consisting of start and end times [[s1,e1],[s2,e2],...] find the minimum number of conference rooms required.
 
 For example:
 Given [[0, 30], [5, 10], [15, 20]]
 return 2
 
 Sort
 
 */

func meetingRoomII(intervals: [Interval]) -> Int {
    if intervals.count < 1 {
        return 0
    }
    
    // get starts and ends in order
    let starts = intervals.map() {
        $0.start
    }.sorted()
    
    let ends = intervals.map() {
        $0.end
    }.sorted()
    
    
    var i = 0, j = 0
    var count = 0
    
    while i < starts.count && j < ends.count {
        if starts[i] < ends[j] {
            count += 1
            i += 1
        } else {
            i += 1
            j += 1
        }
    }
    
    return count
}

// let meetings = [Interval(start: 5, end: 10), Interval(start: 0, end: 30), Interval(start: 15, end: 20)]

// meetingRoomII(intervals: meetings)

/*:
 ## Merge sort
 */

func mergeSort(array: [Int]) -> [Int] {
    if array.count <= 1 {
        return array
    }
    
    let mid = array.count / 2
    let left = mergeSort(array: Array(array[0..<mid]))
    let right = mergeSort(array: Array(array[mid..<array.count]))
    return merge(leftArray: left, rightArray: right)
}

func merge(leftArray: [Int], rightArray: [Int]) -> [Int] {
    
    var l = 0, r = 0
    
    var res = [Int]()
    
    while l < leftArray.count && r < rightArray.count {
        if leftArray[l] <= rightArray[r] {
            res.append(leftArray[l])
            l += 1
        } else {
            res.append(rightArray[r])
            r += 1
        }
    }
    
    while l < leftArray.count {
        res.append(leftArray[l])
        l += 1
    }
    
    while r < rightArray.count {
        res.append(rightArray[r])
        r += 1
    }
    
    return res
}

// 8mergeSort(array: [1,3,5,74,3,2,47,8,9])

/*:
 ## Quicksort
 */

func quickSort<T: Comparable>(array: [T]) -> [T] {
    
    if array.count <= 1 {
        return array
    }
    
    let pivot = array[array.count/2]
    let smallers = array.filter() { $0 < pivot }
    let equals = array.filter() { $0 == pivot }
    let greaters = array.filter() { $0 > pivot }
    
    return quickSort(array: smallers) + equals + quickSort(array: greaters)
}

quickSort(array: [2,3,5,76,6,5,4,3,2,2,4,54])


