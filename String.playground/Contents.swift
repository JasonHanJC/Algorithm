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

oneEditDistance(s: "kiten", t: "kitten")
