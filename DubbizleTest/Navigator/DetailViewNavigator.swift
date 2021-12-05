//
//  DetailViewNavigator.swift
//  DubbizleTest
//
//  Created by Sajjeel Hussain Khilji on 04/12/2021.
//

import Foundation
import UIKit

@objc class DetailViewNavigator : NSObject, Navigator {
    var childNavigators = [Navigator]()
    
    weak var parentNavigator: MainNavigator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
