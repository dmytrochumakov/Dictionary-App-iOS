//
//  Constants_For_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 17.07.2021.
//

import XCTest
import CoreData
@testable import MyDictionary_App_Swift

struct Constants_For_Tests {
    
    public static let testExpectationTimeout: TimeInterval = 60.0
    
    
    // Course
    public static let mockedCourseUUID: UUID = .init()
    public static let mockedCourseLanguageId: Int16 = 1
    public static let mockedCourseCreatedAt: Date = .init()
    
    // Course For Course Manager
    public static let mockedCourseManagerUUID: UUID = .init()
    public static let mockedCourseManagerLanguageId: Int16 = 2
    public static let mockedCourseManagerCreatedAt: Date = .init()
    
    
    // Word
    public static let mockedWordCourseUUID: UUID = .init()
    public static let mockedWordUUID: UUID = .init()
    public static let mockedWordText: String = "MOSF"
    public static let mockedWordDescription: String = "metal–oxide–semiconductor-field"
    public static let mockedWordCreatedAt: Date = .init()
    
    // Word For Course Manager    
    public static let mockedCourseManagerWordUUID: UUID = .init()
    public static let mockedCourseManagerWordText: String = "Hello World"
    public static let mockedCourseManagerWordDescription: String = "Hello World Description"
    public static let mockedCourseManagerWordCreatedAt: Date = .init()
    
    
    // Word For Update
    public static let mockedWordForUpdateText: String = "MOSFC"
    public static let mockedWordForUpdateDescription: String = "metal–oxide–semiconductor-field-c"    
    
}
