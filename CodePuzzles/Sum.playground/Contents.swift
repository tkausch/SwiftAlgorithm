//: # Two Sum
//: **Question**: Given an array of integers, return indices of the two numbers such that they add up to a specific target. The function twoSum should return indices of the two numbers such that they add up to the target, where index1 must be less than index2. You may assume that each input would have exactly one solution.

//: **Solution**: The brute force approach is simple. Loop through each element x and find if there is another value that equals to target – x. As finding another value requires looping through the rest of array, its **runtime complexity is O(n2) with O(1) space**
import UIKit

let nums = [3,2,4];

func twoSum(numbers: [Int], target: Int) -> (Int,Int)? {
    for i in 0..<numbers.count {
        let x = target - numbers[i]
        for j in i+1..<numbers.count {
            if x == numbers[j] {
                return (i,j);
            }
        }
    }
    return nil
}

twoSum(numbers: nums, target: 6)

//: We could reduce the runtime complexity of looking up a value to O(1) using a hash map that maps a value to its index using O(n) space.
func twoSum2(numbers: [Int], target: Int) -> (Int,Int)? {
    var valueToIndex = Dictionary<Int,Int>()
    for i in 0..<numbers.count {
        let x = target - numbers[i]
        if let index = valueToIndex[x] {
            return (index, i)
        } else {
            valueToIndex[numbers[i]]=i
        }
    }
    return nil
}

twoSum2(numbers: nums, target: 6)
//:  **Question**: What if the given input is already sorted in ascending order? Of course we could still apply the hash table approach but it costs us o(n) extra space plus it does not make use of the fact the input is already sorted. Using binary search we end up with an algorithm with **runtime o(n log n) and only o(1) space**. And becasue we could also sort the array in o(n log n) time with quick sort this is also the runtime bound for the unsorted case.


func twoSum3(numbers: [Int], target: Int) -> (Int,Int)? {
    numbers.sorted()
    for i in 0..<numbers.count {
        let  x = target - numbers[i]
        if let index = numbers.binarySearch(low: i+1, high: numbers.count - 1, value: x) {
            return (i, index)
        }
    }
    return nil
}

//: At the moment there is no such thing as a binary search in swift standard library. So we have to write our own Array extension. This is straight forward.

extension Array where Element: Comparable {
   
    func binarySearch(low: Int, high: Int, value: Array.Element) -> Index? {
        var left = low
        var right = high
        while left < right {
            let mid = (low + high) / 2
            if self[mid] < value {
                left = mid + 1
            } else {
                right = mid
            }
        }
        return left == right && self[right] == value ? right : nil
    }
    
}

let sortedNums = [2,3,4]

twoSum3(numbers: sortedNums, target: 6)


//:There is even a solution with **o(n) runtime** and the same space: Let's assume we have two indices to the ith and jth elements, Ai and Aj respectively.The sum of Ai and Aj could only fall into one of these three possibilities:
//: 1. Ai + Aj > target. Increasing i isn't going to help us, as it makes the sum even bigger. Therfore we should decrement j.
//: 2. Ai + Aj < target. Decreasing j isn't going to help us, as is makes the sum eveen smaller. Therefore we should increment i.
//: 3. Ai + Aj == target. We have found the answer.

func twoSum4(a: [Int], target: Int) -> (Int,Int)? {
    var i = 0
    var j = a.count - 1
    while i < j {
        var sum = a[i] + a[j]
        if sum > target {
            j -= 1
        } else if sum < target {
            i += 1
        } else {
            return (i,j)
        }
    }
    return nil
}

twoSum4(a: sortedNums, target: 6)

