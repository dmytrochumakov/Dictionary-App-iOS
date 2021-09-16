//
//  MDAPIJWT_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 16.09.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDAPIJWT_Tests: XCTestCase {
        
    fileprivate var apiJWT: MDAPIJWTProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let requestDispatcher: MDRequestDispatcherProtocol = MDConstants.RequestDispatcher.defaultRequestDispatcher(reachability: try! .init())
        
        let operationQueue: OperationQueue = .init()
        
        let operationQueueService: OperationQueueServiceProtocol = OperationQueueService.init(operationQueue: operationQueue)
                
        self.apiJWT = MDAPIJWT.init(requestDispatcher: requestDispatcher,
                                    operationQueueService: operationQueueService)
        
    }
    
}

extension MDAPIJWT_Tests {
    
    func test_Get_Access_Token() {
        
        let expectation = XCTestExpectation(description: "Get Access Token Expectation")
        
        apiJWT.accessToken(jwtApiRequest: Constants_For_Tests.jwtApiRequest) { result in
            
            switch result {
            
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
