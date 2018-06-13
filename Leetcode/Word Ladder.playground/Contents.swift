//: Word Ladder
/*
 Given two words (beginWord and endWord), and a dictionary's word list, find the length of shortest transformation sequence from beginWord to endWord, such that:
 
 Only one letter can be changed at a time.
 Each transformed word must exist in the word list. Note that beginWord is not a transformed word.
 For example,
 
 Given:
 beginWord = "hit"
 endWord = "cog"
 wordList = ["hot","dot","dog","lot","log","cog"]
 As one shortest transformation is "hit" -> "hot" -> "dot" -> "dog" -> "cog",
 return its length 5.
 
 Note:
 Return 0 if there is no such transformation sequence.
 All words have the same length.
 All words contain only lowercase alphabetic characters.
 You may assume no duplicates in the word list.
 You may assume beginWord and endWord are non-empty and are not the same.
 */

class WordNode {
    var word: String
    var step: Int
    init(_ word: String, _ step: Int) {
        self.word = word
        self.step = step
    }
}

func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
    var queue = [WordNode]()
    queue.append(WordNode(beginWord, 1))
    
    // add endWord to wordList
    var wordList = wordList
    wordList.append(endWord)
    
    while !queue.isEmpty {
        let frontNode = queue.removeFirst()
        
        if frontNode.word == endWord {
            return frontNode.step
        }
        
        var chars = Array(frontNode.word)
        for i in 0..<chars.count {
            for c in "abcdefghijklmnopqrstuvwxyz" {
                let tempChar = chars[i]
                // repleace
                if chars[i] != c {
                    chars[i] = c
                }
                
                let newWord = String(chars)
                if wordList.contains(newWord) {
                    let newWordNode = WordNode(newWord, frontNode.step+1)
                    queue.append(newWordNode)
                    // remove this word in word list
                    wordList.remove(at: wordList.index(of: newWord)!)
                }
                chars[i] = tempChar
            }
        }
    }
    return 0
}

ladderLength("hit", "cog", ["hot","dot","dog","lot","log"])
