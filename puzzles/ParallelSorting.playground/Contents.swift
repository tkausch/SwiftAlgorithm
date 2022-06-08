import UIKit

import Foundation

import _Concurrency

var greeting = "Hello, playground"


func quicksortConcurrent<T: Comparable>(_ a: [T]) async  -> [T]  {
    guard a.count > 1 else {
        return a
    }
    
    // Select random element to pivot array into left and right
    let pivot = a[a.count / 2]
    let less = a.filter { $0 < pivot }
    let equal = a.filter { $0 == pivot }
    let greater = a.filter { $0 > pivot }
    
    let lessSorted =   await quicksortConcurrent(less)
    let greaterSorted = await quicksortConcurrent(greater)
    
    return  lessSorted + equal + greaterSorted
}

func merge<T: Comparable>(a: [T], b:[T]) async -> [T]  {
    var result = [T]()
    var iteratorA = a.makeIterator(), iteratorB = b.makeIterator()
    var nextA: T! = iteratorA.next(), nextB: T! = iteratorB.next()
    
    while nextA != nil && nextB != nil {
        if nextA < nextB   {
            result.append(nextA)
            nextA = iteratorA.next()
        } else {
            result.append(nextB)
            nextB = iteratorB.next()
        }
    }
    
    // Append all a's
    while nextA != nil {
        result.append(nextA)
        nextA = iteratorA.next()
    }
    
    // Append all b's
    while nextB != nil {
        result.append(nextB)
        nextB = iteratorB.next()
    }
    
    
    return result
    
}


func mergeSort<T: Comparable>(_ a: [T]) async -> [T] {
    
    guard a.count > 1 else {
        return a
    }
    let middleIndex = a.count / 2
    
    async let left =  mergeSort(Array(a[0..<middleIndex]))
    async let right = mergeSort(Array(a[middleIndex..<a.count]))
    
    return await merge(a: await left, b: await right)
}



// Create Random shuffled Array
let max = 1000
var randNumbers = [Int](repeating: 0, count: max)
for i in 0..<max {
    randNumbers[i] = i
}
randNumbers.shuffled()



//async {
//    print ("Start Quick sort...")
//    let started = CFAbsoluteTimeGetCurrent()
//    await quicksortConcurrent(randNumbers)
//    print("Total Time QuickSort: \(CFAbsoluteTimeGetCurrent() - started)")
//}


async {
    print ("Start Merge sort...")
    let started = CFAbsoluteTimeGetCurrent()
    await mergeSort(randNumbers)
    print("Total Time MergeSort: \(CFAbsoluteTimeGetCurrent() - started)")
    print(randNumbers)
}
