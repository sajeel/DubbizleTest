//
//  AdEntityTests.swift
//  DubbizleTestTests
//
//  Created by Sajjeel Hussain Khilji on 05/12/2021.
//

import XCTest
@testable import DubbizleTest

class AdEntityTests: XCTestCase {
    
    func testJSONDecodingAndMapping() throws {
        let bundle = Bundle(for: type(of: self))

        guard let url = bundle.url(forResource: "AdEntity", withExtension: "json") else {
            XCTFail("Missing file: AdEntity.json")
            return
        }

        let jsonData = try Data(contentsOf: url)
        let ad: AdEntity  = try JSONDecoder().decode(AdEntity.self, from: jsonData)
        
        XCTAssertEqual(ad.creationTimeStamp, "2019-02-24 04:04:17.566515")
        XCTAssertEqual(ad.price, "AED 5")
        XCTAssertEqual(ad.name, "Notebook")
        XCTAssertEqual(ad.uid, "4878bf592579410fba52941d00b62f94")
    }
}

