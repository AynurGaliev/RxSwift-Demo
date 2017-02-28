//
//  ViewController.swift
//  RxSwift-Demo
//
//  Created by Aynur Galiev on 12.12.16.
//  Copyright © 2016 Aynur Galiev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol IBooksView: class {
    var presenter: IBooksPresenter! { get set }
    func showError(with message: String)
    func updateBooksList()
    
    //Rx
    var searchText: Observable<String?> { get }
    var pagination: Observable<Bool> { get }
}

final class BooksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        self.tableView?.addSubview(refreshControl)
        return refreshControl
    }()
    
    var presenter: IBooksPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self.presenter
    }
    
    var searchText: Observable<String?> {
        return self.searchBar.rx.text.asObservable()
    }
    
    var pullToRefresh: Observable<Void> {
        return self.refreshControl.rx.controlEvent(.valueChanged).asObservable()
    }
    
    var pagination: Observable<Bool> {
        return self.tableView.rx.willDisplayCell.map { $0.indexPath.row }
    }
}

extension BooksViewController: IBooksView {

    func showError(with message: String) {
        
    }
    
    func updateBooksList() {
        self.tableView.reloadData()
    }
}

extension BooksViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard self.presenter.isCellLast(row: indexPath.row) else { return }
        self.presenter.loadNextPage()
    }
    
}

extension BooksViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self
    }
}
