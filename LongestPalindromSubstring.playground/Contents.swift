//: # Longest Palindromic Substring

//: **Question:** Given a string S, find the longest palindromic substring in S. You may assume there exists one unique longest palindromic substring.
//: **Hint:** First, make sure you understand what a palindrome means. A palindrome is a string which reads the same in both directions. For example, “aba” is a palindome, “abc” is not.

//: **Brute force - O(n3) runtime, O(n) space:** The obvious brute force solution is to pick all possible starting and ending positions for a substring, and verify if it is a palindrome. There are a total of `𝑛 * (n-1)` such substrings (excluding the trivial solution where a character itself is a palindrome).

import Foundation

func longestPalindromeSubString(_ s: String) -> String {
    guard s.count > 2 else {
        return s
    }
    var maxLen = 0
    var longestPalindrome = ""
    for start in s.indices {
        var end = s.index(after: start)
        while end != s.endIndex {
            let p = s[start ..< end]
            if p == String(p.reversed()) {
                if p.count > maxLen {
                    maxLen = p.count
                    longestPalindrome = String(p)
                }
            }
            end = s.index(after: end)
        }
    }
    return longestPalindrome
}
longestPalindromeSubString("aabbab") == "abba"
longestPalindromeSubString("aabab") == "aba"
longestPalindromeSubString("babababcd") == "bababab"
longestPalindromeSubString("abc") == "a"
longestPalindromeSubString("a") == "a"
longestPalindromeSubString("") == ""



//: **Simpler solution - O(n2) runtime, O(1) space**
//: In fact, we could solve it in O(n2) time using only constant space.
//: We observe that a palindrome mirrors around its center. Therefore, a palindrome can be expanded from its center, and there are only 2n – 1 such centers.
//: You might be asking why there are 2n – 1 but not n centers? The reason is the center of a palindrome can be in between two letters. Such palindromes have even number of letters (such as “abba”) and its center are between the two ‘b’s.
//: Since expanding a palindrome around its center could take O(n) time, the overall complexity is O(n2).


func longestPalindromeSubStr(_ s: String) -> String {
    
    var maxLen = 0
    var maxStart: String.Index = s.startIndex
    
    func expand(left: String.Index, right: String.Index) ->  (start: String.Index,len: Int) {
        var len = 0
        var l = left, r = right
        while r != s.endIndex && s[l] == s[r] {
            if l != r {
                len += 2
            } else {
                len += 1
            }
            if (l == s.startIndex) {
                return (l,len)
            } else {
                l = s.index(before: l)
            }
            r = s.index(after: r)
        }
        return (s.index(after: l),len)
    }
    
    func updateMax(_ t:(start: String.Index, len: Int)) {
        if t.len > maxLen {
            maxLen = t.len
            maxStart = t.start
        }
    }
    
    for pos in s.indices {
        updateMax(expand(left: pos, right: pos))
        updateMax(expand(left: pos, right: s.index(after: pos)))
    }
    
    return String(s[maxStart..<s.index(maxStart, offsetBy: maxLen)])
    
}

longestPalindromeSubStr("aabbab") == "abba"
longestPalindromeSubStr("aabab") == "aba"
longestPalindromeSubStr("babababcd") == "bababab"
longestPalindromeSubStr("abc") == "a"
longestPalindromeSubStr("a") == "a"
longestPalindromeSubStr("") == ""


//: **Manacher's algorithm: O(n) runtime, O(n) space** 
//: There is even an O(n) algorithm called Manacher's algorithm, explained [here in detail](http://articles.leetcode.com/longest-palindromic-substring-part-ii). However, it is a non-trivial algorithm. please go ahead and understand it.

