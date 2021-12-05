//
//  AdCellViewModel.swift
//  DubbizleTest
//
//  Created by Sajjeel Hussain Khilji on 05/12/2021.
//

import Foundation

struct AdCellViewModel {
    var name : String
    var price : String
    var thumbnailUrl : String
    var adEntity: AdEntity
    
    init(adEntity: AdEntity){
        self.adEntity = adEntity
        name = adEntity.name
        price = adEntity.price
        thumbnailUrl = ""
        if self.isThumbnailUrlExists() {
            self.thumbnailUrl = getThumbnailUrl()
        }
    }
    
    
    func isThumbnailUrlExists() -> Bool{
        if adEntity.thumbnailsUrls.first != nil {
            return true
        }
        return false
    }
    
    func getThumbnailUrl() -> String {
        if let thumbnailUrl = adEntity.thumbnailsUrls.first {
            return thumbnailUrl
        }
        return ""
    }
    
    
}
