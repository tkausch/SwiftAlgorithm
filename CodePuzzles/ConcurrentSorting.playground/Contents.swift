import SwiftUI


func quicksort<T: Comparable>(_ a: [T]) async  -> [T]  {
    guard a.count > 1 else {
        return a
    }
    
    // Select random element to pivot array into left and right
    let pivot = a[a.count / 2]
    let less = a.filter { $0 < pivot }
    let equal = a.filter { $0 == pivot }
    let greater = a.filter { $0 > pivot }
    
    let lessSorted =   await quicksort(less)
    let greaterSorted = await quicksort(greater)
    
    return  lessSorted + equal + greaterSorted
}

func merge<T: Comparable>(a: [T], b:[T]) -> [T]  {
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
    
    let left = await  mergeSort(Array(a[0..<middleIndex]))
    let right = await  mergeSort(Array(a[middleIndex..<a.count]))
    
    return merge(a: left, b: right)
}



// Create large Random shuffled Array
func createRandomArray() -> [Int] {
    let max = 10000
    var randNumbers = [Int](repeating: 0, count: max)
    for i in 0..<max {
        randNumbers[i] = i
    }
    return randNumbers.shuffled()
}


Task() {
    let randomNumbers = createRandomArray()
    print ("Start Quick sort...")
    let started = CFAbsoluteTimeGetCurrent()
    await quicksort(randomNumbers)
    print("Total Time QuickSort: \(CFAbsoluteTimeGetCurrent() - started)")
}


//Task() {
//    print ("Start Merge sort...")
//    let started = CFAbsoluteTimeGetCurrent()
//    await mergeSort(randNumbers)
//    print("Total Time MergeSort: \(CFAbsoluteTimeGetCurrent() - started)")
//}

