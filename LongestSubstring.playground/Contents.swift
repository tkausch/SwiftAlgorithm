//: # Longest Substring Without Repeating Characters


//: **Question:** Given a string, find the length of the longest substring without  repeating characters. For example, the longest substring without repeating letters for “abcabcbb” is “abc”, which the length is 3. For “bbbbb” the longest substring is “b”, with the length of 1.

//: **Solution: O(n) runtime, O(1) space - Single Iteration**:
//: How can we look up if a character exists in a substring instantaneously? The answer is to use a simple map to store the last index of the characters that have appeared. We assume here that the string does contain ASCII characters only.
//: The next question is to ask yourself what happens when you found a repeated character? For example, if the string is “abcdcedf”, what happens when you reach the second appearance of ‘c’?
//: When you have found a repeated character (let’s say at index j), it means that the current substring (excluding the repeated character of course) is a potential maximum, so update the maximum if necessary. It also means that the repeated character must have appeared before at an index i, where i is less than j.
//: Since you know that all substrings that start before or at index i would be less than your current maximum, you can safely start to look for the next substring with head which starts exactly at index i + 1. Therefore, you would need two indices to record the head and the tail of the current substring. Since i and j both traverse at most n steps, the worst case would be 2n steps, which the runtime complexity must be O(n).
//: Note that the space complexity is constant O(1), even though we are allocating an array. This is because no matter how long the string is, the size of the array stays the same at 256.

import UIKit


func lengthOfLongestSubstring(s: String) -> Int {
    // Precondtion: s contains only ASCII characters
    var charMap = Dictionary<Character, String.Index>()
    var i = s.startIndex; var maxLength = 0
    for j in s.characters.indices {
        if let lastIdx = charMap[s[j]]  {
            if lastIdx >= i {
                i = s.index(after:lastIdx)
            }
        }
        charMap[s[j]] = j
        maxLength = max(s.distance(from: i, to: j) + 1  , maxLength)
    }
    return maxLength
}


lengthOfLongestSubstring(s: "abcdabcde")









