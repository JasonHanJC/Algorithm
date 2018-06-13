// Goal: Count how often a certain value appears in an array.
// If the array is not sorted, use linear search, O(n)
// If the array is already sorted, use binary search. O(logN)
// There are two ways to use binary search.
// First way, we can use binary search to find target. After we found the target, we use linear search to find target from left and right. This method definitely increased the speed compared between linear search, but in worst case, it still run in O(N)
// Second way, we can use two binary search to find left boundary and right boundary. O(logN)

func countOccurrences(array: [Int], target: Int) -> Int {
    var res = 0
    
    func leftBoundary() -> Int {
        var low = 0
        var high = array.count
        while low < high {
            let mid = (low + high) / 2
            if array[mid] < target {
                low += 1
            } else {
                high = mid
            }
        }
        return low
    }
    
    func rightBoundary() -> Int {
        var low = 0
        var high = array.count
        while low < high {
            let mid = (low + high) / 2
            if array[mid] > target {
                high = mid
            } else {
                low += 1
            }
        }
        return low
    }
    
    return rightBoundary() - leftBoundary()
}

let arr = [ 0, 1, 1, 3, 3, 3, 3, 6, 8, 10, 11, 11 ]
let target = 3
countOccurrences(array: arr, target: target)
