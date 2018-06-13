//: Palindromic Substrings
/*
 Given a string, your task is to count how many palindromic substrings in this string.
 
 The substrings with different start indexes or end indexes are counted as different substrings even they consist of same characters.
 
 Example 1:
 Input: "abc"
 Output: 3
 Explanation: Three palindromic strings: "a", "b", "c".
 Example 2:
 Input: "aaa"
 Output: 6
 Explanation: Six palindromic strings: "a", "a", "a", "aa", "aa", "aaa".
 */

/*
 aaa
 
 loop one:
 a
 
 aa
 loop two:
 a
 aaa
 
 aa
 
 loop three:
 a
 
 */

var count = 0

func countSubstrings(_ s: String) -> Int {
    if s.count == 0 {
        return 0
    }
    
    let chars = Array(s)
    for i in 0..<chars.count {
        extendPalindrome(chars, i, i) // i is the mid
        extendPalindrome(chars, i, i + 1)
    }
    
    return count
}

func extendPalindrome(_ chars: [Character], _ left: Int, _ right: Int) {
    var left = left, right = right
    while left >= 0 && right < chars.count && chars[left] == chars[right] {
        count += 1
        left -= 1
        right += 1
    }
}

countSubstrings("abc")


