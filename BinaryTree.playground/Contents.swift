//: # Binary Tree and Binary Search Tree
//:
//: First, you must understand the difference between Binary Tree (BT) and Binary Search Tree (BST). Binary tree is a tree data structure in which each BinaryTree has at most two child nodes.

public class BinaryTree<T: Comparable> {
    var value : T
    var left : BinaryTree?
    var right: BinaryTree?
    
    public convenience init(value: T) {
        self.init(value: value,left: nil,right: nil)
    }
    
    public init(value: T, left: BinaryTree?, right: BinaryTree?) {
        self.value = value
        self.left = left
        self.right = right
    }
    
    public func isLeave() -> Bool {
        return left == nil && right == nil
    }
}

let n3 = BinaryTree(value: 3)
let n4 = BinaryTree(value: 4, left: n3, right: nil)
let n6 = BinaryTree(value: 6)
let n5 = BinaryTree(value: 5, left: n4, right: n6)
let n9 = BinaryTree(value: 9)
let n7 = BinaryTree(value: 7, left: n5, right: n9)
let bst = n7

//: A BST is based on binary tree, but with the following additional properties:
//: * The left subtree of a BinaryTree contains only nodes with keys less than the node’s key.
//: * The right subtree of a BinaryTree contains only nodes with keys greater than the node’s key.
//: * Both the left and right subtrees must also be binary search trees.

//: ## Validate Binary Search Tree
//: **Question:** Given a binary tree, determine if it is a valid Binary Search Tree (BST).
//:
//: **Solution: O(n) runtime, O(n) stack space – Recursion:** We pass down the low and high limits from the parent to its children and only have to check these limits for the current tree node value. We will visit each tree node exactly once which results in the o(n) runtime.
//:
extension BinaryTree {

    public static func isValidBST(tree: BinaryTree<T>?, low: T, high: T) -> Bool {
        if let value = tree?.value {
            return low < value && value <= high &&
                isValidBST(tree: tree?.left, low: low, high: value) &&
                isValidBST(tree: tree?.right, low: value, high: high)
        } else {
            return true
        }
    }
}

BinaryTree.isValidBST(tree: bst, low: Int.min, high: Int.max)

//: ## Maximum Depth of Binary Tree
//: **Question:** Given a binary tree, find its maximum depth.The maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.
//:
//: **Solution:  O(n) runtime, O(log n) space – Recursion:**  We could solve this easily using recursion, because each of the left child and right child of a node is a sub-tree itself. We first compute the max height of left sub-tree, and then compute the max height of right sub-tree. The maximum depth of the current node is the greater of the two maximums plus one. For the base case, we look at a tree that is empty, which we return 0.
//:
//: Assume that n is the total number of nodes in the tree. The runtime complexity is O(n) because it traverse each node exactly once. As the maximum depth of a binary tree is O(log n), the extra space cost is O(log n) due to the extra stack space used by the recursion.
extension BinaryTree {
    
    public func maxDepth() -> Int {
        return BinaryTree.maxDepth(tree: self)
    }
    
    public static func maxDepth(tree: BinaryTree<T>?) -> Int {
        if let t = tree {
            return max(maxDepth(tree: t.left), maxDepth(tree: t.right)) + 1
        } else {
            return 0
        }
    }
    
}
bst.maxDepth()
//: ## Minimum Depth of Binary Tree
//: **Question:** Given a binary tree, find its minimum depth. The minimum depth is the number of nodes along the shortest path from the root node down to the nearest leaf node.
//:
//: **Solution: O(n) runtime, O(log n) space - Recursion:** Similar to the recursion approach to find the maximum depth, but make sure you consider these special cases where we can prune tree traversal.
//: * The node itself is a leaf node. The minimum depth is one.
//: * Node that has one empty sub-tree while the other one is non-empty. Return the minum depth of that non-empty sub-tree plus 1.
extension BinaryTree {
    
    public func minDepth() -> Int {
        return BinaryTree.minDepth(tree: self)
    }
    
    public static func minDepth(tree: BinaryTree<T>?) -> Int {
        if let t = tree {
            if let left = t.left {
                if let right = t.right {
                    return min(minDepth(tree: left), minDepth(tree: right)) + 1
                } else {
                    return minDepth(tree: left) + 1
                }
            } else {
                return minDepth(tree: t.right) + 1
            }
        } else {
            return 0
        }
    }
}

bst.minDepth()
//: **Solution: O(n) runtime, O(log n) space - Breadth first traversal :** Note that the previous approach traverses  many nodes even for a highly unbalanced tree. In fact, we could optimize this scenario by doing a breadth-first traversal (also known as level-order traversal). When we encounter the first leaf node, we immediately stop the traversal.
//:
//: We also keep track of the current depth and increment it when we reach the end of level. We know that we have reached the end of level when the current node is the right-most node.
//:
//: Compared to the recursion approach, the breadth-first traversal works well for highly unbalanced tree. The worst case is when the tree is a full binary tree with a total of n nodes. In this case, we have to traverse all nodes. The worst case space complexity is O(n), due to the extra space needed to store current level nodes in the queue.
//:
extension BinaryTree {
    
    public func minDepthOptimized() -> Int {
        return BinaryTree.minDepthOptimized(tree: self)
    }
    
    public static func minDepthOptimized(tree: BinaryTree<T>?) -> Int {
        
        if let t = tree {
            
            var queue = Array<BinaryTree<T>>()
            queue.append(t)
            var rightMost = t
            var depth = 1
            
            while !queue.isEmpty {
                
                let node = queue.removeFirst()
                if node.isLeave() {
                    break
                }
                
                if let left = node.left {
                    queue.append(left)
                }
                
                if let right = node.right {
                    queue.append(right)
                }
                
                if node === rightMost {
                    rightMost = queue.last!
                    depth += 1
                }
            }
            
            return depth
            
        } else {
            return 0
        }
        
    }
    
    
    
}

bst.minDepthOptimized()
//: Note queue.removeFirst has o(n) runtime and is very inefficient. Really hope Swift Foundation will provide efficient data structures.

//: ## Balanced Binary Tree
//: **Question:** Given a binary tree, determine if it is height-balanced. For this problem, a height-balanced binary tree is defined as a binary tree in which the depth of the two subtrees of every node never differs by more than 1.

//: **Solution: O(n2) runtime, O(n) stack space –Bottom-up recursion:** We use a sentinel value –1 to represent that the tree is unbalanced so we could avoid unnecessary calculations. In each step, we look at the left subtree’s depth (L), and ask: “Is the left subtree unbalanced?” If it is indeed unbalanced, we return –1 right away. Otherwise, L represents the left subtree’s depth. We then repeat the same process for the right subtree’s depth (R). We calculate the absolute difference between L and R. If the subtrees’ depth difference is less than one, we could return the height of the current node, otherwise return –1 meaning the current tree is unbalanced.

extension BinaryTree {
    
    public func isBalanced() -> Int {
        return BinaryTree.isBalanced(tree: self)
    }
    
    
    public static func isBalanced(tree: BinaryTree<T>?) -> Int {
        if let t = tree {
            
            let leftHeight = isBalanced(tree: t.left)
            if leftHeight < 0 {
                return -1
            }
            
            let rightHeight = isBalanced(tree: t.right)
            if rightHeight < 0 {
                return -1
            }
            
            return abs(leftHeight - rightHeight) <= 1 ? max(leftHeight, rightHeight) + 1 : -1
            
        } else {
            return 0
        }
    }
}

bst.isBalanced()



//: ## Insert for Binary search Tree
//: **Question:** Given a binary tree, insert a new value.
//:
//: **Solution: O(depth(BST))**

extension BinaryTree {
    
    public func insert(value: T) {
        let node = BinaryTree(value: value)
        insert(node: node)
    }
    
    private func insert(node: BinaryTree<T>) {
        if node.value <= value  {
            if let l = left {
                l.insert(node: node)
            } else {
                left = node
            }
        } else {
            if let r = right {
                r.insert(node: node)
            } else {
                right = node
            }
        }
    }
}

//: ## Convert Sorted Array to Balanced Binary Search Tree
//: **Question:** Given an array where elements are sorted in ascending order, convert it to a height balanced BST.
//:
//: **Hint:** This question is highly recursive in nature. Think of how binary search works.
//:
//: **Solution: O(n) runtime, O(log n) stack space – Divide and conquer:**
//: If you would have to choose an array element to be the root of a balanced BST, which element would you pick? The root of a balanced BST should be the middle element from the sorted array.
//:
//: You would pick the middle element from the sorted array in each iteration. You then create a node in the tree initialized with this element. After the element is chosen, what is left? Could you identify the sub-problems within the problem?
//:
//: There are two arrays left — The one on its left and the one on its right. These two arrays are the sub-problems of the original problem, since both of them are sorted. Furthermore, they are subtrees of the current node’s left and right child.
//:
//: The code below creates a balanced BST from the sorted array in O(n) time (n is the number of elements in the array). Compare how similar the code is to a binary search algorithm. Both are using the divide and conquer methodology. Because the input array could be subdivided in at most log(n) times, the extra stack space used by the recursion is in O(log n).


extension BinaryTree {
    
    public static func createBST(sortedValues: [T]) -> BinaryTree<T>? {
        
        func createRecursiveBST(start: Int, end: Int) -> BinaryTree<T>? {
            if start > end {
                return nil
            }  else {
                let mid = (start + end) / 2
                let node = BinaryTree(value: sortedValues[mid])
                
                node.left = createRecursiveBST(start: start, end: mid-1)
                node.right = createRecursiveBST(start: mid+1, end: end)
                
                return node
            }
        }
        
        return createRecursiveBST(start: 0, end: sortedValues.count - 1)
    }
    
}


let sortedArray = [1,2,3,4,5,6]
let bst2 = BinaryTree.createBST(sortedValues: sortedArray)








