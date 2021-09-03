//
//  MDJWTMemoryStorage_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDJWTMemoryStorage_Tests: XCTestCase {
    
    fileprivate var jwtMemoryStorage: MDJWTMemoryStorageProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let operationQueue: OperationQueue = .init()
        let operationQueueService: OperationQueueServiceProtocol = OperationQueueService.init(operationQueue: operationQueue)
        
        let jwtMemoryStorage: MDJWTMemoryStorageProtocol = MDJWTMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                   array: .init())
        
        self.jwtMemoryStorage = jwtMemoryStorage
        
    }
    
}

extension MDJWTMemoryStorage_Tests {
    
    func test_Create_JWT_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create JWT Expectation")
        
        jwtMemoryStorage.createJWT(Constants_For_Tests.mockedJWT) { result in
            
            switch result {
            
            case .success(let createdJWT):
                
                XCTAssertTrue(createdJWT.accessToken == Constants_For_Tests.mockedJWT.accessToken)
                XCTAssertTrue(createdJWT.expirationDate == Constants_For_Tests.mockedJWT.expirationDate)
                expectation.fulfill()
                
            case .failure:
                XCTExpectFailure()
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Read_JWT_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read JWT Expectation")
        
        jwtMemoryStorage.createJWT(Constants_For_Tests.mockedJWT) { [unowned self] createResult in
            
            switch createResult {
            
            case .success(let createdJWT):
                
                jwtMemoryStorage.readJWT(fromAccessToken: createdJWT.accessToken) { readResult in
                    
                    switch readResult {
                    
                    case .success(let readJWT):
                        
                        XCTAssertTrue(createdJWT.accessToken == readJWT.accessToken)
                        XCTAssertTrue(createdJWT.expirationDate == readJWT.expirationDate)
                        expectation.fulfill()
                        
                    case .failure:
                        XCTExpectFailure()
                        expectation.fulfill()
                    }
                }
            case .failure:
                XCTExpectFailure()
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }       
    
    func test_Update_JWT_Functionality() {
        
        let expectation = XCTestExpectation(description: "Update JWT Expectation")
        
        jwtMemoryStorage.createJWT(Constants_For_Tests.mockedJWT) { [unowned self] createResult in
            
            switch createResult {
            
            case .success(let createdJWT):
                
                XCTAssertTrue(createdJWT.accessToken == Constants_For_Tests.mockedJWT.accessToken)
                
                jwtMemoryStorage.updateJWT(oldAccessToken: createdJWT.accessToken,
                                           newJWTResponse: Constants_For_Tests.mockedJWTForUpdate) { [unowned self] updatedResult in
                    
                    switch updatedResult {
                    
                    case .success:
                        
                        jwtMemoryStorage.readJWT(fromAccessToken: Constants_For_Tests.mockedJWTForUpdate.accessToken) { readResult in
                            
                            switch readResult {
                            
                            case .success(let readJWT):
                                
                                XCTAssertTrue(readJWT.accessToken == Constants_For_Tests.mockedJWTForUpdate.accessToken)
                                XCTAssertTrue(readJWT.expirationDate == Constants_For_Tests.mockedJWTForUpdate.expirationDate)
                                expectation.fulfill()
                                
                            case .failure:
                                XCTExpectFailure()
                                expectation.fulfill()
                            }
                            
                        }
                        
                        
                        
                    case .failure:
                        XCTExpectFailure()
                        expectation.fulfill()
                    }
                }
            case .failure:
                XCTExpectFailure()
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Delete_JWT_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete JWT Expectation")
        
        jwtMemoryStorage.createJWT(Constants_For_Tests.mockedJWT) { [unowned self] createResult in
            
            switch createResult {
            
            case .success(let createdJWT):
                
                self.jwtMemoryStorage.deleteJWT(createdJWT.accessToken) { deleteResult in
                    
                    switch deleteResult {
                    
                    case .success:
                        
                        self.jwtMemoryStorage.entitiesIsEmpty { (entitiesIsEmptyResult) in
                            
                            switch entitiesIsEmptyResult {
                            
                            case .success(let entitiesIsEmpty):
                                
                                XCTAssertTrue(entitiesIsEmpty)
                                expectation.fulfill()
                                
                            case .failure:
                                XCTExpectFailure()
                                expectation.fulfill()
                            }
                        }
                    case .failure:
                        XCTExpectFailure()
                        expectation.fulfill()
                    }
                }
            case .failure:
                XCTExpectFailure()
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
}
