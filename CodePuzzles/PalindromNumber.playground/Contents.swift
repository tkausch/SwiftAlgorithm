//: # Palindrome Number
//:
//: **Question:** Determine whether an integer is a palindrome. Do this without extra space.
//:
//: **Clarification:**
//: * Q: Does negative integer such as –1 qualify as a palindrome?
//: * A: For the purpose of discussion here, we define negative integers as non palindrome.
//:
//: **Solution:** One approach is to first reverse the number. If the number is the same as its reversed, then it must be a palindrome. You could reverse a number by doing the following:
import Foundation

func reverse(_ i: Int) -> Int {
    var x = i
    var rtn = 0
    while x != 0 {
        rtn = rtn * 10 + x % 10
        x /= 10
    }
    return rtn
}

func isPalindrome(_ i: Int) -> Bool {
    return i < 0 ? false : i - reverse(i) == 0
}

isPalindrome(123)
isPalindrome(12121)
isPalindrome(1)
isPalindrome(0)

isPalindrome(-123)
isPalindrome(-12121)

//: This seemed to work too, but did you consider the possibility that the reversed number might overflow? 
//: 
//: We could construct a better and more generic solution. One pointer is that, we must start comparing the digits somewhere. And you know there could only be two ways, either expand from the middle or compare from the two ends.
//:
//: It turns out that comparing from the two ends is easier. First, compare the first and last digit. If they are not the same, it must not be a palindrome. If they are the same, chop off one digit from both ends and continue until you have no digits left, which you conclude that it must be a palindrome.
func isPalindrome2(_ i: Int) -> Bool {
    var x = i
    if x < 0 {
        return false
    } else {
        var div = 1
        while x / div >= 10 {
            div *= 10
        }
        while x != 0 {
            let left = x / div
            let right = x % 10
            if left != right {
                return false
            }
            x = x % div / 10
            div /= 100
        }
        return true
    }
}

isPalindrome2(123)
isPalindrome2(12121)
isPalindrome(1)
isPalindrome(0)
