//
//  Book.swift
//  RxSwift-Demo
//
//  Created by Aynur Galiev on 28.02.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import Foundation

struct Book {
    
    var name: String
    
    static func generateRandomBooks(count: Int, length: Int = 20) -> [Book] {
        
        func randomString(length: Int) -> String {
            let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let len = UInt32(letters.length)
            
            var randomString = ""
            
            for _ in 0 ..< length {
                let rand = arc4random_uniform(len)
                var nextChar = letters.character(at: Int(rand))
                randomString += NSString(characters: &nextChar, length: 1) as String
            }
            
            return randomString
        }
        
        var books: [Book] = []
        
        for _ in 0..<count {
            let book = Book(name: randomString(length: length))
            books.append(book)
        }
        
        return books
    }
}
