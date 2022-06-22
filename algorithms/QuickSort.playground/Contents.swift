import UIKit
import Foundation


let len = 1000000

var numbers = randomNumbers(len, sorted: false)


print ("Start sorting \(len) numbers...")

let started = CFAbsoluteTimeGetCurrent()

// numbers.sort()

// quicksort(&numbers, low: 0, high: numbers.count - 1)

Task {

    await quicksortParallel(numbers)
    
print("Total Time: \(CFAbsoluteTimeGetCurrent() - started)")
// print(numbers)

    
}

