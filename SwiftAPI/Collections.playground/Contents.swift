//:  # Collection
//:  A sequence whose elements can be traversed multiple times, nondestructively, and
//:  accessed by an indexed subscript.
let text = "Buffalo buffalo buffalo buffalo."
if let firstSpace = text.firstIndex(of: " ") {
    print(text[..<firstSpace])
}
//:  ## Accessing Individual Elements
//: You can access an element of a collection through its subscript by using any valid index except the collection’s endIndex property.
//: This property is a “past the end” index that does not correspond with any element of the collection.
let firstChar = text.first
let lastChar = text.last
let first = text[text.startIndex]
//:  ## Accessing Slices of Collection
//: You can access a slice of a collection through its ranged subscript or by calling methods like `prefix(while:)` or `suffix(_:)`1.
//: A slice of a collection can contain zero or more of the original collection’s elements and shares the original collection’s semantics.
let firstWord = text.prefix(while: {$0 != " "})
print(firstWord)
let words = text.split(separator: " ")
//:  ## Slices Share Indices
//:  A collection and its slices share the same indices. An element of a collection is located under the same index in a slice as in the
//: base collection, as long as neither the collection nor the slice has been mutated since the slice was created.
//: For example, suppose you have an array holding the number of absences from each class during a session.
var absences = [0, 2, 0, 4, 0, 3, 1, 0]
//:  Here’s an implementation of those steps:
let secondHalf = absences.suffix(absences.count / 2)
if let i = secondHalf.indices.max(by: { secondHalf[$0] < secondHalf[$1] }) {
      print("Highest second-half absences: \(absences[i])")
}
var currentIndex = text.endIndex
while text.formIndex(&currentIndex, offsetBy: -1, limitedBy: text.startIndex) {
    print(text[currentIndex])
}
//:  ## Slices Inherit Collection Semantics
//: A slice inherits the value or reference semantics of its base collection. That is, when working with a slice of a mutable collection
//: that has value semantics, such as an array, mutating the original collection triggers a copy of that collection and does not affect the contents of the slice.
absences[7] = 2
print(absences)
// Prints "[0, 2, 0, 4, 0, 3, 1, 2]"
print(secondHalf)
// Prints "[0, 3, 1, 0]"
//: ## Traversing a Collection
//: Although a sequence can be consumed as it is traversed, a collection is guaranteed to be multipass: Any element can be repeatedly accessed by saving its index. Moreover, a collection’s indices form a finite range of the positions of the collection’s elements. The fact that all collections are finite guarantees the safety of many sequence operations, such as using the contains(_:) method to test whether a collection includes an element.

//:Iterating over the elements of a collection by their positions yields the same elements in the same order as iterating over that collection using its iterator. This example demonstrates that the characters view of a string returns the same characters in the same order whether the view’s indices or the view itself is being iterated.
let word = "Swift"
for character in word {
    print(character)
}

for i in word.indices {
    print(word[i])
}
//: ## Conforming to the Collection Protocol

//: If you create a custom sequence that can provide repeated access to its elements, make sure that its type conforms to the Collection protocol in order to give a more useful and more efficient interface for sequence and collection operations. To add Collection conformance to your type, you must declare at least the following requirements:

//: * The `startIndex` and `endIndex` properties
//: * A subscript that provides at least read-only access to your type’s elements
//: * The `index(after:`) method for advancing an index into your collection
