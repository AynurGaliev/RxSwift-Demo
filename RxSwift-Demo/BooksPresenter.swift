//
//  BooksPresenter.swift
//  RxSwift-Demo
//
//  Created by Aynur Galiev on 28.02.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import UIKit
import RxSwift

protocol IBooksPresenter: UITableViewDataSource {
    var booksView : IBooksView! { get set }
    var booksModel: IBooksModel! { get set }
    func isCellLast(row: Int) -> Bool
    var searchText: Observable<String?> { get set }
    var isPullToRefresh: Observable<Bool> { get set }
}

final class BooksPresenter: NSObject {

    weak var booksView : IBooksView!
    weak var booksModel: IBooksModel!
    private var booksSubscription: Disposable!
    
    private var booksDisposable: Disposable! 
    
    override init() {
        super.init()
        self.booksModel.setupBooksObservable(searchText: self.booksView.searchText, pagination: self.booksView.pagination)
        self.booksSubscription = self.booksModel.booksObservable.subscribe { (event: Event<[Book]>) in
            
        }
    }
    
    deinit {
        self.booksSubscription?.dispose()
    }
}

extension BooksPresenter: IBooksPresenter {
    
    func isCellLast(row: Int) -> Bool {
        return row == self.booksModel
    }
    
    func search(with text: String) {
        
    }
    
    func cancelSearch() {
        
    }
}

extension BooksPresenter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.booksModel.fetchedBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell")!
        cell.textLabel?.text = self.booksModel.fetchedBooks[indexPath.row].name
        return cell
    }
}
