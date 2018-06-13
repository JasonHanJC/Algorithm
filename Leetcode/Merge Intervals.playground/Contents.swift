//: Merge Intervals
/*
 Given a collection of intervals, merge all overlapping intervals.
 
 For example,
 Given [1,3],[2,6],[8,10],[15,18],
 return [1,6],[8,10],[15,18].
 */

class Interval {
    var start: Int
    var end: Int
    init(_ start: Int, _ end: Int) {
        self.start = start
        self.end = end
    }
}

func mergeInterval(intervals: [Interval]) -> [Interval] {
    let size = intervals.count
    if size == 0 || size == 1 {
        return intervals
    }
    
    // sort
    let sorted = intervals.sorted {
        if $0.start == $1.start {
            return $0.end < $1.end
        } else {
            return $0.start < $1.start
        }
    }
    
    var res = [Interval]()
    res.append(sorted.first!)
    for i in 1..<size {
        let last = res.last!
        let cur = sorted[i]
        if cur.start > last.end {
            res.append(cur)
        } else {
            last.end = last.end > cur.end ? last.end : cur.end
        }
    }
    
    return res
}
