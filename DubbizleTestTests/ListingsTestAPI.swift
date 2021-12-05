//
//  ListingsTestAPI.swift
//  DubbizleTestTests
//
//  Created by Sajjeel Hussain Khilji on 05/12/2021.
//

import XCTest
import RxSwift
import RxCocoa


@testable import DubbizleTest

class ListingsTestAPI: ListingsAPIProtocol {
    
    
    static var objects = PublishSubject<AdsListing>()
    static var lastMethodCall: String?
    
    static func reset() {
      lastMethodCall = nil
      objects = PublishSubject<AdsListing>()
    }

    
    static func getListing() -> Observable<AdsListing> {
        lastMethodCall = #function
        return objects.asObservable()
    }
}
