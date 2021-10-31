//
//  MDAPILanguage_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 16.09.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDAPILanguage_Tests: XCTestCase {
        
    fileprivate var apiLanguage: MDAPILanguageProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let requestDispatcher: MDRequestDispatcherProtocol = MDConstants.RequestDispatcher.defaultRequestDispatcher(reachability: .init())
        
        self.apiLanguage = MDAPILanguage.init(requestDispatcher: requestDispatcher,
                                              operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.languageAPIOperationQueue)!)
                
    }
    
}

extension MDAPILanguage_Tests {
    
    func test_Get_Languages() {
        
        let expectation = XCTestExpectation(description: "Get Languages Expectation")
               
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
}

