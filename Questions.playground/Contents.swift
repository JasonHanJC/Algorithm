/*:
 ## Swap two numbers without using temporary variable
 
 We can use arithmetic operators or bitwise XOR
 
 Problems:
 1. Both arithmetic solutions may cause arithmetic overflow
 2. The multiplication and division solution will not work when either of the
 variable is 0.
 3. When we use pointer to variables to make them swap, all motheds can't work
 when both pointers point to the same variable.
 */

// use + and - operator
func swapNumbers_1(_ a: inout Int, _ b: inout Int) {
    a = a + b
    b = a - b
    a = a - b
}

// use * and / operator
func swapNumbers_2(_ a: inout Int, _ b: inout Int) {
    a = a * b
    b = a / b
    a = a / b
}

// use ^ (XOR) operator
func swapNumbers_3(_ a: inout Int, _ b: inout Int) {
    guard a != b else {
        return
    }
    a = a ^ b
    b = a ^ b
    a = a ^ b
}


/*:
 ## Boyer-Moore String Search
 
 Use dictionary to store the index of the pattern. Use index to skip.
 */

func indexOf(pattern: String, string: String) -> Int? {
    // sanity check
    guard pattern.count <= string.count, pattern.count > 0 else {
        return nil
    }
    
    // convert to chatacters array
    let pattern = Array(pattern.characters)
    let string = Array(string.characters)
    
    // create index dictionary for pattern
    let patternLen = pattern.count
    var skipTable = [Character : Int]()
    for (i, char) in pattern.enumerated() {
        skipTable[char] = patternLen - 1 - i
    }
    
    // start i in string
    var i = patternLen - 1
    
    // inner func
    func backwards() -> Int? {
        var pLen = patternLen - 1
        var curI = i
        
        while pLen > 0 {
            pLen -= 1
            curI -= 1
            if pattern[pLen] != string[curI] {
                return nil
            }
        }
        return curI
    }
    
    let lastChar = pattern[patternLen - 1]
    
    while i < string.count {
        let curChar = string[i]
        // if current character matchs the last character in pattern
        if lastChar == curChar {
            // check character one by one in backward order
            if let res = backwards() {
                return res
            }
            // if no match, just safely skip one character ahead
            i += 1
        } else {
            // check whether this character is in the skipTable
            // if there is no skipStep, jump a full pattern lenth
            i += skipTable[curChar] ?? patternLen
        }
    }
    return nil
}

