//
//  LibraryOfbabel.swift
//  LibraryOfBabel
//
//  Created by Вавилов Илья on 21/2/26.
//

import Foundation

class BabylonEngine {
    let alphabet = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя, ."
    let linesPerPage = 40
    let charsPerLine = 40
    let totalPagesInBook = 410
    
    private var cache: [String: String] = [:]
    
    func generatePageText(room: String, wall: String, shelf: String, book: String, page: Int) -> String {
        let addressKey = "R\(room)W\(wall)S\(shelf)B\(book)P\(page)"
        
        if let cachedText = cache[addressKey] {
            return cachedText
        }
        
        // Генерация уникального сида из адреса
        var seed: UInt64 = 5381
        for char in addressKey.utf8 {
            seed = ((seed << 5) &+ seed) &+ UInt64(char)
        }
        
        var generator = LinearCongruentialGenerator(seed: seed)
        var result = ""
        let totalChars = linesPerPage * charsPerLine
        
        for _ in 0..<totalChars {
            let index = Int(generator.next() % UInt64(alphabet.count))
            let char = alphabet[alphabet.index(alphabet.startIndex, offsetBy: index)]
            result.append(char)
        }
        
        cache[addressKey] = result
        return result
    }
}

struct LinearCongruentialGenerator {
    var seed: UInt64
    mutating func next() -> UInt64 {
        seed = (seed &* 6364136223846793005 &+ 1)
        return seed
    }
}
