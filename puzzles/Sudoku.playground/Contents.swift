//: # Sudoku
//: A standard Sudoku contains 81 cells, in a 9×9 grid, and has 9 boxes, each box being the intersection of the first, middle, or last 3 rows,
//: and the first, middle, or last 3 columns. Each cell may contain a number from one to nine, and each number can only occur once in each row,
//: column, and box. A Sudoku starts with some cells containing numbers (clues), and the goal is to solve the remaining cells.
//: Proper Sudokus have one solution.
//:
//: **Question:** Given a sudoku grid, we need to verify if the already filled in numbers doesn't violate
//: the sudoku rules. The rules are very simple:
//: * Each row has numbers from 1-9 and no repetitions
//: * Each column has numbers from 1-9 and no repetitions
//: * Each 3x3 cube has numbers from 1-9 and no repetitions
//:
//: **Solution:** The following algorithm adds a check for each row, column and box. Calculating the box indices is a little bit tricky but still straight forward using div and modulo operators. As we have two for loops that iterate over the board runtime complexity is **O(n2)**.
func isValidSudoku(_ board:  [[Character]]) -> Bool {
    let n = board.count
    for i in 0..<n {
        
        var colSet = Set<Character>()
        var rowSet = Set<Character>()
        var boxSet = Set<Character>()
        
        let rowIdx = 3*(i/3)
        let colIdx = 3*(i%3)
        
        for j in 0..<n {
            if board[i][j] != Character(".") && !rowSet.insert(board[i][j]).inserted {
                return false
            }
            if board[j][i] != Character(".") && !colSet.insert(board[j][i]).inserted {
                return false
            }
            if board[rowIdx + j/3][colIdx + j%3] != Character(".") && !boxSet.insert(board[rowIdx + j/3][colIdx + j%3]).inserted {
                return false
            }
        }
    }
    return true
}

var validSudoku: [[Character]] = [
    [".", "3", ".", "1", ".", ".", ".", ".", "6"],
    [".", "6", ".", "3", "9", ".", ".", "1", "."],
    ["4", ".", ".", ".", "2", "6", ".", "7", "."],
    ["5", "9", "1", "6", ".", ".", "4", ".", "."],
    [".", ".", "7", ".", "4", ".", "1", ".", "."],
    [".", ".", "4", ".", ".", "2", "3", "5", "9"],
    [".", "4", ".", "2", "7", ".", ".", ".", "5"],
    [".", "7", ".", ".", "3", "5", ".", "4", "."],
    ["9", ".", ".", ".", ".", "8", ".", "3", "."]
]
isValidSudoku(validSudoku)


let invalidRowSudoku: [[Character]] = [
    [".", "3", ".", "1", ".", ".", ".", ".", "6"],
    [".", "6", ".", "3", "9", ".", ".", "1", "."],
    ["4", ".", ".", ".", "2", "6", ".", "7", "."],
    ["5", "9", "1", "6", ".", ".", "4", ".", "."],
    [".", ".", "7", ".", "4", ".", "1", ".", "."],
    [".", ".", "4", ".", ".", "2", "3", "5", "9"],
    [".", "4", ".", "2", "7", ".", ".", ".", "5"],
    [".", "7", "3", ".", "3", "5", ".", "4", "."],
    ["9", ".", ".", ".", ".", "8", ".", "3", "."]
]
isValidSudoku(invalidRowSudoku)

let invalidColSudoku: [[Character]] = [
    [".", "3", ".", "1", ".", ".", ".", ".", "6"],
    [".", "6", ".", "3", "9", ".", ".", "1", "."],
    ["4", ".", ".", ".", "2", "6", ".", "7", "."],
    ["5", "9", "1", "6", ".", ".", "4", ".", "."],
    [".", ".", "7", ".", "4", ".", "1", ".", "."],
    [".", ".", "4", ".", ".", "2", "3", "5", "9"],
    [".", "4", ".", "2", "7", ".", ".", ".", "5"],
    [".", "7", ".", ".", "3", "5", ".", "4", "."],
    ["9", ".", "1", ".", ".", "8", ".", "3", "."]
]
isValidSudoku(invalidColSudoku)

let invalidBoxSudoku: [[Character]] = [
    [".", "3", ".", "1", ".", ".", ".", ".", "6"],
    [".", "6", ".", "3", "9", ".", ".", "1", "."],
    ["4", ".", ".", ".", "2", "6", ".", "7", "."],
    ["5", "9", "1", "6", ".", ".", "4", ".", "."],
    [".", "5", "7", ".", "4", ".", "1", ".", "."],
    [".", ".", "4", ".", ".", "2", "3", "5", "9"],
    [".", "4", ".", "2", "7", ".", ".", ".", "5"],
    [".", "7", ".", ".", "3", "5", ".", "4", "."],
    ["9", ".", ".", ".", ".", "8", ".", "3", "."]
]
isValidSudoku(invalidBoxSudoku)

//: There are several computer algorithms that will solve most 9×9 puzzles (n=9) in fractions of a second, but combinatorial explosion
//: occurs as n increases, creating limits to the properties of Sudokus that can be constructed, analyzed, and solved as n increases.
//: ## Backtracking (depth-first) search algorithm
//: The simplest approach solving Sudoku puzzles is using a backtracking algorithm, which is a type of brute force search.
//: Backtracking is a depth-first search (in contrast to a breadth-first search), because it will completely explore one branch
//: to a possible solution before moving to another branch. Although it has been established that approximately 6.67 x 10^21 final ^
//: grids exist, a brute force algorithm can be a practical method to solve Sudoku puzzles.
//:
func solveSudoku(_ board: inout [[Character]]) -> Bool {
    
    guard isValidSudoku(board) else {
        return false
    }
    
    let n = board.count
    
    func nextEmptyField() -> (row: Int, col: Int)? {
        for i in 0..<n {
            for j in 0..<n {
                if board[i][j] == Character(".") {
                    return (i,j)
                }
            }
        }
        return nil
    }
    
    func hasValidFieldValue(_ row: Int, _ col: Int) -> Bool {
    
        var colSet = Set<Character>()
        var rowSet = Set<Character>()
        var boxSet = Set<Character>()
        
        let rowIdx = 3*(row/3)
        let colIdx = 3*(col/3)
        
        for j in 0..<n {
            if board[row][j] != Character(".") && !rowSet.insert(board[row][j]).inserted {
                return false
            }
            if board[j][col] != Character(".") && !colSet.insert(board[j][col]).inserted {
                return false
            }
            if board[rowIdx + j/3][colIdx + j%3] != Character(".") && !boxSet.insert(board[rowIdx + j/3][colIdx + j%3]).inserted {
                return false
            }
        }
        return true
    }
    
    func solveSudoku() -> Bool {
        if let idx = nextEmptyField() {
            var value = 0
            repeat {
                value += 1
                board[idx.row][idx.col] = Character(String(value))
                if hasValidFieldValue(idx.row, idx.col) && solveSudoku() {
                    return true
                }
            } while value < n
            board[idx.row][idx.col] = Character(".")
            return false
        } else {
            return true;
        }
    }
    
    return solveSudoku();
}


var veryHardSudoku : [[Character]] = [
    [".",".",".","3","4",".",".",".","."],
    ["6",".",".",".",".","1",".","4","."],
    ["7",".","4",".",".","5","1",".","."],
    ["8",".",".",".","6",".",".","1","5"],
    [".","2",".",".",".",".","4",".","7"],
    ["5",".",".",".",".",".",".",".","3"],
    [".",".",".","9",".",".",".",".","."],
    [".",".","7",".","5","3",".",".","."],
    [".",".",".","4","1",".","5","2","."]
]

solveSudoku(&veryHardSudoku)
print(veryHardSudoku)
//: The disadvantage of this method is that the solving time may be comparatively slow compared to algorithms modeled after deductive methods.
//: Moreover a Sudoku can be constructed to work against backtracking. Assuming the solver works from top to bottom, a
//: puzzle with few clues (17), no clues in the top row, and has a solution "987654321" for the first row, would work in
//: opposition to the algorithm. Thus the program would spend significant time "counting" upward before
//: it arrives at the grid which satisfies the puzzle.

var constructedSudoku : [[Character]] = [
    [".",".",".",".",".",".",".",".","."],
    [".",".",".",".",".","3",".","8","5"],
    [".",".","1",".","2",".",".",".","."],
    [".",".",".","5",".","7",".",".","."],
    [".",".","4",".",".",".","1",".","."],
    [".","9",".",".",".",".",".",".","."],
    ["5",".",".",".",".",".",".","7","3"],
    [".",".","2",".","1",".",".",".","."],
    [".",".",".",".","4",".",".",".","9"]
]
solveSudoku(&constructedSudoku)
print(constructedSudoku)

//: ## Stochastic algorithms
//: Sudoku can be solved using stochastic (random-based) algorithms. The primary motivation behind using these
//: techniques is that difficult puzzles can be solved as efficiently as simple puzzles.
//: This is due to the fact that the solution space is searched stochastically until a suitable solution is found.
//: Hence, the puzzle does not have to be logically solvable or easy for a solution to be reached efficiently.
//:
//: An example of this method is to:
//: 1. Randomly assign numbers to the blank cells in the grid.
//: 2. Calculate the number of errors.
//: 3. "Shuffle" the inserted numbers until the number of mistakes is reduced to zero.



