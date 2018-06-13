//: Nested List Weight Sum
/*
 Given a nested list of integers, return the sum of all integers in the list weighted by their depth.
 
 Each element is either an integer, or a list -- whose elements may also be integers or other lists.
 
 Example 1:
 Given the list [[1,1],2,[1,1]], return 10. (four 1's at depth 2, one 2 at depth 1)
 */

/*
 * // This is the interface that allows for creating nested lists.
 * // You should not implement it, or speculate about its implementation
 * class NestedInteger {
 *     // Return true if this NestedInteger holds a single integer, rather than a nested list.
 *     public func isInteger() -> Bool
 *
 *     // Return the single integer that this NestedInteger holds, if it holds a single integer
 *     // The result is undefined if this NestedInteger holds a nested list
 *     public func getInteger() -> Int
 *
 *     // Return the nested list that this NestedInteger holds, if it holds a nested list
 *     // The result is undefined if this NestedInteger holds a single integer
 *     public func getList() -> [NestedInteger]
 * }
 */

func depthSum(nestedList: [NestedInteger]) -> Int {
    return _helper(nestedList, 1)
}

func _helper(_ nestedList:[NestedInteger], _ weight: Int) -> Int {
    
    if nestedList.count == 0 {
        return 0
    }
    
    var res = 0
    for item in nestedList {
        res += item.isInteger() ? item.getInteger() * weight : _helper(item.getList, weight + 1)
    }
    
    return res
}
