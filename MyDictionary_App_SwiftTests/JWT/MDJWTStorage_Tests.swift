//
//  MDJWTStorage_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 16.08.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDJWTStorage_Tests: XCTestCase {
    
    fileprivate var jwtStorage: MDJWTStorageProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let operationQueue: OperationQueue = .init()
        
        let operationQueueService: OperationQueueServiceProtocol = OperationQueueService.init(operationQueue: operationQueue)
        
        let memoryStorage: MDJWTMemoryStorageProtocol = MDJWTMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                authResponse: nil)
        
        let coreDataStack: CoreDataStack = CoreDataStack.init()
        let coreDataStorage: MDJWTCoreDataStorageProtocol = MDJWTCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                      managedObjectContext: coreDataStack.privateContext,
                                                                                      coreDataStack: coreDataStack)
        
        let jwtStorage: MDJWTStorageProtocol = MDJWTStorage.init(memoryStorage: memoryStorage,
                                                                 coreDataStorage: coreDataStorage)
        
        self.jwtStorage = jwtStorage
        
    }
    
}

// MARK: - Memory CRUD
extension MDJWTStorage_Tests {
    
    func test_Create_JWT_In_Memory_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create JWT In Memory Expectation")
        let storageType: MDStorageType = .memory
        
        jwtStorage.createJWT(storageType: storageType, authResponse: Constants_For_Tests.mockedJWT) { [unowned self] result in
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
    
    func test_Read_JWT_From_Memory_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read JWT From Memory Expectation")
        let storageType: MDStorageType = .memory
        
        jwtStorage.createJWT(storageType: storageType, authResponse: Constants_For_Tests.mockedJWT) { [unowned self] createResult in
            switch createResult {
            case .success(let createdJWT):
                jwtStorage.readJWT(storageType: storageType, fromAccessToken: createdJWT.accessToken) { [unowned self] readResult in
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
    
    func test_Update_JWT_In_Memory_Functionality() {
        
        let expectation = XCTestExpectation(description: "Update JWT In Memory Expectation")
        let storageType: MDStorageType = .memory
        
        jwtStorage.createJWT(storageType: storageType, authResponse: Constants_For_Tests.mockedJWT) { [unowned self] createResult in
            switch createResult {
            case .success(let createdJWT):
                
                XCTAssertTrue(createdJWT.accessToken == Constants_For_Tests.mockedJWT.accessToken)
                
                jwtStorage.updateJWT(storageType: storageType,
                                     oldAccessToken: createdJWT.accessToken,
                                     newAuthResponse: Constants_For_Tests.mockedJWTForUpdate) { updatedResult in
                    
                    switch updatedResult {
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
    
    func test_Delete_JWT_From_Memory_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete JWT From Memory Expectation")
        let storageType: MDStorageType = .memory
        
        jwtStorage.createJWT(storageType: storageType, authResponse: Constants_For_Tests.mockedJWT) { [unowned self] createResult in
            switch createResult {
            case .success(let createdJWT):
                
                self.jwtStorage.deleteJWT(storageType: storageType, authResponse: createdJWT) { deleteResult in
                    
                    switch deleteResult {
                    case .success(let deleteJWT):
                        
                        XCTAssertTrue(createdJWT.accessToken == deleteJWT.accessToken)
                        
                        self.jwtStorage.entitiesCount(storageType: storageType) { [unowned self] (entitiesCount) in
                            switch entitiesCount {
                            case .success(let jwtCount):
                                XCTAssertTrue(jwtCount == 0)
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

// MARK: - Core Data CRUD
extension MDJWTStorage_Tests {
    
    func test_Create_JWT_In_Core_Data_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create JWT In Core Data Expectation")
        let storageType: MDStorageType = .coreData
        
        jwtStorage.createJWT(storageType: storageType, authResponse: Constants_For_Tests.mockedJWT) { [unowned self] result in
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
    
    func test_Read_JWT_From_Core_Data_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read From Core Data Expectation")
        let storageType: MDStorageType = .coreData
        
        jwtStorage.createJWT(storageType: storageType, authResponse: Constants_For_Tests.mockedJWT) { [unowned self] createResult in
            switch createResult {
            case .success(let createdJWT):
                jwtStorage.readJWT(storageType: storageType, fromAccessToken: createdJWT.accessToken) { [unowned self] readResult in
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
    
    func test_Update_JWT_In_Core_Data_Functionality() {
        
        let expectation = XCTestExpectation(description: "Update JWT In Core Data Expectation")
        let storageType: MDStorageType = .coreData
        
        jwtStorage.createJWT(storageType: storageType, authResponse: Constants_For_Tests.mockedJWT) { [unowned self] createResult in
            switch createResult {
            case .success(let createdJWT):
                
                self.jwtStorage.updateJWT(storageType: storageType,
                                          oldAccessToken: createdJWT.accessToken,
                                          newAuthResponse: Constants_For_Tests.mockedJWTForUpdate) { [unowned self] updateResult in
                    
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
    
    func test_Delete_JWT_From_Core_Data_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete JWT From Core Data Expectation")
        let storageType: MDStorageType = .coreData
        
        jwtStorage.createJWT(storageType: storageType, authResponse: Constants_For_Tests.mockedJWT) { [unowned self] createResult in
            switch createResult {
            case .success(let createdJWT):
                
                self.jwtStorage.deleteJWT(storageType: storageType, authResponse: createdJWT) { deleteResult in
                    switch deleteResult {
                    case .success(let deleteJWT):
                        XCTAssertTrue(createdJWT.accessToken == deleteJWT.accessToken)
                        
                        self.jwtStorage.entitiesCount(storageType: storageType) { [unowned self] countResult in
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
