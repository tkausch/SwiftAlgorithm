import Foundation


class WordNode {
    
    let word: String
    var neighbors: [WordNode]
    var visited: Bool = false
    
    init(_ word: String) {
        self.word = word
        self.neighbors = [WordNode]()
    }
    
    func isAdjacent(_ other: WordNode) -> Bool {
        
        let otherWord = other.word
        
        // count different charecters in word and other.word
        var i = word.startIndex
        var j = otherWord.startIndex
        var diffCount = 0
        
        while  i != word.endIndex {
            if word[i] != otherWord[j] {
                diffCount += 1
            }
            i = word.index(after: i)
            j = otherWord.index(after: j)
        }
        return i == word.endIndex && diffCount == 1
    }
    
}




class WordLadderGraph {
    
    var beginNode: WordNode
    var nodes: [WordNode]
    
    init(beginWord: String, wordList: [String]) {
        beginNode = WordNode(beginWord)
        nodes = [WordNode]()
        nodes.append(beginNode)
        
        // initialize Graph by adding words in list
        for w in wordList {
            add(word: w)
        }
        
    }
    
    private func add(word: String) {
        let newNode = WordNode(word)
        for node in nodes {
            if node.isAdjacent(newNode) {
                node.neighbors.append(newNode)
                newNode.neighbors.append(node)
            }
        }
        nodes.append(newNode)
    }
    
    
    private func bfs(queue: inout [WordNode], root: WordNode)  {
        
        // initialze queue with root
        if queue.isEmpty {
            queue.append(root)
        }
        
        while !queue.isEmpty {
            var counter = queue.count
            while counter > 0 {
                let removed = queue.removeFirst()
                counter -= 1
                if !removed.visited {
                    print(removed.word)
                    queue.append(contentsOf: removed.neighbors)
                    removed.visited = true
                }
            }
        }
        
        
        
    }
    
    
    func shortestPath()  {
        var queue = [WordNode]()
        bfs(queue: &queue, root: beginNode)
    }
    
   
    
}


let hot = WordNode("hot")
let hit = WordNode("hit")

hot.isAdjacent(hit)


let list = ["hot","dot","dog","lot","log","cog"]

let wordLadderGraph = WordLadderGraph(beginWord: "hit", wordList: list)


wordLadderGraph.shortestPath()
