//: Compute Sqrt Root
// The main idea to compute sqrt root is guessing, like first guessing 1 and then 2,  3
// Use binary search to optimize the speed.

// return integer
func sqrtI(x: Int) -> Int {
    if x < 0 {
        return -1
    }
    if x == 0 || x == 1 {
        return x
    }
    
    var left = 1, right = x
    while true {
        let mid = (left + right) / 2
        if mid * mid > x { // in left part
            right = mid - 1
        } else if mid * mid == x || ((mid + 1) * (mid + 1)) > x {
            return mid
        } else {
            left = mid + 1
        }
    }
}

sqrtI(x: 300)


func sqrtII(x: Int, e: Double) -> Double {
    
    if x == 0 || x == 1 {
        return Double(x)
    }
    
    var n: Double = Double(x)
    var y: Double = 0.0
    while abs(n - y) > e {
        n = (n + y) / 2
        y = Double(x) / n
    }
    return n
}

sqrtII(x: 40, e: 0.0000001)


