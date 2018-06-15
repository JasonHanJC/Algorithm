// 如果两个字符串的字符一样，但是顺序不一样，
// 被认为是兄弟字符串，比如bad和adb即为兄弟字符串，
// 现提供一个字符串，如何在字典中迅速找到它的兄弟字符串，
// 请描述数据结构和查询过程。

func anagram(_ a: String, _ b: String) -> Bool {
    if a.count != b.count {
        return false
    }
    // create a dictionary, key is the char, 
    // value is the number of char appears
    var charDic = [Character : Int]()
    a.forEach { char in
        if let val = charDic[char] {
            charDic[char] = val + 1
        } else {
            charDic[char] = 1
        }
    }

    // check b, subtract val by 1 when meet a char
    for char in b {
        if let val = charDic[char] {
            if val == 0 {
                return false
            }
            charDic[char] = val - 1 
        } else {
            return false
        }
    }

    return true
}

print(anagram("cvbvvv", "abvcvv"))

