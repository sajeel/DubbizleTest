//
//  AdsListing.swift
//  DubbizleTest
//
//  Created by Sajjeel Hussain Khilji on 04/12/2021.
//

import Foundation

struct Pagination : Codable {
    var key : String? // no need for the coding keys
}

struct AdsListing : Codable {
   var results: [AdEntity]
    var pagination : Pagination
   
   enum CodingKeys: String, CodingKey {
       case results = "results"
       case pagination = "pagination"
   }
}
