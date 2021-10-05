//
//  MDAPIAuth_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 16.09.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDAPIAuth_Tests: XCTestCase {
    
    fileprivate var apiAuth: MDAPIAuthProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let requestDispatcher: MDRequestDispatcherProtocol = MDConstants.RequestDispatcher.defaultRequestDispatcher(reachability: try! .init())
        
        self.apiAuth = MDAPIAuth.init(requestDispatcher: requestDispatcher,
                                      operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.authAPIOperationQueue)!)
        
    }
    
}

extension MDAPIAuth_Tests {
    
    func test_Login() {
        
        let expectation = XCTestExpectation(description: "Login Expectation")
        
        apiAuth.login(authRequest: Constants_For_Tests.authRequest) { authResult in
            
            switch authResult {
                
            case .success:
                
                expectation.fulfill()
                
            case .failure(let error):
                XCTExpectFailure(error.localizedDescription)
                expectation.fulfill()
            }
            
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
}
