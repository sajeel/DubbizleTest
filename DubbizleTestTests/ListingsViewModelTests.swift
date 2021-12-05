//
//  ListingsViewModelTests.swift
//  DubbizleTestTests
//
//  Created by Sajjeel Hussain Khilji on 05/12/2021.
//

import XCTest
import RxSwift
import RxCocoa
import RxBlocking


@testable import DubbizleTest
class ListingsViewModelTests: XCTestCase {
    
   
    
    func test_whenInitialized_storesInitParams() {
        let viewModel = createListingsViewModel()
        
        XCTAssertNotNil(viewModel.ads)
        //XCTAssertEqual(viewModel.paused, BehaviorRelay.init(value: false))
        XCTAssertNotNil(viewModel.apiType)
    }
    
    func test_FetchesListings() {
        ListingsTestAPI.reset()
        let viewModel = createListingsViewModel()
        XCTAssertNil(viewModel.ads.value, "ads is not nil by default")
        
        DispatchQueue.main.async {
            let adsListing = getAdsListing()
//            viewModel.paused.accept(false)
            ListingsTestAPI.objects.onNext(adsListing!)
            //viewModel.ads.accept(adsListing?.results)
            let emitted = try! viewModel.ads.asObservable().take(1).toBlocking(timeout: 1).toArray()
            XCTAssertNil(emitted[0])
            XCTAssertEqual(emitted[0]![1].uid, "bdf455e89f3b49f484d2a181b0268eab")
            XCTAssertEqual(ListingsTestAPI.lastMethodCall, "getListing()")
        }
        
       
    }
    
    
    
    
    
    
}
