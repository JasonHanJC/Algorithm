//: Find the Closest Palindrome
/*
 Given an integer n, find the closest integer (not including itself), which is a palindrome.
 
 The 'closest' is defined as absolute difference minimized between two integers.
 
 Example 1:
 Input: "123"
 Output: "121"
 Note:
 The input n is a positive integer represented by string, whose length will not exceed 18.
 If there is a tie, return the smaller one as answer.
 */

// get curP, nextP, preP
// corner cases: 1, return 0, 11 return 9, 100/001, 100/01

//func nearestPalidrome(_ s: String) -> String {
//
//
//
//
//}


func nearestPalidrome(_ s: String) -> String {
    
    guard s.count > 0 else {
        return s
    }
    
    // get curP
    var chars = Array(s)
    let n = chars.count
    for i in 0..<n / 2 {
        chars[n - i - 1] = chars[i]
    }
    
    let curP = String(chars)
    let preP = nearestP(curP, true)
    let nextP = nearestP(curP, false)
    
    let num = Int(s)!
    let curPN = Int(curP)!
    let prePN = Int(preP)!
    let nextPN = Int(nextP)!
    
    print("curP: \(curP)")
    print("preP: \(preP)")
    print("nextP: \(nextP)")
    
    let dif1 = abs(num - curPN)
    let dif2 = abs(num - prePN)
    let dif3 = abs(num - nextPN)
    
    if num == curPN {
        return dif2 <= dif3 ? preP : nextP
    } else if num > curPN {
        return dif1 <= dif3 ? curP : nextP
    } else {
        return dif2 <= dif1 ? preP : curP
    }
}

func nearestP(_ s: String, _ pre: Bool) -> String {
    let rs = s.count / 2
    let ls = s.count - rs
    let endIndex = s.index(s.startIndex, offsetBy: ls - 1)
    var l: Int = Int(s[...endIndex])!
    
    l += pre ? -1 : 1
    
    if l == 0 {
        return rs == 0 ? "0" : "9"
    }
    
    var leftS = String(l)
    var rightS = String(leftS.reversed())

    if rs > rightS.count {
        rightS.append("9")
    }
    
    if rs < rightS.count {
        let startIndex = rightS.index(rightS.startIndex, offsetBy: rightS.count - rs)
        rightS = String(rightS[startIndex...])
    }
    
    // let startIndex = rightS.index(rightS.startIndex, offsetBy: rightS.count - rs)
    // rightS = String(rightS[startIndex...rightS.endIndex])
    
    leftS.append(rightS)
    return leftS
}

let res = nearestPalidrome("10000")
print(res)



