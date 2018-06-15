// 回文

func isPalindrome(_ s: String) -> Bool {
    // 推荐从中间向两边检测

    let len = s.count
    var l = (len % 2 == 0) ? len / 2 - 1: len / 2 
    var r = len / 2

    print("\(l) + \(r)")

    let chars = Array(s)
    while l > 0 && r < len {
        if chars[l] != chars[r] {
            return false
        } 
        l -= 1
        r += 1
    }
    return true
}

print(isPalindrome(""))