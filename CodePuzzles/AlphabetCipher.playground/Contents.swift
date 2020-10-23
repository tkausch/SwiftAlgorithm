import UIKit

typealias CodeMap = [Character : Character]


class AlphabetCipher {
    
    var key: String
    
    static var matrix = [Character : CodeMap]()

    static var alphabet = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ");

    lazy var encryptionMaps : [CodeMap] = {
        return  pickCodeMaps(key: key)
    }()
    
    lazy var decryptionMaps: [CodeMap] = {
        return pickCodeMaps(key: key, invert: true)
    }()
    
    init(key: String) {
        
        // initialize class property matrix - if not yet done.
        if Self.matrix.isEmpty {
            for (shift, char) in Self.alphabet.enumerated() {
                // create codemap by shifting alphabet
                var codemap = [Character : Character]()
                for (idx, ch) in Self.alphabet.enumerated() {
                    codemap[ch] = Self.alphabet[(idx + shift) % Self.alphabet.count]
                }
                Self.matrix[char] = codemap
            }
        }
        
        self.key = key
        
    }
    
    func encrypt(_ plaintText: String) -> String {
       return substitute(text: plaintText, codeMaps: encryptionMaps)
    }
    
    func decrypt(_ cipherText: String) -> String {
        return substitute(text: cipherText, codeMaps: decryptionMaps)
    }
    
    func substitute(text: String, codeMaps: [CodeMap]) -> String {
        var current = 0
        let mappedText = text.map { (char) -> Character in
            if let ch = codeMaps[current][char] {
                current = (current + 1) % codeMaps.count
                return ch
            }
            return char
        }
        return String(mappedText)
    }
    
    func pickCodeMaps(key: String, invert: Bool = false) -> [CodeMap] {
        var codeMaps = [CodeMap]()
        for ch in key {
            if let codeMap = Self.matrix[ch] {
                if invert {
                    codeMaps.append(inverse(codeMap))
                } else {
                    codeMaps.append(codeMap)
                }
            } else {
                assertionFailure("Only ASCII characters supported in encoding key")
            }
        }
        return codeMaps
    }
    
    func inverse(_ codeMap: CodeMap) -> CodeMap {
        var inverseMap = CodeMap()
        for key in codeMap.keys {
            if let mappedKey = codeMap[key] {
                inverseMap[mappedKey] = key
            }
        }
        return inverseMap
    }
    
}

var cipher = AlphabetCipher(key: "vigilance")

let cipherText = cipher.encrypt("meet me😀 at tuesday evening 🎯at seven")
let plainText = cipher.decrypt(cipherText)

print(cipherText)
print(plainText)




