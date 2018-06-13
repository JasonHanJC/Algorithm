//: Top K Frequent Works
/*
 Given a non-empty list of words, return the k most frequent elements.
 
 Your answer should be sorted by frequency from highest to lowest. If two words have the same frequency, then the word with the lower alphabetical order comes first.
 
 Example 1:
 Input: ["i", "love", "leetcode", "i", "love", "coding"], k = 2
 Output: ["i", "love"]
 Explanation: "i" and "love" are the two most frequent words.
 Note that "i" comes before "love" due to a lower alphabetical order.
 */

func topKFrequent(_ words: [String], _ k: Int) -> [String] {
    var res = [String]()
    if words.count == 0 {
        return res
    }
    
    // dictionary
    var dict = [String : Int]()
    
    for word in words {
        if var count = dict[word] {
            count += 1
            dict[word] = count
        } else {
            dict[word] = 1
        }
    }
    
    let sorted = dict.sorted { (a, b) -> Bool in
        if a.value == b.value {
            return a.key < b.key
        } else {
            return a.value > b.value
        }
    }
    
    for i in 0..<k {
        res.append(sorted[i].key)
    }
    
    return res
}



