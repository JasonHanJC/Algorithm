//: Selection Sampling
// Goal: Select k items at random from a collection of n items. Do it in place. O(k)
// use an index i from 0 ro count-1, random select an element at j from i to 0 ro count-1, and swap i and j

import Foundation

func random(_ lower: Int, _ upper: Int) -> Int {
    assert(lower < upper)
    return lower + Int(arc4random_uniform(UInt32(upper - lower)))
}

func selectSampling<T>(elements: [T], k: Int) -> [T] {
    
    if elements.count <= k {
        return elements
    }
    
    var a = elements
    for i in 0..<k {
        let r = random(i, a.count)
        if r != i {
            a.swapAt(i, r)
        }
    }
    return Array(a[0..<k])
}

selectSampling(elements: [ "a", "b", "c", "d", "e", "f", "g" ], k: 3)

