//: # Check if a Sudoku is Valid
//: **Question:** Given a sudoku grid, we need to verify if the already filled in numbers doesn't violate
//: the sudoku rules. The rules are very simple:
//: * Each row has numbers from 1-9 and no repitions
//: * Each column has numbers from 1-9 and no repitions
//: * Each 3x3 cube has numbers from 1-9
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


//: We can use this efficient check to implement a back tracking algorithm
//: for sudoku.

func findEmptyField(_ board:  [[Character]]) -> (row: Int, col: Int)? {
    let n = board.count
    for i in 0..<n {
        for j in 0..<n {
            if board[i][j] == Character(".") {
                return (i,j)
            }
        }
    }
    return nil
}

func solveSudoku(_ board: inout [[Character]]) -> Bool {
    if isValidSudoku(board) {
        if let idx = findEmptyField(board) {
            let n = board.count
            var value = 0
            repeat {
                value += 1
                board[idx.row][idx.col] = Character(String(value))
                if solveSudoku(&board) {
                    return true
                }
            } while value < n
            board[idx.row][idx.col] = Character(".")
        } else {
            return true
        }
    }
    return false
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
