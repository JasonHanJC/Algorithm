//: Return valid word
/*
 给一个dict裡面包含的一些valid words，再给一个input word，输出要判断他是否可以被auto correct，然后有哪些auto correct 的可能性
 1. 大小写错误 -
 dict: ["Red", "Yellow", "Blue", "YelloW"], input: "yellow" -> return true, ["Yellow", "YelloW"]
 2. 元音错误 (aeiou) -
 dict: ["Red", "Yellow", "Blue", "YelloW"], input: "yallow" -> return true, ["Yellow", "YelloW"]. from
 3. 元音重複错误 -
 dict: ["Red", "Yellow", "Blue", "YelloW"], input: "yaaaiilloeew" -> return true, ["Yellow", "YelloW"].
 */

// The idea is using dictionary. The important part is what is the key.
// For case 1, the key can be the string in dict with all lowercases
// For case 2, the key can be the string in dict with all lowercases and all vowels(a, e, i, o, u) repleaced by a
// For case 3, the key can be the string in dict with all lowercases and all vowels repleaced by a and duplicated vowels. e.g Blue -> bla

import Foundation

let dict = ["Red", "allow", "Blue", "YelloW"]

func isVowel(char: Character) -> Bool {
    return "aeiou".contains(char)
}

func swapVowel(word: String) -> String {
    var chars = Array(word)
    var newWord = String()
    for i in 0..<chars.count {
        if isVowel(char: chars[i]) {
            if i != 0 && isVowel(char: chars[i - 1]) {
                continue
            } else {
                newWord.append("a")
            }
        } else {
            newWord.append(chars[i])
        }
    }
    return newWord
}

func canAutoCorrect(dict: [String], word: String) -> [String]? {
    guard word.count > 0 && dict.count > 0 else {
        return nil
    }
    
    if dict.contains(word) {
        return [word]
    }
    
    var checkDict = [String : Set<String>]()
    
    // Create dictionary
    for w in dict {
        let lw = swapVowel(word: w.lowercased())
        if var wSet = checkDict[lw] {
            wSet.insert(w)
            checkDict[lw] = wSet
        } else {
            let wSet: Set<String> = [w]
            checkDict[lw] = wSet
        }
    }
    
    // Checking
    let w = swapVowel(word: word.lowercased())
    if let wSet = checkDict[w] {
        return Array(wSet)
    }
    
    return []
}

extension Set {
    public func randomElement() -> Element {
        let n = arc4random_uniform(UInt32(self.count))
        let i = self.index(self.startIndex, offsetBy: Int(n))
        return self[i]
    }
}

canAutoCorrect(dict: dict, word: "ellow")

