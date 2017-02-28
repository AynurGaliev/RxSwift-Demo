//
//  BooksModel.swift
//  RxSwift-Demo
//
//  Created by Aynur Galiev on 28.02.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import UIKit
import RxSwift

var books: [Book] = Book.generateRandomBooks(count: 100)

protocol IBooksModel: class {
    var booksPresenter: IBooksPresenter! { get set }
    var booksObservable: Observable<[Book]>! { get }
    func setupBooksObservable(searchText: Observable<String?>, pagination: Observable<Bool>)
}

final class BooksModel {
    
    var booksPresenter: IBooksPresenter!
    var booksService: IBooksService!
    
    //MARK: - Books
    private(set) var fetchedBooks: [Book] = []
    private(set) var filteredBooks: [Book] = []

    //MARK: - Observables
    private var searchText: Observable<String?>!
    private var pagination: Observable<Bool>!
    private var isSearchActive: Bool = false
    
    var booksObservable: Observable<[Book]>!
    
    func setupBooksObservable(searchText: Observable<String?>, pagination: Observable<Bool>) {
        self.searchText = searchText
        self.pagination = pagination
        self.booksObservable = Observable.combineLatest(pagination, searchText) { (isBeforeValue: Bool, text: String?) -> [Book] in
            self.isSearchActive = (text != nil)
            return []
        }
    }
    
    func book(at index: Int) -> Book? {
        guard index > 0 && index < books.count else { return nil }
        return books[index]
    }
    
    var booksCount: Int {
        return books.count
    }
}

extension BooksModel: IBooksModel {
    
}
