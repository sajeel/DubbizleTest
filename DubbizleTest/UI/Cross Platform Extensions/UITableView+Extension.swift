//
//  UITableView+Extension.swift
//  DubbizleTest
//
//  Created by Sajjeel Hussain Khilji on 05/12/2021.
//

import Foundation
import UIKit

extension UITableView {
    
    func assignProtocols(to output: TableViewOutput) {
        delegate = output
        dataSource = output
    }
    
    func registerCell<T: UITableViewCell>(cellType: T.Type) {
        register(cellType, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath, type: T.Type) -> T {
        let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as! T
        return cell
    }
}
