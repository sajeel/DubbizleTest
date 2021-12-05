//
//  Navigator.swift
//  DubbizleTest
//
//  Created by Sajjeel Hussain Khilji on 04/12/2021.
//

import Foundation
import UIKit

@objc protocol Navigator : NSObjectProtocol {
    var childNavigators: [Navigator] { get set }
    var navigationController: UINavigationController { get set }
}
