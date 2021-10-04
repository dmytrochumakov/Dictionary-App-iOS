//
//  MDJWTCoreDataStorage_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 16.08.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDJWTCoreDataStorage_Tests: XCTestCase {
    
    fileprivate var jwtCoreDataStorage: MDJWTCoreDataStorageProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let coreDataStack: MDCoreDataStack = TestCoreDataStack()
        
        let jwtCoreDataStorage: MDJWTCoreDataStorageProtocol = MDJWTCoreDataStorage.init(operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.jwtCoreDataStorageOperationQueue)!,
                                                                                         managedObjectContext: coreDataStack.privateContext,
                                                                                         coreDataStack: coreDataStack)
        
        self.jwtCoreDataStorage = jwtCoreDataStorage
        
    }
    
}

extension MDJWTCoreDataStorage_Tests {
    
    func test_Create_JWT_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create JWT Expectation")
        
        jwtCoreDataStorage.createJWT(Constants_For_Tests.mockedJWT) { result in
            
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
    
    func test_Read_First_JWT_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read First JWT Expectation")
        
        jwtCoreDataStorage.createJWT(Constants_For_Tests.mockedJWT) { [unowned self] createResult in
            
            switch createResult {
                
            case .success(let createdJWT):
                
                jwtCoreDataStorage.readFirstJWT() { readResult in
                    
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
    
    func test_Read_JWT_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read JWT Expectation")
        
        jwtCoreDataStorage.createJWT(Constants_For_Tests.mockedJWT) { [unowned self] createResult in
            
            switch createResult {
                
            case .success(let createdJWT):
                
                jwtCoreDataStorage.readJWT(fromAccessToken: createdJWT.accessToken) { readResult in
                    
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
        
        jwtCoreDataStorage.createJWT(Constants_For_Tests.mockedJWT) { [unowned self] createResult in
            
            switch createResult {
                
            case .success(let createdJWT):
                
                self.jwtCoreDataStorage.updateJWT(oldAccessToken: createdJWT.accessToken,
                                                  newJWTResponse: Constants_For_Tests.mockedJWTForUpdate) { updateResult in
                    
                    switch updateResult {
                        
                    case .success:
                        
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
    
    func test_Delete_JWT_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete JWT Expectation")
        
        jwtCoreDataStorage.createJWT(Constants_For_Tests.mockedJWT) { [unowned self] createResult in
            
            switch createResult {
                
            case .success(let createdJWT):
                
                self.jwtCoreDataStorage.deleteJWT(createdJWT.accessToken) { deleteResult in
                    
                    switch deleteResult {
                        
                    case .success:
                        
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
    
    func test_Delete_All_JWT_From_Core_Data_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete All JWT From Core Data Expectation")
        
        jwtCoreDataStorage.createJWT(Constants_For_Tests.mockedJWT) { [unowned self] createResult in
            
            switch createResult {
                
            case .success:
                
                self.jwtCoreDataStorage.deleteAllJWT { deleteResult in
                    
                    switch deleteResult {
                        
                    case .success:
                        
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
    
}
