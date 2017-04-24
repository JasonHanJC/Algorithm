//: Playground - noun: a place where people can play

import UIKit

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

countAndSay(4)

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





