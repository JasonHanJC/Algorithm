//: Word Break
/*
 Given a non-empty string s and a dictionary wordDict containing a list of non-empty words, determine if s can be segmented into a space-separated sequence of one or more dictionary words. You may assume the dictionary does not contain duplicate words.
 
 For example, given
 s = "leetcode",
 dict = ["leet", "code"].
 
 Return true because "leetcode" can be segmented as "leet code".
 */

func wordBreak(_ s: String, _ words: [String]) -> Bool {

    return wordBreakR(Array(s), words)
}

func wordBreakR(_ chars: [Character], _ words: [String]) -> Bool {

    let size = chars.count
    
    if size == 0 {
        return true
    }
    
    for i in 0..<size {
        let subString = String(chars[0...i])
        if words.contains(subString) {
            print
            if i == size - 1 {
                return true
            }
            return wordBreakR(Array(chars[i+1...size-1]), words)
        }
    }
    
    return false
}


//let array = [1, 2, 3, 4, 5]
//array[0...0]

wordBreak("aaaaa", ["aaa", "aa"])

