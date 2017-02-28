//
//  BooksService.swift
//  RxSwift-Demo
//
//  Created by Aynur Galiev on 28.02.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import Foundation
import RxSwift

protocol IBooksService: class {
    func fetchBooks(count: Int, offset: Int, isBefore: Bool, text: String?) -> Observable<[Book]>
    func loadBooks() -> Observable<[Book]>
}


final class BooksService: IBooksService {

    func fetchBooks(count: Int, offset: Int, isBefore: Bool, text: String?) -> Observable<[Book]> {
        let delay = Double(arc4random_uniform(10)/10)
        //let seconds = Int(delay * 100)
        let fetchedBooks = Array(books[offset..<offset + count])
        return Observable.just(fetchedBooks).delay(delay, scheduler: MainScheduler.instance)
    }
    
    func loadBooks() -> Observable<[Book]> {
        return Observable.just(books)
    }
}
