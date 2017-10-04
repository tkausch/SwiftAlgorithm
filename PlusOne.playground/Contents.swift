/**
 * Question Link: https://leetcode.com/problems/plus-one/
 * Primary idea: Iterate and change the array from last to the first
 *
 * Time Complexity: O(n), Space Complexity: O(1)
 */

func plusOne(_ digits: [Int]) -> [Int] {
    var digits = digits
    var index = digits.count - 1
        
    while index >= 0 {
        if digits[index] < 9 {
            digits[index] += 1
            return digits
        } else {
            digits[index] = 0
        }
        index -= 1
    }
        
    digits.insert(1, at: 0)
        
    return digits
}

plusOne([1,2,3,4,5,6,7])
plusOne([1,2,3,4,9,9,9])
plusOne([9,9,9,4,9,9,9])
plusOne([9,9,9,9,9,9,9])

