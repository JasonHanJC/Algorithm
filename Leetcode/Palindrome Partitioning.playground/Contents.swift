//: Palindrome Partitioning
/*
 Given a string s, partition s such that every substring of the partition is a palindrome.
 
 Return all possible palindrome partitioning of s.
 
 For example, given s = "aab",
 Return
 
 [
 ["aa","b"],
 ["a","a","b"]
 ]
 */

/*
 
 / aab /  partition!!!!!
 
           loop ->
        a     aa     aab
  |    a ab  b
 \ /  b
 
 
 */

func partition(_ s: String) -> [[String]] {
    var res = [[String]]()
    if s.count == 0 || s.count == 1 {
        res.append([s])
        return res
    }
    helper(Array(s), [String](), 0, &res)
    
    return res
}

func helper(_ ss: [Character], _ temp: [String], _ start: Int, _ res: inout [[String]]) {
    if start == ss.count {
        res.append(temp)
        return
    } else {
        var temp = temp
        for i in start..<ss.count {
            if isPalindrome(ss, start, i) {
                temp.append(String(ss[start...i]))
                helper(ss, temp, i + 1, &res)
                temp.removeLast()
            }
        }
    }
}

func isPalindrome(_ ss: [Character], _ start: Int, _ end: Int) -> Bool {
    var s = start, e = end
    while s < e {
        if ss[s] != ss[e] {
            return false
        }
        s += 1
        e -= 1
    }
    return true
}

partition("aab")



