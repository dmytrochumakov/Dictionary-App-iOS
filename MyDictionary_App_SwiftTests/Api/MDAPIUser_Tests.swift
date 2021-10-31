//
//  MDAPIUser_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 16.09.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDAPIUser_Tests: XCTestCase {
    
    fileprivate var apiUser: MDAPIUserProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let requestDispatcher: MDRequestDispatcherProtocol = MDConstants.RequestDispatcher.defaultRequestDispatcher(reachability: .init())
        
        self.apiUser = MDAPIUser.init(requestDispatcher: requestDispatcher,
                                      operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.userAPIOperationQueue)!)
                
    }
    
}

extension MDAPIUser_Tests {
    
    func test_Get_User() {
        
        let expectation = XCTestExpectation(description: "Get User Expectation")
               
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
}

