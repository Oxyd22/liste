//
//  AufteilenTests.swift
//  AufteilenTests
//
//  Created by Jesaja on 11.11.17.
//  Copyright © 2017 ddd. All rights reserved.
//

import XCTest
@testable import Aufteilen

class CurrencyFormaterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testgetCurrencyString() {
        let expectedResult = "$3.40"
        let restult = CurrencyFormater.getCurrencyString(number: 3.4)
        XCTAssertEqual(expectedResult, restult)
    }
    
    func testgetDoubleValue() {
        let expectedResult = 5.3
        let restult = CurrencyFormater.getDoubleValue(currencyString: "$5.30")
        XCTAssertEqual(expectedResult, restult)
    }
    
    func testgetPercentString() {
        let expectedResult = "30%"
        let restult = CurrencyFormater.getPercentString(number: 0.3)
        XCTAssertEqual(expectedResult, restult)
    }
}
