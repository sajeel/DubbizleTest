//
//  CollectionView+.swift
//  Wain
//
//  Created by Sajjeel Khilji on 7/18/19.
//  Copyright © 2019 QMIC. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func dequeueCell<T>(ofType type: T.Type, indexPath : IndexPath) -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
    }
}


