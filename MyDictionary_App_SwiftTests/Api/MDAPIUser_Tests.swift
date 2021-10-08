//
//  MDAPIUser_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 16.09.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDAPIUser_Tests: XCTestCase {
    
    fileprivate var apiJWT: MDAPIJWTProtocol!
    fileprivate var apiUser: MDAPIUserProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let requestDispatcher: MDRequestDispatcherProtocol = MDConstants.RequestDispatcher.defaultRequestDispatcher(reachability: .init())
        
        self.apiUser = MDAPIUser.init(requestDispatcher: requestDispatcher,
                                      operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.userAPIOperationQueue)!)
        
        self.apiJWT = MDAPIJWT.init(requestDispatcher: requestDispatcher,
                                    operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.jwtAPIOperationQueue)!)
        
    }
    
}

extension MDAPIUser_Tests {
    
    func test_Get_User() {
        
        let expectation = XCTestExpectation(description: "Get User Expectation")
        
        apiJWT.accessToken(jwtApiRequest: Constants_For_Tests.jwtApiRequest) { [unowned self] jwtResult in
            
            switch jwtResult {
                
            case .success(let jwtResponse):
                
                apiUser.getUser(accessToken: jwtResponse.accessToken,
                                byUserId: Constants_For_Tests.jwtApiRequest.userId) { userResult in
                    
                    switch userResult {
                        
                    case .success:
                        
                        expectation.fulfill()
                        
                    case .failure(let error):
                        XCTExpectFailure(error.localizedDescription)
                        expectation.fulfill()
                    }
                    
                }
                
                
            case .failure(let error):
                XCTExpectFailure(error.localizedDescription)
                expectation.fulfill()
            }
            
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
}

