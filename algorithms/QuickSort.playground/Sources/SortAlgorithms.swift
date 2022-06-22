import Foundation


public func randomNumbers(_ len: Int, sorted: Bool = false) -> [Int] {
    var numbers = [Int](repeating: 0, count: len)
    for i in 0..<len {
        numbers[i] = i
    }
    return sorted ? numbers : numbers.shuffled()
}

public func insertionSort<T: Comparable>(_ a: inout [T], left: Int, right: Int) {
    for i in left...right {
        // Invariant: a[left]...a[i-1] is sorted
        // we take next x = a[i] to insert in array
        let x = a[i]
        var j = i-1
        while j >= left && a[j] > x  {
            a[j+1] = a[j]
            j -= 1
        }
        a[j+1] = x
    }
}

/// Inefficient but simple QuickSort implementation.
/// - Parameter a: An array to be sorted
/// - Returns: A sorted  array of comparable objecgts
public func quicksortParallel<T: Comparable>(_ a: [T]) async -> [T]  {
    guard a.count > 1 else { return a }
    
    // Select middle element to pivot array into less and greater arrays
    let pivot = a[a.count / 2]
    let less =  a.filter { $0 < pivot }
    let equal = a.filter { $0 == pivot }
    let greater = a.filter { $0 > pivot }
    
    async let left = quicksortParallel(less)
    async let right = quicksortParallel(greater)
    
    return await left + equal + right
}


/*
  Lomuto's partitioning algorithm.
  This is conceptually simpler than Hoare's original scheme but less efficient.
  The return value is the index of the pivot element in the new array. The left
  partition is [left...p-1]; the right partition is [p+1...right], where p is the
  return value.
  The left partition includes all values smaller than or equal to the pivot, so
  if the pivot value occurs more than once, its duplicates will be found in the
  left partition.
*/
public func partitionLomuto<T: Comparable>(_ a: inout [T], left: Int, right: Int) -> Int {
  // We always use the rightest item as the pivot.
  let pivot = a[right]

  // This loop partitions the array into four (possibly empty) regions:
  //   [left  ...      i-1] contains all values <= pivot,
  //   [i    ...      j-1] contains all values > pivot,
  //   [j    ... right-1] are values we haven't looked at yet,
  //   [right           ] is the pivot value.
  var i = left
  for j in left..<right {
    if a[j] <= pivot {
      a.swapAt(i,j)
      i += 1
    }
  }

  // Swap the pivot element with the first element that is greater than
  // the pivot. Now the pivot sits between the <= and > regions and the
  // array is properly partitioned.
    a.swapAt(i,right)
  return i
}


/*
  Hoare's partitioning scheme.
  The return value is NOT necessarily the index of the pivot element in the
  new array. Instead, the array is partitioned into [low...p] and [p+1...high],
  where p is the return value. The pivot value is placed somewhere inside one
  of the two partitions, but the algorithm doesn't tell you which one or where.
  If the pivot value occurs more than once, then some instances may appear in
  the left partition and others may appear in the right partition.
  Hoare scheme is more efficient than Lomuto's partition scheme; it performs
  fewer swaps.
*/
func partitionHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
  let pivot = a[low]
  var i = low - 1
  var j = high + 1

  while true {
    repeat { j -= 1 } while a[j] > pivot
    repeat { i += 1 } while a[i] < pivot

    if i < j {
        a.swapAt(i, j)
    } else {
      return j
    }
  }
}

/*
  Recursive, in-place version that uses Hoare's partioning scheme. Because of
  the choice of pivot, this performs badly if the array is already sorted.
*/
public func quicksort<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
  if low < high {
    let p = partitionHoare(&a, low: low, high: high)
    quicksort(&a, low: low, high: p)
    quicksort(&a, low: p + 1, high: high)
  }
}
