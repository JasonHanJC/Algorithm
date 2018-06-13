//: Can place flower
/*
 Suppose you have a long flowerbed in which some of the plots are planted and some are not. However, flowers cannot be planted in adjacent plots - they would compete for water and both would die.
 
 Given a flowerbed (represented as an array containing 0 and 1, where 0 means empty and 1 means not empty), and a number n, return if n new flowers can be planted in it without violating the no-adjacent-flowers rule.
 
 Example 1:
 
 Input: flowerbed = [1,0,0,0,1], n = 1
 Output: True
 
 
 Example 2:
 
 Input: flowerbed = [1,0,0,0,1], n = 2
 Output: False
 */

func canPlaceFlowers(_ flowerbed: [Int], _ n: Int) -> Bool {
    
    if n == 0 {
        return true
    }
    
    var i = 1
    var n = n
    var flowerbed = flowerbed
    flowerbed.insert(0, at: 0)
    flowerbed.append(0)
    while i < flowerbed.count - 1 {
        if flowerbed[i] + flowerbed[i + 1] + flowerbed[i - 1] == 0 {
            flowerbed[i] = 1
            n -= 1
        }
        
        if flowerbed[i] == 1 {
            i += 2
        } else {
            i += 1
        }
        
        if n == 0 {
            return true
        }
    }
    
    return false
}

canPlaceFlowers([0,0,1,0,0], 2)
