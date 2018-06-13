// Goal: Find the minimum/maximum object in an unsorted array.
// The brute froce with is to compare one element to min and max. O(n)
// We can optimize the campare times by camparing a pair of elements to min and max.

func minimumMaximum(array: [Int]) -> (Int, Int)? {
    
    guard var minimum = array.first else {
        return nil
    }
    
    var maximun = minimum
    
    let start = array.count % 2 // odd is 1, even is 0
    
    for i in stride(from: start, to: array.count, by: 2) {
        
        // create pair
        let pair = (array[i], array[i+1])
        
        if pair.0 < pair.1 {
            minimum = min(pair.0, minimum)
            maximun = max(pair.1, maximun)
        } else {
            minimum = min(pair.1, minimum)
            maximun = max(pair.0, maximun)
        }
    }
    return (minimum, maximun)
}

let array = [ 8, 3, 9, 4, 6 ]
minimumMaximum(array: array)
