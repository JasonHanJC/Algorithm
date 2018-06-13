//: Playground - noun: a place where people can play

import PlaygroundSupport
import Foundation
import UIKit

PlaygroundPage.current.needsIndefiniteExecution = true

/*:
 ## One Edit Distance
 Given two strings S and T, determine if they are both one edit distance apart.
 
 What is the one edit distance?
 1. we can insert a charater into S to get T
 2. we can delete a character from S to get T
 3. we can substitute a character of S to get T
 
 For case 1 and 2, S and T must be one apart in their lengths.
 For case 3, S and T must be the same lengths.
 */

func oneEditDistance(s: String, t: String) -> Bool {
    
    let sChars = Array(s.characters), tChars = Array(t.characters)
    
    if abs(sChars.count - tChars.count) > 1 {
        return false
    }
    
    var different = false
    var i = 0
    var j = 0
    
    while i < sChars.count && j < tChars.count {
        
        if sChars[i] != tChars[j] {
            if different {
                return false
            }
            
            different = true
            
            if sChars.count > tChars.count {
                i += 1
            } else if sChars.count < tChars.count {
                j += 1
            } else {
                i += 1
                j += 1
            }
        } else {
            i += 1
            j += 1
        }
    }
    
    return true
}

//oneEditDistance(s: "kiten", t: "kitten")

/*:
 ## Valid Parentheses
 
 Given a string containing just the characters ’(’, ’)’, ’{’, ’}’, ’[’ and ’]’, determine if the input string is valid. The brackets must close in the correct order, "()" and "()[]" are all valid but "(]" and "([)]" are not.
 
 Idea: using stack to store the characters
 if stack is empty, push one character in.
 if current character and the top character in the stack are not paired, push current character in.
 else pop out the top character in the stack
 
 At last, if the stack is not empty, return false, else return true.
 
 In swift, using array as stack
 */

func validParentheses(_ s: String) -> Bool {
    
    let chars = Array(s.characters)
    
    if chars.count == 0 {
        return true
    }
    
    var dic = [Character : Character]()
    dic["("] = ")"
    dic["{"] = "}"
    dic["["] = "]"
    
    var stack = Array<Character>()
    
    for (_, char) in chars.enumerated() {
        
        if stack.isEmpty {
            stack.append(char)
        } else {
            if dic[stack.last!] == char {
                stack.removeLast()
            } else {
                stack.append(char)
            }
        }
    }
    
    return stack.isEmpty
}

//validParentheses("[][[]]([])[[")

/*:
 ##Longest Valid Parentheses
 Given a string containing just the characters ’(’ and ’)’, find the length of the longest valid (well-formed) parentheses substring.
 For "(()", the longest valid parentheses substring is "()", which has length = 2. Another example is ")()())", where the longest valid parentheses substring is "()()", which has length = 4.

 Similar to valid Parentheses, but instead of push char into stack, now we push char's index. Update max length when meet ")"
 */

func longestValidParentheses(_ s: String) -> Int {
    
    let chars = Array(s.characters)
    
    if chars.count == 0 || chars.count == 1 {
        return 0
    }
    
    var res = 0
    var stack = [Int]()
    
    for (index , char) in chars.enumerated() {
        
        if char == "(" || stack.isEmpty || chars[stack.last!] == ")" {
            stack.append(index)
        } else {
            let _ = stack.removeLast()
            if stack.isEmpty {
                res = max(res, index + 1)
            } else {
                res = max(res, index - stack.last!)
            }
        }
    }
    return res
}

//longestValidParentheses("()(())")

/*:
 ## Valid Palindrome
 Given a string, determine if it is a palindrome, considering only alphanumeric characters and ignoring cases.
 For example, "Red rum, sir, is murder" is a palindrome, while "Programcreek is awesome" is not.
 Note: Have you consider that the string might be empty? This is a good question to ask during an interview.
 For the purpose of this problem, we define empty string as valid palindrome.

 lower case?
 space removes
 special character
 number and characters
 
 Idea: two pointers, one left, one right
 */

func validPalindrome(_ s: String) -> Bool {
    
    if s.isEmpty {
        return true
    }
    
    let chars = Array(s.lowercased().characters)
    
    
    
    var l = 0
    var r = chars.count - 1
    
    while l < r {
        
        while l < r && !isAlpha(chars[l]) {
            l += 1
        }
        
        while l < r && !isAlpha(chars[r]) {
            r -= 1
        }
        
        if chars[l] == chars[r] {
            l += 1
            r -= 1
        } else {
            return false
        }
    }
    
    return true
}

func isAlpha(_ c: Character) -> Bool {
    guard let uChar = String(c).unicodeScalars.first else {
        fatalError("character is invalid")
    }
    
    return CharacterSet.alphanumerics.contains(uChar)
}

//validPalindrome("Red rum, sir, is murder")

/*:
 ## Add Strings
 Given two non-negative integers num1 and num2 represented as string, return the sum of num1 and num2.
 
 Note:
 The length of both num1 and num2 is < 5100.
 Both num1 and num2 contains only digits 0-9.
 Both num1 and num2 does not contain any leading zero.
 You must not use any built-in BigInteger library or convert the inputs to integer directly.
 
 Idea: add them using sum and carry
 Note: remeber to check carry at last
 */

func addStrings(_ num1: String, _ num2: String) -> String {
    
    let num1 = Array(num1.characters)
    let num2 = Array(num2.characters)
    
    for char in num1 {
        print(char)
    }
    
    var res = ""
    var i = num1.count - 1, j = num2.count - 1, sum = 0, carry = 0
    
    while i >= 0 || j >= 0 {
        sum = carry // sum = 0 , sum += carry
        
        if i >= 0 {
            sum += Int(String(num1[i]))!
            i -= 1
        }
        
        if j >= 0 {
            sum += Int(String(num2[j]))!
            j -= 1
        }
        
        carry = sum / 10

        res.append(String(sum % 10))
    }
    
    if carry != 0 {
        res.append(String(carry))
    }
    
    // don't forget to reverse the string
    return String(res.characters.reversed())
}

//addStrings("9", "1")


/*:
 ## Count and Say
 
 The count-and-say sequence is the sequence of integers beginning as follows:
 1, 11, 21, 1211, 111221, ...
 
 1 is read off as "one 1" or 11.
 11 is read off as "two 1s" or 21.
 21 is read off as "one 2, then one 1" or 1211.
 Given an integer n, generate the nth sequence.
 
 Note: The sequence of integers will be represented as a string.
 */

func countAndSay(_ n: Int) -> String {
    
    guard n > 0 else {
        return ""
    }
    
    var res = "1"
    var temp: String
    var count: Int
    var chars: [Character]
    var current: Character
    
    for _ in 1..<n {
        temp = ""
        count = 1
        chars = Array(res.characters)
        current = chars[0]
        
        for i in 1..<chars.count {
            if current == chars[i] {
                count += 1
            } else {
                temp.append(String(count))
                temp.append(current)
                count = 1
                current = chars[i]
            }
        }
        
        temp.append(String(count))
        temp.append(current)
        
        res = temp
    }
    
    return res
}

// countAndSay(4)

/*
 ## Detect Capital
 Given a word, you need to judge whether the usage of capitals in it is right or not.
 
 We define the usage of capitals in a word to be right when one of the following cases holds:
 
 All letters in this word are capitals, like "USA".
 All letters in this word are not capitals, like "leetcode".
 Only the first letter in this word is capital if it has more than one letter, like "Google".
 Otherwise, we define that this word doesn't use capitals in a right way.
 
 Two idea: 
 First one, count the number of capitals, finally, return true or false based on rules:
    1. all non capitals, return true (numberOfCapital == 0)
    2. only first letter is capital, return true ((isFirstCharCapital && numberOfCapital == 1))
    3. all capitals, return true (numberOfCapital == chars.count)
 
 Second one, count the number of capitals, but check the following cases everytime:
    1. when meets a upper case letter, number of capitals should equal to the index + 1, otherwise return false
    2. when meets a lower case letter, number of capitals should not greater than 1, otherwise return false
    3. otherwise return true

 */

func detectCapitalUseS1(_ word: String) -> Bool {
    var numberOfCapital = 0
    var isFirstCharCapital = false
    
    let chars = Array(word.characters)
    
    for (index, char) in chars.enumerated() {
        
        if char.isUpperCased() {
            numberOfCapital += 1
            
            if index == 0 {
                isFirstCharCapital = true
            } else {
                
                // speed improve
                if !isFirstCharCapital {
                    return false
                }
            }
        } else {
            
            // speed improve
            if numberOfCapital > 1 {
                return false
            }
        }
    }
    
    return numberOfCapital == 0 || (isFirstCharCapital && numberOfCapital == 1) || numberOfCapital == chars.count
}

fileprivate extension Character {
    func isUpperCased() -> Bool {
        return String(self).uppercased() == String(self)
    }
}

//detectCapitalUseS1("USA")

func detectCapitalUseS2(_ word: String) -> Bool {
    var numberOfCapital = 0
    
    let chars = Array(word.characters)
    
    for (index, char) in chars.enumerated() {
        
        if char.isUpperCased() {
            numberOfCapital += 1
            
            if numberOfCapital != index + 1 {
                return false
            }
        } else {
            
            if numberOfCapital > 1 {
                return false
            }
        }
    }
    
    return true
}

/*:
 ## First Unique Character in a String
 Given a string, find the first non-repeating character in it and return it's index. If it doesn't exist, return -1.
 
 Iterate the string twice, first time check the repeating for every character, second time find the first non-repeating index
 */

func firstUniqChar(_ s: String) -> Int {
    
    let chars = Array(s.characters)
    
    // dictionary: key is the char, value is true for dupplicate, false for not duplicate
    var dic = [Character : Bool]()
    
    for i in 0...chars.count - 1 {
        // if char is already in the dic
        if let _ = dic[chars[i]] {
            dic[chars[i]] = true
        } else {
            dic[chars[i]] = false
        }
    }
    
    
    for (index, char) in chars.enumerated() {
        
        if !dic[char]! {
            return index
        }
    }
    
    return -1
}

/*:
 ## Fizz and Buzz
 Write a program that outputs the string representation of numbers from 1 to n.
 
 But for multiples of three it should output “Fizz” instead of the number and for the multiples of five output “Buzz”. For numbers which are multiples of both three and five output “FizzBuzz”.
 
 */

func fizzAndBuzz(_ n: Int) -> [String] {
    
    var res = [String]()
    
    if n <= 0 {
        return res
    }
    
    for i in 1...n {
        var temp = ""
        if i % 3 == 0 && i % 5 == 0 {
            temp.append("FizzBuzz")
        } else if i % 3 == 0 {
            temp.append("Fizz")
        } else if i % 5 == 0 {
            temp.append("Buzz")
        } else {
            temp.append(String(i))
        }
        
        res.append(temp)
    }
    
    return res
}

// fizzAndBuzz(15)

/*: 
 ## Flip Game
 You are playing the following Flip Game with your friend: Given a string that contains only these two characters: + and -, you and your friend take turns to flip two consecutive "++" into "--". The game ends when a person can no longer make a move and therefore the other person will be the winner.
 
 Write a function to compute all possible states of the string after one valid move.
 
 For example, given s = "++++", after one move, it may become one of the following states:
 
 [
 "--++",
 "+--+",
 "++--"
 ]
 
 */

func flipGame(_ s: String) -> [String] {
    var res = [String]()
    
    var chars = Array(s.characters)
    
    guard chars.count > 0 else {
        return res
    }
    
    for i in 0..<(chars.count - 1) {
        
        if chars[i] == "+" && chars[i+1] == "+" {
            chars[i] = "-"
            chars[i + 1] = "-"
            
            res.append(String(chars))
            chars[i] = "+"
            chars[i + 1] = "+"
        }
    }
    
    return res
}

//flipGame("")


/*: 
 ## Valid Anagram
 Given two strings s and t, write a function to determine if t is an anagram of s.
 
 For example,
 s = "anagram", t = "nagaram", return true.
 s = "rat", t = "car", return false.
 
 Note:
 You may assume the string contains only lowercase alphabets.
 
 Follow up:
 What if the inputs contain unicode characters? How would you adapt your solution to such case?
 
 Sanity: if s1.count != s2.count, return false
 
 Idea 1: sort s1 and s2, then chack whether they are equaled, O(nlogn) O(1)
 Idea 2: use dictionary to store the char and its count O(n) O(n)
 */

func validAnagram(_ s1: String, _ s2: String) -> Bool {
    
    let s1 = Array(s1.characters)
    let s2 = Array(s2.characters)
    
    if s1.count != s2.count {
        return false
    }
    
    var dic = [Character : Int]()
    
    for i in 0..<s1.count {
        if let num = dic[s1[i]] {
            dic[s1[i]] = num + 1
        } else {
            dic[s1[i]] = 1
        }
    }
    
    for i in 0..<s2.count {
        
        if var num = dic[s2[i]] {
            num -= 1
            if num < 0 {
                return false
            }
            dic[s2[i]] = num
        } else {
            return false
        }
    }
    
    return true
}

// validAnagram("affffef", "affefff")

/*:
 ## Group Anagrams
 Given an array of strings, group anagrams together.
 
 For example, given: ["eat", "tea", "tan", "ate", "nat", "bat"],
 Return:
 
 [
 ["ate", "eat","tea"],
 ["nat","tan"],
 ["bat"]
 ]
 
 */

func groupAnagrams(_ strs: [String]) -> [[String]] {
    
    var res = [[String]]()
    
    if strs.count == 0 {
        return res
    }
    
    var dic = [String: [String]]()
    
    for i in 0..<strs.count {
        
        let sorted = String(strs[i].characters.sorted())
        
        var temp = [String]()
        
        if let list = dic[sorted] {
            temp = list
        }
        
        temp.append(strs[i])
        dic[sorted] = temp
    }
    
    res = dic.values.map{ list in list.sorted() }
    
    return res
    
}

groupAnagrams(["eat", "tea", "tan", "ate", "nat", "bat"])

/*:
 ## Isomorphic Strings
 Given two strings s and t, determine if they are isomorphic.
 
 Two strings are isomorphic if the characters in s can be replaced to get t.
 
 Important: All occurrences of a character must be replaced with another character while preserving the order of characters. No two characters may map to the same character but a character may map to itself.
 
 For example,
 Given "egg", "add", return true.
 
 Given "foo", "bar", return false.
 
 Given "paper", "title", return true.
 
 Note:
 You may assume both s and t have the same length.
 
 Idea: use dic to store the char and its replaced char. Replace the first string one char at a time, finally compare two string
 */

func isIsomorphic(_ s: String, _ t: String) -> Bool {
    
    var s = Array(s.characters)
    let t = Array(t.characters)
    
    if s.count != t.count {
        return false
    }
    
    var dic = [Character : Character]()
    
    for i in 0..<s.count {
        
        if let replaceChar = dic[s[i]] {
            s[i] = replaceChar
        } else {
            
            // since no two characters map to the same character
            // if we found a value is already in the dic, return false
            if dic.values.contains(t[i]) {
                return false
            }
            
            dic[s[i]] = t[i]
            s[i] = t[i]
        }
    }
    
    return s == t
}

//isIsomorphic("ab", "aa")


/*:
 ## Length of Last Word
 
 Given a string s consists of upper/lower-case alphabets and empty space characters ' ', return the length of last word in the string.
 
 If the last word does not exist, return 0.
 
 Idea 1: seperate the words by space, then get last word's length
 Idea 2: get the chars, check backword
 */

func lengthOfLastWord(_ s: String) -> Int {
    var arr = s.components(separatedBy: " ")
    var newArr = [String]()
    
    for i in 0..<arr.count {
        if arr[i] != "" {
            newArr.append(arr[i])
        }
    }
    
    return newArr.last?.characters.count ?? 0
}

// if the word contain non alphabet, return false
func containsOnlyLetters(input: String) -> Bool {
    for chr in input.characters {
        if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
            return false
        }
    }
    return true
}

//lengthOfLastWord("  aa vfvsdv vsfv")

/*:
 ## Longest Common Prefix
 Write a function to find the longest common prefix string amongst an array of strings.
 
 Idea: sort the string array, then compare the first one and the last one
 */

func longestCommonPrefix(_ strs: [String]) -> String {
    
    if strs.count < 2 {
        return strs.first ?? ""
    }
    
    let sorted = strs.sorted()
    let first = Array(sorted[0].characters), last = Array(sorted[sorted.count - 1].characters)
    
    var res = ""
    
    for i in 0..<first.count {
        
        if first[i] != last[i] {
            break
        }
        
        res.append(first[i])
    }
    
    return res
}
 
/*:
 ## Reverse String II
 Given a string and an integer k, you need to reverse the first k characters for every 2k characters counting from the start of the string. If there are less than k characters left, reverse all of them. If there are less than 2k but greater than or equal to k characters, then reverse the first k characters and left the other as original.
 Example:
 Input: s = "abcdefg", k = 2
 Output: "bacdfeg"
 Restrictions:
 The string consists of lower English letters only.
 Length of the given string and k will in the range [1, 10000]

 Idea: use two pointers s and t, s points to the start of the needed reversed chars, t points the tail if the needed reversed chars. s < chars.count and t < chars.count + k
 */

func reverseStringII(_ s: String, _ k: Int) -> String {
    
    var chars = Array(s.characters)
    
    if k < 2 { return s }
    var head = 0, tail = k - 1
    
    while head < tail && head < chars.count && tail < chars.count + k {
        
        tail = tail > chars.count - 1 ? (chars.count - 1) : tail
        
        let rev = chars[head...tail].reversed()
        
        chars.replaceSubrange(head...tail, with: rev)
        
        head += 2 * k
        tail += 2 * k
    }
    
    return String(chars)
}

//reverseStringII("abcd", 2)


/*:
 ## Longest Substring Without Repeating Characters
 Given a string, find the length of the longest substring without repeating characters.
 
 Examples:
 
 Given "abcabcbb", the answer is "abc", which the length is 3.
 
 Given "bbbbb", the answer is "b", with the length of 1.
 
 Given "pwwkew", the answer is "wke", with the length of 3. Note that the answer must be a substring, "pwke" is a subsequence and not a substring.
 

 Idea: Iterate the stirng, keep tracking the start index, and store or update every character's index with a dictionary. When you find a duplicate charater in the dic, update the res and the start index. The start index should be the charater's previous index + 1.
 */

func LongestSubstringWithoutRepeatingCharacters(_ s: String) -> Int {
    
    let chars = Array(s.characters)
    
    guard chars.count > 1 else {
        return chars.count
    }
    
    // store the character and its latest index
    var dic = [Character: Int]()
    var res = 0
    var i = 0
    var start = 0
    
    while i < chars.count {
        
        if let prevIndex = dic[chars[i]] {
            
            res = max(res, i - start)
            
            // important
            if start <= prevIndex {
                start = prevIndex + 1
            }
        }
        
        dic[chars[i]] = i
        i += 1
    }
    
    res = max(res, i - start)
    
    return res
}

//LongestSubstringWithoutRepeatingCharacters("abba")


/*:
 ## Longest Palindromic Substring
 Given a string s, find the longest palindromic substring in s. You may assume that the maximum length of s is 1000.
 
 Example:
 
 Input: "babad"
 
 Output: "bab"
 
 Note: "aba" is also a valid answer.
 Example:
 
 Input: "cbbd"
 
 Output: "bb"
 
 */



/*:
 ## palindrome substring
 Given two strings s1 and s2, where s2 is a palindrome, how many substrings(s2) are there if we are allowed to arrange s1 in any order.
 
 Input: aabb aba
 
 Output: 1
 
 Input: aabbaabb aba
 
 Output: 2
 
 Solution: Find the count of each character in s1. Find the count of each character in s2. Find minimum of (count of ‘x’ in s1/count of ‘x’ in s2), where x is any character present in both s1 and s2. Time Complexity: O(n).
 */



/*:
 ## Longest Palindromic Substring
 
 Given a string s, find the longest palindromic substring in s. You may assume that the maximum length of s is 1000.
 
 Example:
 
 Input: "babad"
 
 Output: "bab"
 
 Note: "aba" is also a valid answer.
 Example:
 
 Input: "cbbd"
 
 Output: "bb"
 
 */

var lowIndex = 0
var maxLen = 0

func longestPalindrome(_ s: String) -> String {
    
    if s.count < 2 {
        return s
    }
    
    let chars = Array(s.characters)
    
    for i in 0..<chars.count - 1 {
        extendPalindrome(chars: chars, a: i, b: i)
        extendPalindrome(chars: chars, a: i, b: i + 1)
    }
    return String(chars[lowIndex..<lowIndex+maxLen])
}

func extendPalindrome(chars: [Character], a: Int, b: Int) {
    var a = a, b = b
    while a >= 0 && b < chars.count && chars[a] == chars[b] {
        a -= 1
        b += 1
    }
    if maxLen < b - a - 1 {
        lowIndex = a + 1
        maxLen = b - a - 1
    }
}

// longestPalindrome("cbbd")





PlaygroundPage.current.finishExecution()



