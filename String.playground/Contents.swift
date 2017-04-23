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

longestValidParentheses("()(())")
