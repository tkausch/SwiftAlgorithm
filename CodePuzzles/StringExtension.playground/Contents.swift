//: Playground - noun: a place where people can play

import UIKit

extension String {
    
    var count: Int {
        get {
            return self.characters.count
        }
    }
    
    func reversed() -> String {
        return String(self.characters.reversed())
    }
    
    func contains(s: String) -> Bool {
        return self.range(of: s) == nil ? true: false
    }
    
    func replace(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString)
    }
    
    subscript (i: Int) -> Character {
        get {
            let index = self.index(self.startIndex, offsetBy: i)
            return self[index]
        }
    }
    
    subscript (r: Range<Int>) -> String {
        get {
            let start: String.Index = self.index(self.startIndex, offsetBy: r.lowerBound)
            let end: String.Index = self.index(self.startIndex, offsetBy: r.upperBound)
            return self.substring(with: start..<end)
        }
    }
    
    func indexOf(target: String, fromIndex: Int = 0) -> Int {
        let start = self.index(self.startIndex, offsetBy: fromIndex)
        if let range = self.range(of: target, range: start..<self.endIndex, locale: nil) {
            return self.distance(from: self.startIndex, to: range.lowerBound)
        } else {
            return -1
        }
    }
    
    func lastIndexOf(target: String, fromIndex: Int = 0) -> Int {
        let start = self.index(self.startIndex, offsetBy: fromIndex)
        if let range = self.range(of: target, options: .backwards, range: start..<self.endIndex, locale: nil) {
            return self.distance(from: self.startIndex, to: range.lowerBound)
        } else {
            return -1
        }
    }
    
}

"Awsome".count == 6

"Awesome".contains("me") == true
"Awesome".contains("Aw") == true
"Awesome".contains("so") == true
"Awesome".contains("Dude") == false

"ReplaceMeMe".replace(target: "Me", withString: "You") == "ReplaceYouYou"
"MeReplace".replace(target: "Me", withString: "You") == "YouReplace"
"ReplaceMeNow".replace(target: "Me", withString: "You") == "ReplaceYouNow"

"0123456789"[0] == "0"
"0123456789"[5] == "5"
"0123456789"[9] == "9"

"0123456789"[0] == "0"
"0123456789"[5] == "5"
"0123456789"[9] == "9"

"0123456789"[5..<6] == "5"
"0123456789"[0..<1] == "0"
"0123456789"[8..<9] == "8"
"0123456789"[1..<5] == "1234"
"0123456789"[0..<10] == "0123456789"

"Awesome".indexOf(target:"nothin") == -1
"Awesome".indexOf(target:"Awe") == 0
"Awesome".indexOf(target:"some") == 3

"Awesome".indexOf(target:"e", fromIndex: 3) == 6

"BananaBanana".lastIndexOf(target: "na") == 10
"BananaBanana".lastIndexOf(target: "Banana", fromIndex: 6) == 6
"BananaBanana".lastIndexOf(target: "Banana", fromIndex: 7) == -1



