// 3、单词翻转。输入一个英文句子，翻转句子中单词的顺序，
// 但单词内字符的顺序不变，句子中单词以空格符隔开。
// 为简单起见，标点符号和普通字母一样处理。例如，输入“I am a student.”，
// 则输出“student. a am I”。
// O(n) O(1)

// 先翻转全部，然后用两个pointers记录一个翻转词的开始和结束，当遇到空格的时候翻转pointers之间的字符


func flipWords(_ s: String) -> String {
    if s.count < 2 {
        return s
    }

    var chars = Array(s)
    swapChars(&chars, 0, chars.count - 1)
    var ws = 0, we = 0
    while we < chars.count {
        if chars[we] == " " {
            swapChars(&chars, ws, we - 1)
            ws = we + 1
        }
        we += 1
    }
    swapChars(&chars, ws, we - 1)
    return String(chars)
}

func swapChars(_ chars: inout [Character], _ s: Int, _ e: Int) {
    assert(s >= 0 && e < chars.count, "Input Error!\n")

    var s = s, e = e
    while s < e {
        let temp = chars[s]
        chars[s] = chars[e]
        chars[e] = temp
        s += 1
        e -= 1
    }
}


print(flipWords(" Ia am a student. "))

