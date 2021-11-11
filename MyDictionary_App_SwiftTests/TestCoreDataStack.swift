//
//  TestCoreDataStack.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import XCTest
import CoreData
@testable import MyDictionary_App_Swift

final class TestCoreDataStack: MDCoreDataStack {
    
    init() {
        super.init(coreDataManager: MDConstants.AppDependencies.dependencies.coreDataManager)          
    }
    
}
