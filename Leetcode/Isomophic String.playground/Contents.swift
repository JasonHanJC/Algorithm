//: Isomophic String
/*
 Given two strings s and t, determine if they are isomorphic.
 
 Two strings are isomorphic if the characters in s can be replaced to get t.
 
 All occurrences of a character must be replaced with another character while preserving the order of characters. No two characters may map to the same character but a character may map to itself.
 
 For example,
 Given "egg", "add", return true.
 
 Given "foo", "bar", return false.
 
 Given "paper", "title", return true.
 
 Note:
 You may assume both s and t have the same length.
 */

func isIsomorphic(_ s: String, _ t: String) -> Bool {
    
    if s.count != t.count {
        return false
    }
    
    var dic = [Character : Character]()
    let sChar = Array(s)
    let tChar = Array(t)
    
    for i in 0..<s.count {
        if let c = dic[sChar[i]] {
            if c != tChar[i] {
                return false
            }
        } else {
            if i != 0 && tChar[i] == tChar[i-1] {
                return false
            }
            dic[sChar[i]] = tChar[i]
        }
    }
    
    return true
}

isIsomorphic("ab", "aa")


