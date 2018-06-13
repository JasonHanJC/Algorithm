//: Store and lookup a word in a dictionary as it's typed in.
/*
 Store and lookup a word in a dictionary as it's typed in. e.g., { "cat", "car", "cow", "dog" }
 Type c : return cat, car, cow
 Continue so now you have ca : return cat, car
 Finish as car : return car
 */
class TrieNode<T: Hashable> {

    var val: T?
    var isTerminating: Bool = false
    weak var parent: TrieNode?
    var children = [T : TrieNode]()
    var potentialWords = [String]()

    init(val: T? = nil, parent: TrieNode? = nil) {
        self.val = val
        self.parent = parent
    }

    func addChild(_ val: T) {
        guard children[val] == nil else {
            return
        }

        let child = TrieNode(val: val, parent: self)
        children[val] = child
    }

    func addWord(_ word: String) {
        if potentialWords.contains(word) {
            return
        }
        potentialWords.append(word)
    }
}

class Trie {

    typealias Node = TrieNode<Character>

    let root: Node

    init() {
        root = Node()
    }

    func contains(word: String) -> Bool {
        guard word.count > 0 else {
            return false
        }

        let lowercased = word.lowercased()
        var currentRoot = root

        for char in lowercased {
            if let child = currentRoot.children[char] {
                currentRoot = child
            } else {
                return false
            }
        }
        
        if currentRoot.isTerminating {
            return true
        }

        return false
    }

    func insert(word: String) {
        guard word.count > 0 else {
            return
        }

        let lowercased = word.lowercased()
        var currentRoot = root

        for char in lowercased {
            if let child = currentRoot.children[char] {
                child.addWord(word)
                currentRoot = child
            } else {
                currentRoot.addChild(char)
                currentRoot.addWord(word)
                currentRoot = currentRoot.children[char]!
            }
        }

        if currentRoot.isTerminating {
            return
        }

        currentRoot.isTerminating = true
    }

//    func remove(word: String) {
//        guard word.count > 0 else {
//            return
//        }
//
//        let lowercased = word.lowercased()
//
//
//    }
    
    
    func findPotentialWords(word: String) -> Any {
        guard word.count > 0 else {
            return []
        }
        
        var res = [String]()
        let lowercased = word.lowercased()
        
        if contains(word: lowercased) {
            return word
        }
        
        var currentRoot = root
        var tempW: String
        var invalid = false
        
        for char in lowercased {
            if let child = currentRoot.children[char] {
                currentRoot = child
                //res = currentRoot.potentialWords
            } else {
                invalid = true
                break
            }
        }
        
        if !invalid {
            dfsHelper(currentRoot, lowercased, &res)
        }
        
        
        return res
    }
    
    
    private func dfsHelper(_ node: Node, _ tempW: String, _ res: inout [String]) {

        if node.isTerminating {
            res.append(tempW)
        }
        
        var tempW = tempW
        
        for child in node.children {
            tempW.append(child.key)
            dfsHelper(child.value, tempW, &res)
            tempW.removeLast()
        }
    }
}


let dict = ["cat", "car", "cow", "dog"]
let trie = Trie()

for word in dict {
    trie.insert(word: word)
}

trie.findPotentialWords(word: "e")


