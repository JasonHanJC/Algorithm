//: Insert Delete GetRandom O(1)

import Foundation

class RandomSet {
    // key is the index, value is the number
    var orderDict = [Int : Int]()
    // key is the number, val is array of location index for number
    var locDict = [Int : Set<Int>]()
    
    func insert(_ num: Int) {
        let size = orderDict.count
        orderDict[size] = num
        
        if var locs = locDict[num] {
            locs.insert(size)
            locDict[num] = locs
        } else {
            var locs = Set<Int>()
            locs.insert(size)
            locDict[num] = locs
        }
    }
    
    func remove(_ num: Int) -> Bool {
        if var locs = locDict[num] {
            let toRemove = locs.popFirst()!
            if locs.isEmpty {
                locDict.removeValue(forKey: num)
            } else {
                locDict[num] = locs
            }
            
            let lastIndex = orderDict.count - 1
            
            if toRemove == lastIndex {
                orderDict.removeValue(forKey: toRemove)
                return true
            }
            
            let lastNum = orderDict[lastIndex]!
            
            var lastNumLocs = locDict[lastNum]
            lastNumLocs?.remove(lastIndex)
            lastNumLocs?.insert(toRemove)
            locDict[lastNum] = lastNumLocs
            
            orderDict.removeValue(forKey: lastIndex)
            orderDict.removeValue(forKey: toRemove)
            
            orderDict[toRemove] = lastNum
            
            return true
        }
        return false
    }
    
    func getRamdon() -> Int? {
        if orderDict.count <= 0 {
            return nil
        }
        let index = Int(arc4random_uniform(UInt32(orderDict.count)))
        return Array(orderDict)[index].value
    }
}


//let randomSet = RandomSet()
//
//randomSet.insert(1)
//randomSet.insert(2)
//randomSet.insert(1)
//randomSet.insert(2)
//randomSet.insert(1)
//randomSet.insert(2)
//randomSet.insert(1)
//randomSet.insert(2)
//randomSet.insert(1)
//randomSet.insert(2)
//
//print(randomSet.dict)


