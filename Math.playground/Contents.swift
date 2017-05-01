//: Playground - noun: a place where people can play

import UIKit

/*:
 ## Rotational symmetric number
 Given a number, say integer, return true if its rotationally symmetric
 
 Given an integer, check if its rotationally symmetric or not. Rotational Symmetry means, if we write that number on a page and rotate that page by 180º, the number remains same.
 
 Assumptions: 0 and 8 are rotationally symmetric but you can consider 1 to be rotationally symmetric as well.
 
 For Example: 88 is rotationally symmetric. 108801 is rotationally symmetric. 69 is rotationally symmetric. 6996 is NOT rotationally symmetric. 169 is NOT rotationally symmetric.
 
 Idea: First, store the number which can be rotated to be a number in a dictionary. 0 1 8 6 9
 Use two pointers, one left one right, check digit[i] == dic[digit[n-i-1]]. if true, left++, right--. if false, break.
 */

func isRotationalSymmetricNumber(_ num: Int) -> Bool {
    
    // create a dictionary to store the illegel rotational symmetric number
    var dic = [Int: Int]()
    dic[1] = 1
    dic[0] = 0
    dic[8] = 8
    dic[6] = 9
    dic[9] = 6
    
    var digits = [Int]()
    var num = num
    
    // create digits array
    while num != 0 {
        let digit = num % 10
        digits.insert(digit, at: 0)
        num = num / 10
    }
    
    print(digits)
    
    var left = 0
    var right = digits.count - 1
    
    while left <= right {
        // check whether this digit is legel
        if let leftPairNum = dic[digits[left]] {
            // check if the left and right are pairs
            if leftPairNum == digits[right] {
                left += 1
                right -= 1
            } else {
                return false
            }
        } else {
            return false
        }
    }
    return true
}

isRotationalSymmetricNumber(108801)


/*:
 ## Rotational symmetric number II
 Gave a number n, print out all rotational symmetric number with 1 to n digits.
 For example:
 n = 1: [0, 1, 8]
 n = 2: [11, 88, 69, 96]
 n = 3: [101, 808, 010, , 888, 609, 619, 689, 906, 916, 986]
 ...
 
 Idea: Odd number start from [0, 1, 8]. Even number start from [00, 11, 88, 69, 96]. Add [0, 1, 8, 6, 9] to the left and right.
 */

//func rotationalSymmetricNumberII(_ number: Int) -> [[Int]] {
//    
//    var res = [[Int]]()
//    
//    if number == 0 {
//        return res
//    }
//    
//    let startOdd = [0, 1, 8]
//    let startEven = [00, 11, 88, 69, 96]
//    
//    // create a dictionary to store the illegel rotational symmetric number
//    var dic = [Int: Int]()
//    dic[1] = 1
//    dic[0] = 0
//    dic[8] = 8
//    dic[6] = 9
//    dic[9] = 6
//    
//    for i in 1...number {
//        
//        if i == 1 {
//            res.append(startOdd)
//        } else i == 2 {
//            res.append(startEven)
//        } else {
//            res.append(getRotationalSymmetricNumberArray(res[i - 2 - 1], dic))
//        }
//    }
//    
//    
//}
//
//func getRotationalSymmetricNumberArray(_ preArray: [Int], _ dic: [Int: Int]) -> [Int] {
//    
//    
//    
//    return
//}

/*:
 ##
 
 */




