// 字符串包含问题：字符串A和B，判断B中的字符是否都在A中出现，不用考虑重复
// example: A: ABDF B: BA   return true
// example: A: SDFSDFGG B: RCC retuen false

// use a map set

func stringContains(_ a: String, _ b: String) -> Bool {
    if a.count < b.count {
        return false
    }

    // create word set
    var charSet: Set<Character> = [];
    a.forEach { char in
        charSet.insert(char)
    }

    for char in b {
        if !charSet.contains(char) {
            return false
        }
    }

    return true
}

// print(stringContains("ABSFG", "HHFY"))