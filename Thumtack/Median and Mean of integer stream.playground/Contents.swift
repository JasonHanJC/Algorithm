//: Median and mean of integer stream
/*
 a stream of integers whose value are within [0, 1000), use constant memory to calculate median and mean.
 
 要求 getMedian 和 getMean的时间复杂度为O(1)
 */

// if we only consider the time conplexity not the storing space.
// We can use a max heap and a min heap to store all integers.
//
// Suppose the median is a tree root.
// Then the left subtree will be a max heap contains all integers less than median.
// The right subtree will be a min heap contains all integers greater than median.
// We need to make sure that number of integers in each heap are not differ greater than 1.
// To insert value into heap take O(log(n))
// Get median takes O(1)

public class Solution {
    
    fileprivate var minHeap: PriorityQueue<Int>
    fileprivate var maxHeap: PriorityQueue<Int>
    fileprivate var mean: Double
    
    public var count: Int {
        return minHeap.count + maxHeap.count
    }
    
    init() {
        minHeap = PriorityQueue<Int>(ascending: true)
        maxHeap = PriorityQueue<Int>(ascending: false)
        mean = 0.0
    }
    
    public func insert(_ num: Int) {
        
        maxHeap.push(num)
        minHeap.push(maxHeap.pop()!)
        
        if maxHeap.count < minHeap.count {
            maxHeap.push(minHeap.pop()!)
        }
        
        // update the preMean
        mean += (Double(num) - mean) / Double(count)
    }
    
    public func getMedian() -> Double {
    
        if maxHeap.count == minHeap.count {
            let left = maxHeap.peek()!
            let right = minHeap.peek()!
            return Double(left / 2 + right / 2) + Double(left % 2 + right % 2) / 2.0
        } else {
            return Double(maxHeap.peek()!)
        }
    }
    
    public func getMean() -> Double {
        return mean
    }
}

//let solution = Solution()
//solution.insert(4)
//solution.insert(3)
//solution.insert(1)
//solution.insert(5)
//solution.insert(6)
//solution.insert(7)
//solution.getMedian()
//solution.getMean()


// If the algrithm need to use constant memory
// than it is not cool to use a comparison sorting.
// Use counting sort.

// step 1: create a array for size 100
//

public class Solution1 {
    
    fileprivate var histogram: [Int]
    public var count: Int
    fileprivate var size: Int
    
    init(_ size: Int) {
        histogram = Array(repeating: 0, count: size)
        count = 0
        self.size = size
    }
    
    public func insert(_ num: Int) {
        guard num >= 0 && num < size else {
            fatalError("Number is not valid")
        }
        
        for i in num...size-1 {
            histogram[i] += 1
        }
        count += 1
    }
    
    public func getMedian() -> Double {
        guard count > 0 else {
            return 0.0
        }
        
        if count % 2 == 0 {
            let leftCount = count / 2
            let rightCount = count / 2 + 1
            var left: Int?
            var right: Int?
            for i in 0...size - 1 {
                let sum = histogram[i]
                
                if leftCount <= sum && left == nil {
                    left = i
                }
                if rightCount <= sum && right == nil {
                    right = i
                }
                
                if left != nil && right != nil {
                    break
                }
            }
            
            return Double(left! + right!) / 2.0
        } else {
            let medianCount = count / 2 + 1
            for i in 0...size - 1 {
                let sum = histogram[i]
                
                if medianCount <= sum {
                    return Double(i)
                }
            }
            return 0.0
        }
    }
    
    public func getMean() -> Double {
        return 0.0
    }

}

let solution1 = Solution1(10)
solution1.insert(4)
solution1.insert(3)
solution1.insert(1)
solution1.insert(5)
solution1.insert(6)
//solution1.insert(7)
solution1.getMedian()
solution1.getMean()


var test = Dictionary<Int, Int>()

test[1] = 2
test[2] = 3
test[5] = 2

test.sorted { (a, b) -> Bool in
    return a.key < b.key
}


