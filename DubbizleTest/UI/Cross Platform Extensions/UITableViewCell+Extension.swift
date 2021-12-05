//
//  UITableViewCell+Extension.swift
//  DubbizleTest
//
//  Created by Sajjeel Hussain Khilji on 05/12/2021.
//

import Foundation
import UIKit

protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? String(describing: Mirror(reflecting: self).subjectType)
    }
}

extension UITableViewCell: ReusableView { }
