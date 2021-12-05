//
//  Helpers.swift
//  DubbizleTestTests
//
//  Created by Sajjeel Hussain Khilji on 05/12/2021.
//

import Foundation
@testable import DubbizleTest


func getAdsListing() -> AdsListing? {
    let bundle = Bundle(for: ListingViewControllerTests.self)
    
    guard let url = bundle.url(forResource: "AdsListing", withExtension: "json") else {
        //XCTFail("Missing file: AdsListing.json")
        return nil
    }
    let jsonData = try! Data(contentsOf: url)
    let adsListing: AdsListing  = try! JSONDecoder().decode(AdsListing.self, from: jsonData)
    return adsListing
}


func createListingsViewModel() -> ListingsViewModel {
    return ListingsViewModel(apiType: ListingsTestAPI.self)
}
