//: Replace Words
/*
 In English, we have a concept called root, which can be followed by some other words to form another longer word - let's call this word successor. For example, the root an, followed by other, which can form another word another.
 
 Now, given a dictionary consisting of many roots and a sentence. You need to replace all the successor in the sentence with the root forming it. If a successor has many roots can form it, replace it with the root with the shortest length.
 
 You need to output the sentence after the replacement.
 
 Example 1:
 Input: dict = ["cat", "bat", "rat"]
 sentence = "the cattle was rattled by the battery"
 Output: "the cat was rat by the bat"
 */

import Foundation

func replaceWords(_ dict: [String], _ sentence: String) -> String {
    
    let words = sentence.components(separatedBy: " ")
    var res = String()
    if words.count == 0 {
        return res
    }
    
    let trie = Trie(dict)
    for (index, word) in words.enumerated() {
        if let prefix = trie.findPrefix(word) {
            res.append(prefix)
        } else {
            res.append(word)
        }
        if index != words.count - 1 {
            res.append(" ")
        }
    }
    return res
}

class TrieNode {
    var isWord = false
    var dict = [Character : TrieNode]()
}

class Trie {
    var root = TrieNode()
    init(_ dict: [String]) {
        for str in dict {
            var head = root
            for c in Array(str) {
                if let next = head.dict[c] {
                    head = next
                } else {
                    let newNode = TrieNode()
                    head.dict[c] = newNode
                    head = newNode
                }
            }
            if Array(str).count > 0 {
                head.isWord = true
            }
        }
    }
    
    func findPrefix(_ word: String) -> String? {
        var res = String()
        var head = root
        for c in Array(word) {
            if let next = head.dict[c] {
                res.append(c)
                head = next
                if next.isWord { break }
            } else {
                return nil
            }
        }
        return res
    }
}

//replaceWords(["cat", "bat", "rat"], "the cattle was rattled by the battery")

