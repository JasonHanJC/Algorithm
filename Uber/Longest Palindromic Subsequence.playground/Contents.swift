//:  Longest Palindromic Subsequence, note not substring
/*
 https://leetcode.com/problems/longest-palindromic-subsequence/discuss/99101/Straight-forward-Java-DP-solution
 Given a string s, find the longest palindromic subsequence's length in s. You may assume that the maximum length of s is 1000.
 
 Example 1:
 Input:
 
 "bbbab"
 Output:
 4
 One possible longest palindromic subsequence is "bbbb".
 Example 2:
 Input:
 
 "cbbd"
 Output:
 2
 One possible longest palindromic subsequence is "bb".
 */

// DP: dp[i][j] = the longest palindromic subsequence's length of substring(i,j)
// if char at i == char at j, dp[i][j] = 2 + dp[i + 1][j - 1]
// else dp[i][j] = max(dp[i][j-1], dp[i+1][j])
// dp[i][i] = 1

func longestPalindromeSubseq(_ s: String) -> Int {
    // create dp
    let len = s.count
    var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: len), count: len)
    let chars = Array(s)
    for j in 0...len - 1 {
        dp[j][j] = 1
        var i = j - 1
        while i >= 0 {
            if chars[i] == chars[j] {
                dp[i][j] = 2 + dp[i + 1][j - 1]
            } else {
                dp[i][j] = max(dp[i + 1][j], dp[i][j - 1])
            }
            i -= 1
        }
    }
    return dp[0][len - 1]
}

longestPalindromeSubseq("bbab")
