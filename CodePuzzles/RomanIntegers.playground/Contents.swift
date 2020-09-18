//: # Integer to Roman
//: **Question:** Given an integer, convert it to a roman numeral.
let romanNumbers = [(1000, "M"), (900, "CM"), (500, "D"), (400, "CD"), (100,"C"), (90,"XC"), (50, "L"), (40, "XL"), (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")]

func intToRoman(_ num: Int) -> String {
    var number = num
    var result = ""
    var idx = 0
    while number > 0 {
        if number - romanNumbers[idx].0 >= 0 {
            result += romanNumbers[idx].1
            number -= romanNumbers[idx].0
        } else {
            idx += 1
        }
    }
    return result
}

intToRoman(2017)
intToRoman(9)
intToRoman(549)
//: # Roman to Integer
//: **Question:** Given an roman number, convert it to an integer.
func romanToInt(_ roman: String) -> Int {
    var current = roman[roman.startIndex..<roman.endIndex]
    var idx = 0
    var number = 0
    while !current.isEmpty {
        let (delta, prefix) = romanNumbers[idx]
        while current.starts(with: prefix)  {
            number += delta
            current = current.dropFirst(prefix.count)
        }
        idx += 1
    }
    return number
}
//: We can do this even with a better runtime.
func value(char: Character) -> Int {
    switch char {
    case "M":
        return 1000
    case "D":
         return 500
    case "C":
        return 100
    case "L":
        return 50
    case "X":
        return 10
    case "V":
        return 5
    case "I":
        return 1
    default:
        return -1
    }
}

func romanToInt2(_ roman: String) -> Int {
    var result = 0
    var next = roman.startIndex
    while next != roman.endIndex {
        let valueNext = value(char: roman[next])
        let next2 = roman.index(after: next)
        if next2 != roman.endIndex {
            let valueNext2 = value(char: roman[next2])
            if valueNext >= valueNext2 {
                result += valueNext
                next = next2
            } else {
                result +=  valueNext2 - valueNext
                next = roman.index(after: next2)
            }
        } else {
            result += valueNext
            next = next2
        }
    }
    return result
}


romanToInt2("DXL")
romanToInt2("DXLIX")
