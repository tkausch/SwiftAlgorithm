//: # Missing Ranges
//: **Question:** , return its missing ranges. For example, given `[0, 1, 3, 50, 75]`, return `[“2”, “4->49”, “51->74”, “76->99”]`
//: **Example Questions to clarify the problem:**
//: * Q: What if the given array is empty?
//: * A: Then you should return [“0->99”] as those ranges are missing.
//: * Q: What if the given array contains all elements from the ranges?
//: * A: Return an empty list, which means no range is missing.
//: * Q: What if start is bigger than end
//: * A: You can expect this is not the case or just return an empty array.
//: **Solution:** Compare the gap between two neighbor elements and output its range, simple as that right? This seems deceptively easy, except there are multiple edge cases to consider, such as the first and last element, which does not have previous and next element respectively. Also, what happens when the given array is empty?
import Foundation

func createRange(from: Int, to: Int) -> String? {
    if to < from {
        return nil
    } else {
        return from == to ? String(from) : "\(String(from)) -> \(String(to))"
    }
}

func findMissingRanges(vals: [Int], start: Int, end: Int) -> [String] {
    
    if vals.count == 0  {
        if let range = createRange(from: start, to: end) {
            return [range]
        } else {
            // This is the case where start > end
            return []
        }
    } else {
        // Postcondition: vals.count > 0
        
        var missingRanges = [String]()
        
        if let startRange = createRange(from: start, to: vals[0] - 1) {
            missingRanges.append(startRange)
        }
        
        var i = 1
        while i + 1 < vals.count {
            if let middleRange = createRange(from: vals[i] + 1, to: vals[i+1] - 1) {
                missingRanges.append(middleRange)
            }
            i += 2
        }
        
        if let endRange = createRange(from: vals.last! + 1, to: end) {
            missingRanges.append(endRange)
        }
    
        return missingRanges
        
    }
}

let valsTest1 = [0, 1, 3, 50, 75]
let valsTest2 = [0, 1, 3, 50, 75, 90]
let valsTestEmpty = [Int]()
let valsTestOne = [1]
let valsTestAll = [0,99]

findMissingRanges(vals: valsTest1, start: 0, end: 99)
findMissingRanges(vals: valsTest2, start: 0, end: 99)
findMissingRanges(vals: valsTestEmpty, start: 0, end: 99)
findMissingRanges(vals: valsTestOne, start: 0, end: 99)
findMissingRanges(vals: valsTestAll, start: 0, end: 99)
//: **Improved Solution:** As it turns out, if we could add two “artificial” elements, –1 before the first element and 100 after the last element, we could avoid the above pesky cases for the beginning and last element.
func findMissingRanges2(vals: [Int], start: Int, end: Int) -> [String] {
    
    // add sentinel values with
    var values = [start - 1]
    values.append(contentsOf: vals)
    values.append(end + 1)
    
    var ranges = [String]()
    var i = 0
    while i + 1 < values.count {
        if let newRange = createRange(from: values[i] + 1, to: values[i+1] - 1) {
            ranges.append(newRange)
        }
        i += i < values.count - 2 ? 2 : 1
    }
    
    return ranges
    
}

findMissingRanges2(vals: valsTest1, start: 0, end: 99)
findMissingRanges2(vals: valsTestEmpty, start: 0, end: 99)
findMissingRanges2(vals: valsTestOne, start: 0, end: 99)
findMissingRanges2(vals: valsTestAll, start: 0, end: 99)






