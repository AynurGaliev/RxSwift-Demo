//
//  Extensions.swift
//  RxSwift-Demo
//
//  Created by Aynur Galiev on 28.02.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import UIKit

protocol TableViewDelegate: UITableViewDelegate, UITableViewDataSource { }

extension UITableView {
    
    func setDelegate(delegate: TableViewDelegate) {
        self.delegate = delegate
        self.dataSource = delegate
    }
}

extension String {
    
    var empty: String {
        return ""
    }
}
