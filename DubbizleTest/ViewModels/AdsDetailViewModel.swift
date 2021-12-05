//
//  AdsDetailViewModel.swift
//  DubbizleTest
//
//  Created by Sajjeel Hussain Khilji on 04/12/2021.
//

import Foundation

@objc class AdsDetailViewModel : NSObject {
    var adsEntity : AdEntity
    
    init(adsEntity: AdEntity) {
        self.adsEntity = adsEntity
        super.init()
    }
    
    func getName()-> String {
        return adsEntity.name
    }
    
    func getPrice()-> String {
        return adsEntity.price
    }
    
    func getThumbnailUrl()-> String {
        if let thumbnailUrl = adsEntity.thumbnailsUrls.first {
            return thumbnailUrl
        }
        return ""
    }
    
    func getImageUrl()-> String {
        if let imageUrl = adsEntity.ImageUrls.first {
            return imageUrl
        }
        return ""
    }
}
