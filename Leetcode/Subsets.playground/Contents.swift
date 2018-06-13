//: Subsets
/*
 Given a set of distinct integers, nums, return all possible subsets (the power set).
 
 Note: The solution set must not contain duplicate subsets.
 
 For example,
 If nums = [1,2,3], a solution is:
 
 [
 [3],
 [1],
 [2],
 [1,2,3],
 [1,3],
 [2,3],
 [1,2],
 []
 ]
 */

func subSets(_ nums: [Int]) -> [[Int]] {
    
    var res = [[Int]]()
    res.append([Int]())
    
    if nums.count == 0 {
        return res
    }
    helper(nums, [Int](), &res, 0)
    
    return res
}

func helper(_ nums: [Int], _ temp: [Int], _ res: inout [[Int]], _ start: Int) {
    
    if start == nums.count {
        return
    }
    var temp = temp
    for i in start..<nums.count {
        
        temp.append(nums[i])
        res.append(temp)
        helper(nums, temp, &res, i+1)
        temp.removeLast()
    }
}

// subSets([1, 2, 3])

// subsets II with duplicates

func subSetsII(_ nums: [Int]) -> [[Int]] {
    
    var res = [[Int]]()
    res.append([Int]())
    
    if nums.count == 0 {
        return res
    }
    
    let nums = nums.sorted()
    helperII(nums, [Int](), &res, 0)
    
    return res
}

func helperII(_ nums: [Int], _ temp: [Int], _ res: inout [[Int]], _ start: Int) {
    
    if start == nums.count {
        return
    }
    var temp = temp
    for i in start..<nums.count {
        if i != start && nums[i] == nums[i - 1] {
            continue
        }
        
        temp.append(nums[i])
        res.append(temp)
        helperII(nums, temp, &res, i+1)
        temp.removeLast()
    }
}

subSetsII([1, 1, 3])
