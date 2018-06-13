// 2、编写程序，在原字符串中把字符串尾部的m个字符移动到字符串的头部，
// 要求：长度为n的字符串操作时间复杂度为O(n)，空间复杂度为O(1)。 
// 例如，原字符串为”Ilovebaofeng”，m=7，输出结果为：”baofengIlove”。


func shiftString(_ s: String, _ m: Int) -> String {
    if m >= s.count {
        return s
    }

    var chars = Array(s)
    let n = chars.count
    print(chars)

    swapChars(&chars, 0, n - m - 1)
    swapChars(&chars, n - m, n - 1)
    swapChars(&chars, 0, n - 1)

    return String(chars)
}

func swapChars(_ chars: inout [Character], _ s: Int, _ e: Int) {
    assert(s >= 0 && e < chars.count ,"Inputs Error!")
    var s = s, e = e
    while(s < e) {
        let temp = chars[s]
        chars[s] = chars[e]
        chars[e] = temp

        s += 1
        e -= 1
    }
}

print(shiftString("ilovebaofeng", 7))