//
//  MDAPICourse_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 16.09.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDAPICourse_Tests: XCTestCase {
    
    fileprivate var apiCourse: MDAPICourseProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let requestDispatcher: MDRequestDispatcherProtocol = MDConstants.RequestDispatcher.defaultRequestDispatcher(reachability: .init())
        
        self.apiCourse = MDAPICourse.init(requestDispatcher: requestDispatcher,
                                          operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.courseAPIOperationQueue)!)
        
    }
    
}

extension MDAPICourse_Tests {
    
    func test_Get_Courses() {
        
        let expectation = XCTestExpectation(description: "Get Courses Expectation")
        
        
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
}
