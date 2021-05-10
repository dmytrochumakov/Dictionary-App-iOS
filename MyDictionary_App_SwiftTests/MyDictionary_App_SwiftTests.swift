//
//  MyDictionary_App_SwiftTests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 10.05.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

class MyDictionary_App_SwiftTests: XCTestCase {
    
    func testConversionForTwo() {
        let result = "converter.convert(2)"
        XCTAssertEqual(result, "II", "Conversion for 2 is incorrect")
    }
    
}
