//: # Valid Palindrome
//: **Question**: Given a string, determine if it is a palindrome, considering only alphanumeric characters and ignoring cases.
//: For example: 
//: "A man, a plan, a canal: Panama" is a palindrome."
//: "race a car" is not a palindrome.
//:
//: **Clearification:**
//: Q: What about an empty string? Is it a valid palindrome?
//: A: For the purpose of this problem, we define empty string as valid palindrome.
//:
//:
//: **Solution: O(n) runtime, O(n) space:**
//: The idea is to use foundation functions to  filter out all white space.
//: Reverse the string and to check for equality. The tricky part is to check for whitespace characters.
//: We therfore define an extension on Character class.
import Foundation


func isPalindrome(_ s: String) -> Bool {
    
    let alphaNumeric = CharacterSet.letters.union(CharacterSet.decimalDigits)
    let notAlphaNumeric = alphaNumeric.inverted
    
    let trimmed = s.components(separatedBy: notAlphaNumeric)
        .filter { !$0.isEmpty }
        .joined(separator: "")
        .lowercased()
    
    return trimmed == String(trimmed.reversed())
}


isPalindrome("A man a plan a canal: Panama") == true
isPalindrome("thomas") == false
isPalindrome("112211") == true
isPalindrome("0p") == false
isPalindrome("Tt") == true
isPalindrome("      ") == true
isPalindrome("") == true
isPalindrome("AAA") == true
isPalindrome("!.;") == true

//: **Solution: O(n) runtime, O(1) space:**
//: The idea is simple, have two pointers – one at the head while the other one at tail.
//: Move them towards each other until they meet while skipping non-alphanumeric characters.
//: Consider the case where given string contains only non-alphanumeric characters. This is a valid palindrome because the empty string is also a valid palindrome.


extension Character
{
    func unicodeScalar() -> UnicodeScalar {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        return scalars[scalars.startIndex]
    }
}


func isPalindrome2(_ str: String) -> Bool {
    let alphaNumeric = CharacterSet.letters.union(CharacterSet.decimalDigits)
    
    if (str.isEmpty) {
        return true
    }
    
    let s = str.lowercased()
    var i = s.startIndex
    var j = s.index(before:s.endIndex)
    
    while i < j {
        while i < j  && !alphaNumeric.contains(s[i].unicodeScalar()) {
            i = s.index(after:i)
        }
        while i < j  && !alphaNumeric.contains(s[j].unicodeScalar()) {
            j = s.index(before:j)
        }
        if i < j  {
            if s[i] == s[j] {
                i = s.index(after:i)
                j = s.index(before:j)
            } else {
                return false
            }
        }
    }
    return true
    
}

isPalindrome2("A man a plan a canal: Panama") == true
isPalindrome2("thomas") == false
isPalindrome2("112211") == true
isPalindrome2("0p") == false
isPalindrome2("Tt") == true
isPalindrome2("      ") == true
isPalindrome2("") == true
isPalindrome2("AAA") == true
isPalindrome2("!.;") == true
