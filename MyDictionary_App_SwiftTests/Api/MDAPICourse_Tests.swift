//
//  MDAPICourse_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 16.09.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDAPICourse_Tests: XCTestCase {
    
    fileprivate var apiJWT: MDAPIJWTProtocol!
    fileprivate var apiCourse: MDAPICourseProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let requestDispatcher: MDRequestDispatcherProtocol = MDConstants.RequestDispatcher.defaultRequestDispatcher(reachability: try! .init())
        
        self.apiCourse = MDAPICourse.init(requestDispatcher: requestDispatcher,
                                          operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.courseAPIOperationQueue)!)
        
        self.apiJWT = MDAPIJWT.init(requestDispatcher: requestDispatcher,
                                    operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.jwtAPIOperationQueue)!)
        
    }
    
}

extension MDAPICourse_Tests {
    
    func test_Get_Courses() {
        
        let expectation = XCTestExpectation(description: "Get Courses Expectation")
        
        apiJWT.accessToken(jwtApiRequest: Constants_For_Tests.jwtApiRequest) { [unowned self] jwtResult in
            
            switch jwtResult {
                
            case .success(let jwtResponse):
                
                apiCourse.getCourses(accessToken: jwtResponse.accessToken,
                                     byUserId: Constants_For_Tests.jwtApiRequest.userId) { courseResult in
                    
                    switch courseResult {
                        
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
