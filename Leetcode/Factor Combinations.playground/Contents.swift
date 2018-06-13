//: Factor Combinations
/*
 Numbers can be regarded as product of its factors. For example,
 
 8 = 2 x 2 x 2;
 = 2 x 4.
 Write a function that takes an integer n and return all possible combinations of its factors.
 */

func factorCombinations(_ num: Int) -> [[Int]] {
    var res = [[Int]]()
    if num < 3 {
        return res
    }
    var temp = [Int]()
    helper(num, num, 2, &temp, &res)
    return res
}

func helper(_ num: Int, _ cur: Int, _ start: Int, _ temp: inout [Int], _ list: inout [[Int]]) {
    if cur == 1 {
        list.append(temp)
        return
    }
    
    for i in start..<num {
        if cur % i == 0 {
            temp.append(i)
            var cur = cur
            cur /= i
            helper(num, cur, i, &temp, &list)
            temp.removeLast()
        }
    }
}

factorCombinations(24)
    
    
    
    
    
    

