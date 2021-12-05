//
//  ListingAPITests.swift
//  DubbizleTestTests
//
//  Created by Sajjeel Hussain Khilji on 05/12/2021.
//

import XCTest
import RxSwift
@testable import DubbizleTest


class ListingAPITests: XCTestCase {
    var sut: ListingsAPI!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ListingsAPI()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    // Asynchronous test: success fast, failure slow
    func testValidApiCallGetsHTTPStatusCode200() throws {
        // 1
        let promise = expectation(description: "Status code: 200")
        
        // when
        let observable : Observable<AdsListing> = ListingsAPI.request(address: ListingsAPI.Address.adsListings)
        _ = observable.subscribe { sdsListing in
            promise.fulfill()
        } onError: { error in
            XCTFail("Status code: \(error.localizedDescription)")
            XCTAssertNil(error)
        } onCompleted: {
            
        } onDisposed: {
            
        }
        // 3
        wait(for: [promise], timeout: 10)
    }
    
    
    func testInValidApiCallGetsError() throws {
        // given 1
        let promise = expectation(description: "Error invalid url ")
        
        // when
        let observable : Observable<AdsListing> = ListingsAPI.request(address: MockAddesses.invalidAdsListings)
        _ = observable.subscribe { sdsListing in
        } onError: { error in
            promise.fulfill()
            XCTAssertNotNil(error)
            
        } onCompleted: {
            
        } onDisposed: {
            
        }
        // 3
        wait(for: [promise], timeout: 60)
    }
    
}

enum MockAddesses :  String , AddressProtocol {
    case invalidAdsListings = "default/dynamodb"
    
    func getBaseUrlString() -> String {
        return "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com/"
    }
    func getUrl() -> URL {
        return URL(string: getBaseUrlString().appending(rawValue))!
    }
}

