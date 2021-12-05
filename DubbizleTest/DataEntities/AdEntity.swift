//
//  AdEntity.swift
//  DubbizleTest
//
//  Created by Sajjeel Hussain Khilji on 04/12/2021.
//

import Foundation

@objc class AdEntity : NSObject, Codable {
    @objc var price : String
    @objc var name : String
    @objc var ImageUrls: [String]
    var creationTimeStamp: String
    var uid: String
    var imageIds: [String]
    
    var thumbnailsUrls : [String]
    
    enum CodingKeys: String, CodingKey {
        case creationTimeStamp = "created_at"
        case price = "price"
        case name = "name"
        case uid = "uid"
        case imageIds = "image_ids"
        case ImageUrls = "image_urls"
        case thumbnailsUrls = "image_urls_thumbnails"
    }
}
