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
        
        let operationQueue: OperationQueue = .init()
        let operationQueueService: OperationQueueServiceProtocol = OperationQueueService.init(operationQueue: operationQueue)
        
        let coreDataStack: CoreDataStack = TestCoreDataStack()
        
        let jwtCoreDataStorage: MDJWTCoreDataStorageProtocol = MDJWTCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                         managedObjectContext: coreDataStack.privateContext,
                                                                                         coreDataStack: coreDataStack)
        
        self.jwtCoreDataStorage = jwtCoreDataStorage
        
    }
    
}

extension MDJWTCoreDataStorage_Tests {
    
    func test_Create_JWT_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create JWT Expectation")
        
        jwtCoreDataStorage.createJWT(Constants_For_Tests.mockedJWT) { [unowned self] result in
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
        
        jwtCoreDataStorage.createJWT(Constants_For_Tests.mockedJWT) { [unowned self] createResult in
            switch createResult {
            case .success(let createdJWT):
                jwtCoreDataStorage.readJWT(fromAccessToken: createdJWT.accessToken) { [unowned self] readResult in
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
                                                  newJWTResponse: Constants_For_Tests.mockedJWTForUpdate) { [unowned self] updateResult in
                    switch updateResult {
                    case .success(let updatedJWT):                        
                        XCTAssertTrue(updatedJWT.accessToken == Constants_For_Tests.mockedJWTForUpdate.accessToken)
                        XCTAssertTrue(updatedJWT.expirationDate == Constants_For_Tests.mockedJWTForUpdate.expirationDate)
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
                self.jwtCoreDataStorage.deleteJWT(createdJWT) { deleteResult in
                    switch deleteResult {
                    case .success(let deleteJWT):
                        XCTAssertTrue(createdJWT.accessToken == deleteJWT.accessToken)
                        self.jwtCoreDataStorage.entitiesCount { [unowned self] countResult in
                            switch countResult {
                            case .success(let entitiesCount):
                                XCTAssertTrue(entitiesCount == 0)
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
