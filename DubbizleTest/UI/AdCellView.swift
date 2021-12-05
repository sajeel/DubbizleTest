//
//  AdCellView.swift
//  DubbizleTest
//
//  Created by Sajjeel Hussain Khilji on 04/12/2021.
//

import Foundation
import UIKit

class AdCellView: UITableViewCell {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var message: UITextView!
    
    func update(with adCellViewModel: AdCellViewModel) {
        name.text = adCellViewModel.name
        message.text = adCellViewModel.price
        if adCellViewModel.isThumbnailUrlExists() {
            photo.setImage(with: URL(string: adCellViewModel.getThumbnailUrl()))
        }
    }
}
