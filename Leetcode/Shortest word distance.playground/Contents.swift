//: Shortest word distance

/*
 Given a list of words and two words word1 and word2, return the shortest distance between these two words in the list.
 
 For example, Assume that words = ["practice", "makes", "perfect", "coding", "makes"].
 
 Given word1 = "coding", word2 = "practice", return 3. Given word1 = "makes", word2 = "coding", return 1.
 */

// w1 is not equal to w2
func shortestWordDistance(words: [String], w1: String, w2: String) -> Int {
    
    var res = Int.max
    
    var p = -1, q = -1
    
    for (i, word) in words.enumerated() {
        
        if w1 == word {
            p = i
            if p != -1 && q != -1 {
                res = min(res, abs(p-q))
            }
        }
        
        if w2 == word {
            q = i
            if p != -1 && q != -1 {
                res = min(res, abs(p-q))
            }
        }
    }
    
    return res
}

//: Shortest word distance III
// w1 can be equal to w2
func shortestWordDistanceIII(words: [String], w1: String, w2: String) -> Int {
    
    var res = Int.max
    var p = -1, q = -1
    
    for (i, word) in words.enumerated() {
        
        let pre = p
        
        if w1 == word {
            p = i
            
            if w1 == w2 {
                if p != -1 && pre != -1 {
                    res = min(res, abs(p - pre))
                }
            } else {
                if p != -1 && q != -1 {
                    res = min(res, abs(p - q))
                }
            }
        } else if w2 == word {
            q = i
            if p != -1 && q != -1 {
                res = min(res, abs(p - q))
            }
        }
    }
    
    return res
}

shortestWordDistanceIII(words: ["practice", "makes", "perfect", "coding", "makes"], w1: "coding", w2: "practice")

