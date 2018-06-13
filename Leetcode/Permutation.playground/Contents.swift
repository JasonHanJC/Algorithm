//: Permutations
/*
 Given a collection of distinct numbers, return all possible permutations.
 
 For example,
 [1,2,3] have the following permutations:
 [
 [1,2,3],
 [1,3,2],
 [2,1,3],
 [2,3,1],
 [3,1,2],
 [3,2,1]
 ]
 */
// too slow
//func permute(_ nums: [Int]) -> [[Int]] {
//
//    var res = [[Int]]()
//    if nums.count == 0 {
//        return res
//    }
//
//    if nums.count == 1 {
//        res.append(nums)
//        return res
//    }
//
//    var temp = [[Int]]()
//    for item in nums {
//        if temp.count == 0 {
//            temp.append([item])
//        } else {
//            let size = temp.count
//            for _ in 0..<size {
//                let sub = temp.removeFirst()
//                for i in 0...sub.count {
//                    var tempSub = sub
//                    tempSub.insert(item, at: i)
//                    if tempSub.count < nums.count {
//                        temp.append(tempSub)
//                    } else {
//                        res.append(tempSub)
//                    }
//                }
//            }
//        }
//    }
//    return res
//}

//func permute(_ nums: [Int]) -> [[Int]] {
//    var ans = [[Int]]()
//    backtrack(nums, [Int](), &ans)
//    return ans
//}
//
//func backtrack(_ nums: [Int], _ tempList: [Int], _ ans: inout [[Int]]) {
//    var tempList = tempList
//    if tempList.count == nums.count {
//        ans.append(tempList)
//    } else {
//        for i in 0..<nums.count {
//            if tempList.contains(nums[i]) {
//                continue
//            }
//            tempList.append(nums[i])
//            print(tempList)
//            backtrack(nums, tempList, &ans)
//            tempList.removeLast()
//        }
//    }
//}


// swap
//           1(2 3)      2(1 3)          3(2 1)
//    12(3)   13(2)   21(3)  23(1)    32(1)   31(2)
//     123     132     213    231      321      312


func permute(_ nums: [Int]) -> [[Int]] {
    var results:[[Int]] = []
    permute(nums, start:0, results: &results)
    return results
}

func permute(_ nums: [Int], start:Int, results: inout [[Int]]) {
    guard start < nums.count else { results.append(nums); return }
    var n = nums
    
    for i in start..<nums.count {
        n.swapAt(start, i)
        
        permute(n, start:start+1, results: &results)
        //n.swapAt(i, start)
    }
}

permute([1,2,3])

//: Permutations II
// has duplicates

func permuteUnique(_ nums: [Int]) -> [[Int]] {
    var results:[[Int]] = []
    let nums = nums.sorted()
    permuteII(nums, start:0, results: &results)
    return results
}

func permuteII(_ nums: [Int], start:Int, results: inout [[Int]]) {
    if start == nums.count {
        results.append(nums)
    } else {
        var n = nums
        for i in start..<nums.count {
            if i != start && n[i] == n[start] {
                continue
            }
            (n[start], n[i]) = (n[i], n[start])
            permuteII(n, start:start+1, results: &results)
            //n.swapAt(i, start)
        }
    }
}

//permuteUnique([1,2,3,4,5])
