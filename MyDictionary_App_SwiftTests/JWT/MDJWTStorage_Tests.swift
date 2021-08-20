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
                                                                                jwtResponse: nil)
        
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
        
        jwtStorage.createJWT(storageType: storageType, jwtResponse: Constants_For_Tests.mockedJWT) { [unowned self] results in
            switch results.first!.result {
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
        
        jwtStorage.createJWT(storageType: storageType, jwtResponse: Constants_For_Tests.mockedJWT) { [unowned self] createResults in
            switch createResults.first!.result {
            case .success(let createdJWT):
                jwtStorage.readJWT(storageType: storageType, fromAccessToken: createdJWT.accessToken) { [unowned self] readResults in
                    switch readResults.first!.result {
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
        
        jwtStorage.createJWT(storageType: storageType, jwtResponse: Constants_For_Tests.mockedJWT) { [unowned self] createResults in
            switch createResults.first!.result {
            case .success(let createdJWT):
                
                XCTAssertTrue(createdJWT.accessToken == Constants_For_Tests.mockedJWT.accessToken)
                
                jwtStorage.updateJWT(storageType: storageType,
                                     oldAccessToken: createdJWT.accessToken,
                                     newJWTResponse: Constants_For_Tests.mockedJWTForUpdate) { updatedResults in
                    
                    switch updatedResults.first!.result {
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
        
        jwtStorage.createJWT(storageType: storageType, jwtResponse: Constants_For_Tests.mockedJWT) { [unowned self] createResults in
            switch createResults.first!.result {
            case .success(let createdJWT):
                
                self.jwtStorage.deleteJWT(storageType: storageType, jwtResponse: createdJWT) { deleteResults in
                    
                    switch deleteResults.first!.result {
                    case .success(let deleteJWT):
                        
                        XCTAssertTrue(createdJWT.accessToken == deleteJWT.accessToken)
                        
                        self.jwtStorage.entitiesIsEmpty(storageType: storageType) { [unowned self] (entitiesIsEmptyResults) in
                            switch entitiesIsEmptyResults.first!.result {
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

// MARK: - Core Data CRUD
extension MDJWTStorage_Tests {
    
    func test_Create_JWT_In_Core_Data_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create JWT In Core Data Expectation")
        let storageType: MDStorageType = .coreData
        
        jwtStorage.createJWT(storageType: storageType, jwtResponse: Constants_For_Tests.mockedJWT) { [unowned self] results in
            switch results.first!.result {
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
        
        jwtStorage.createJWT(storageType: storageType, jwtResponse: Constants_For_Tests.mockedJWT) { [unowned self] createResults in
            switch createResults.first!.result {
            case .success(let createdJWT):
                jwtStorage.readJWT(storageType: storageType, fromAccessToken: createdJWT.accessToken) { [unowned self] readResults in
                    switch readResults.first!.result {
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
        
        jwtStorage.createJWT(storageType: storageType, jwtResponse: Constants_For_Tests.mockedJWT) { [unowned self] createResults in
            switch createResults.first!.result {
            case .success(let createdJWT):
                
                self.jwtStorage.updateJWT(storageType: storageType,
                                          oldAccessToken: createdJWT.accessToken,
                                          newJWTResponse: Constants_For_Tests.mockedJWTForUpdate) { [unowned self] updateResults in
                    
                    switch updateResults.first!.result {
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
        
        jwtStorage.createJWT(storageType: storageType, jwtResponse: Constants_For_Tests.mockedJWT) { [unowned self] createResults in
            switch createResults.first!.result {
            case .success(let createdJWT):
                
                self.jwtStorage.deleteJWT(storageType: storageType, jwtResponse: createdJWT) { deleteResults in
                    switch deleteResults.first!.result {
                    case .success(let deleteJWT):
                        XCTAssertTrue(createdJWT.accessToken == deleteJWT.accessToken)
                        
                        self.jwtStorage.entitiesIsEmpty(storageType: storageType) { [unowned self] entitiesIsEmptyResults in
                            switch entitiesIsEmptyResults.first!.result {
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

// MARK: - All CRUD
extension MDJWTStorage_Tests {
    
    func test_Create_JWT_In_All_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create JWT In All Expectation")
        let storageType: MDStorageType = .all
        
        var resultCount: Int = .zero
        
        jwtStorage.createJWT(storageType: storageType, jwtResponse: Constants_For_Tests.mockedJWT) { [unowned self] createResults in
            
            createResults.forEach { createResult in
                
                switch createResult.result {
                case .success(let createdJWT):
                    
                    resultCount += 1
                    
                    XCTAssertTrue(createdJWT.accessToken == Constants_For_Tests.mockedJWT.accessToken)
                    XCTAssertTrue(createdJWT.expirationDate == Constants_For_Tests.mockedJWT.expirationDate)
                    
                    if (resultCount == createResults.count) {
                        expectation.fulfill()
                    }
                    
                case .failure:
                    XCTExpectFailure()
                    expectation.fulfill()
                }
                
            }
            
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Read_JWT_From_All_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read JWT From All Expectation")
        let storageType: MDStorageType = .all
        
        var resultCount: Int = .zero
        
        jwtStorage.createJWT(storageType: storageType, jwtResponse: Constants_For_Tests.mockedJWT) { [unowned self] createResults in
            
            switch createResults.first!.result {
            
            case .success(let createJWT):
                
                jwtStorage.readJWT(storageType: storageType, fromAccessToken: createJWT.accessToken) { [unowned self] readResults in
                    
                    readResults.forEach { readResult in
                        
                        switch readResult.result {
                        case .success(let readJWT):
                            
                            resultCount += 1
                            
                            XCTAssertTrue(readJWT.accessToken == createJWT.accessToken)
                            XCTAssertTrue(readJWT.expirationDate == createJWT.expirationDate)
                            
                            if (resultCount == createResults.count) {
                                expectation.fulfill()
                            }
                            
                        case .failure:
                            XCTExpectFailure()
                            expectation.fulfill()
                        }
                        
                    }
                    
                }
                
            case .failure:
                XCTExpectFailure()
                expectation.fulfill()
            }
            
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Update_JWT_In_All_Functionality() {
        
        let expectation = XCTestExpectation(description: "Update JWT In All Expectation")
        let storageType: MDStorageType = .all
        
        var resultCount: Int = .zero
        
        jwtStorage.createJWT(storageType: storageType, jwtResponse: Constants_For_Tests.mockedJWT) { [unowned self] createResults in
            
            switch createResults.first!.result {
            
            case .success(let createdJWT):
                
                self.jwtStorage.updateJWT(storageType: storageType,
                                          oldAccessToken: createdJWT.accessToken,
                                          newJWTResponse: Constants_For_Tests.mockedJWTForUpdate) { [unowned self] updateResults in
                    
                    updateResults.forEach { updateResult in
                        
                        switch updateResult.result {
                        case .success(let updatedJWT):
                            
                            resultCount += 1
                            
                            XCTAssertTrue(updatedJWT.accessToken == Constants_For_Tests.mockedJWTForUpdate.accessToken)
                            XCTAssertTrue(updatedJWT.expirationDate == Constants_For_Tests.mockedJWTForUpdate.expirationDate)
                            
                            if (resultCount == updateResults.count) {
                                expectation.fulfill()
                            }
                            
                        case .failure:
                            XCTExpectFailure()
                            expectation.fulfill()
                        }
                        
                    }
                }
                
            case .failure:
                XCTExpectFailure()
                expectation.fulfill()
            }
            
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Delete_JWT_From_All_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete JWT From All Expectation")
        let storageType: MDStorageType = .all
        
        var resultCount: Int = .zero
        
        jwtStorage.createJWT(storageType: storageType, jwtResponse: Constants_For_Tests.mockedJWT) { [unowned self] createResults in
            
            switch createResults.first!.result {
            case .success(let createdJWT):
                
                self.jwtStorage.deleteJWT(storageType: storageType, jwtResponse: createdJWT) { deleteResults in
                    
                    deleteResults.forEach { deleteResult in
                        
                        switch deleteResult.result {
                        case .success(let deleteJWT):
                            
                            XCTAssertTrue(createdJWT.accessToken == deleteJWT.accessToken)
                            
                            self.jwtStorage.entitiesIsEmpty(storageType: storageType) { [unowned self] entitiesIsEmptyResults in
                                
                                entitiesIsEmptyResults.forEach { entitiesIsEmptyResult in
                                    
                                    switch entitiesIsEmptyResult.result {
                                    case .success(let entitiesIsEmpty):
                                        
                                        resultCount += 1
                                        
                                        XCTAssertTrue(entitiesIsEmpty)
                                        
                                        if (resultCount == entitiesIsEmptyResults.count) {
                                            expectation.fulfill()
                                        }
                                        
                                    case .failure:
                                        XCTExpectFailure()
                                        expectation.fulfill()
                                    }
                                    
                                }
                            }
                            
                        case .failure:
                            XCTExpectFailure()
                            expectation.fulfill()
                        }
                        
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
