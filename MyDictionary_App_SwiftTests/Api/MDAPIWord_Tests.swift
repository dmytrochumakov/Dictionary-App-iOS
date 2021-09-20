//
//  MDAPIWord_Tests.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.09.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDAPIWord_Tests: XCTestCase {
    
    fileprivate var apiJWT: MDAPIJWTProtocol!
    fileprivate var apiWord: MDAPIWordProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let requestDispatcher: MDRequestDispatcherProtocol = MDConstants.RequestDispatcher.defaultRequestDispatcher(reachability: try! .init())
        
        let operationQueue: OperationQueue = .init()
        
        let operationQueueService: OperationQueueServiceProtocol = OperationQueueService.init(operationQueue: operationQueue)
        
        self.apiWord = MDAPIWord.init(requestDispatcher: requestDispatcher,
                                      operationQueueService: operationQueueService)
        
        self.apiJWT = MDAPIJWT.init(requestDispatcher: requestDispatcher,
                                    operationQueueService: operationQueueService)
        
    }
    
}

extension MDAPIWord_Tests {
    
    func test_Get_Words() {
        
        let expectation = XCTestExpectation(description: "Get Words Expectation")
        
        apiJWT.accessToken(jwtApiRequest: Constants_For_Tests.jwtApiRequest) { [unowned self] jwtResult in
            
            switch jwtResult {
            
            case .success(let jwtResponse):
                
                apiWord.getWords(accessToken: jwtResponse.accessToken,
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

