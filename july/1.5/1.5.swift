// 最长回文子串

// 给一个字符串，求里面最长回文的长度

// 以一个中心向外扩展，记录最长的
struct Solution1 {

    var res = 0

    mutating func largestPalindrome(_ s: String) -> Int {
        if s.count <= 1 {
            return s.count
        }
        let chars = Array(s)
        for i in 0..<s.count - 1  {
            // even
            expandPalindrome(chars, i, i)
            expandPalindrome(chars, i, i + 1)
        }
        return res
    }

    mutating func expandPalindrome(_ chars: [Character], _ l: Int, _ r: Int) {
        var l = l, r = r
        while l > 0 && l < chars.count {
            if chars[l] == chars[r] {
                l -= 1
                r += 1
            } else {
                res = max(res, r - l - 1)
                break
            }
        }
    }
}


// Manacher算法
struct Solution2 {

}

var solution1 = Solution1()
print(solution1.largestPalindrome("fsfasdfasdgfgdafsdf"))