//
//  MDAPIWord_Tests.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.09.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDAPIWord_Tests: XCTestCase {
    
    fileprivate var apiWord: MDAPIWordProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let requestDispatcher: MDRequestDispatcherProtocol = MDConstants.RequestDispatcher.defaultRequestDispatcher(reachability: .init())
        
        self.apiWord = MDAPIWord.init(requestDispatcher: requestDispatcher,
                                      operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.wordAPIOperationQueue)!)
                
    }
    
}

extension MDAPIWord_Tests {
    
    func test_Get_Words() {
        
        let expectation = XCTestExpectation(description: "Get Words Expectation")
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
}

