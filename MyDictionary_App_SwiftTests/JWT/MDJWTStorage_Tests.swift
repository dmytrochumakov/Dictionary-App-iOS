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
        
        let memoryStorage: MDJWTMemoryStorageProtocol = MDJWTMemoryStorage.init(operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.jwtMemoryStorageOperationQueue)!,
                                                                                array: .init())
        
        let coreDataStack: MDCoreDataStack = TestCoreDataStack.init()
        
        let coreDataStorage: MDJWTCoreDataStorageProtocol = MDJWTCoreDataStorage.init(operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.jwtCoreDataStorageOperationQueue)!,
                                                                                      managedObjectContext: coreDataStack.privateContext,
                                                                                      coreDataStack: coreDataStack)
        
        let jwtStorage: MDJWTStorageProtocol = MDJWTStorage.init(memoryStorage: memoryStorage,
                                                                 coreDataStorage: coreDataStorage)
        
        self.jwtStorage = jwtStorage
        
    }
    
}

// MARK: - All CRUD
extension MDJWTStorage_Tests {
    
    func test_Create_JWT_In_All_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create JWT In All Expectation")
        let storageType: MDStorageType = .all
        
        var resultCount: Int = .zero
        
        jwtStorage.createJWT(storageType: storageType, jwtResponse: Constants_For_Tests.mockedJWT) { createResults in
            
            createResults.forEach { createResult in
                
                switch createResult.result {
                case .success(let createdJWT):
                    
                    resultCount += 1
                    
                    XCTAssertTrue(createdJWT.accessToken == Constants_For_Tests.mockedJWT.accessToken)
                    XCTAssertTrue(createdJWT.expirationDate == Constants_For_Tests.mockedJWT.expirationDate)
                    
                    if (resultCount == createResults.count) {
                        expectation.fulfill()
                    }
                    
                case .failure(let error):
                    XCTExpectFailure(error.localizedDescription)
                    expectation.fulfill()
                }
                
            }
            
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Read_First_JWT_From_All_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read First JWT From All Expectation")
        let storageType: MDStorageType = .all
        
        var resultCount: Int = .zero
        
        jwtStorage.createJWT(storageType: storageType, jwtResponse: Constants_For_Tests.mockedJWT) { [unowned self] createResults in
            
            switch createResults.first!.result {
                
            case .success(let createJWT):
                
                jwtStorage.readFirstJWT(storageType: storageType) { readResults in
                    
                    readResults.forEach { readResult in
                        
                        switch readResult.result {
                        case .success(let readJWT):
                            
                            resultCount += 1
                            
                            XCTAssertTrue(readJWT.accessToken == createJWT.accessToken)
                            XCTAssertTrue(readJWT.expirationDate == createJWT.expirationDate)
                            
                            if (resultCount == createResults.count) {
                                expectation.fulfill()
                            }
                            
                        case .failure(let error):
                            XCTExpectFailure(error.localizedDescription)
                            expectation.fulfill()
                        }
                        
                    }
                    
                }
                
            case .failure(let error):
                XCTExpectFailure(error.localizedDescription)
                expectation.fulfill()
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
                
                jwtStorage.readJWT(storageType: storageType, fromAccessToken: createJWT.accessToken) { readResults in
                    
                    readResults.forEach { readResult in
                        
                        switch readResult.result {
                        case .success(let readJWT):
                            
                            resultCount += 1
                            
                            XCTAssertTrue(readJWT.accessToken == createJWT.accessToken)
                            XCTAssertTrue(readJWT.expirationDate == createJWT.expirationDate)
                            
                            if (resultCount == createResults.count) {
                                expectation.fulfill()
                            }
                            
                        case .failure(let error):
                            XCTExpectFailure(error.localizedDescription)
                            expectation.fulfill()
                        }
                        
                    }
                    
                }
                
            case .failure(let error):
                XCTExpectFailure(error.localizedDescription)
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
                                          newJWTResponse: Constants_For_Tests.mockedJWTForUpdate) { updateResults in
                    
                    updateResults.forEach { updateResult in
                        
                        switch updateResult.result {
                            
                        case .success:
                            
                            resultCount += 1
                            
                            if (resultCount == updateResults.count) {
                                expectation.fulfill()
                            }
                            
                        case .failure(let error):
                            XCTExpectFailure(error.localizedDescription)
                            expectation.fulfill()
                        }
                        
                    }
                }
                
            case .failure(let error):
                XCTExpectFailure(error.localizedDescription)
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
                
                self.jwtStorage.deleteJWT(storageType: storageType, accessToken: createdJWT.accessToken) { deleteResults in
                    
                    deleteResults.forEach { deleteResult in
                        
                        switch deleteResult.result {
                            
                        case .success:
                            
                            resultCount += 1
                            
                            if (resultCount == deleteResults.count) {
                                expectation.fulfill()
                            }
                            
                        case .failure(let error):
                            XCTExpectFailure(error.localizedDescription)
                            expectation.fulfill()
                        }
                        
                    }
                }
                
            case .failure(let error):
                XCTExpectFailure(error.localizedDescription)
                expectation.fulfill()
            }
            
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Delete_All_JWT() {
        
        let expectation = XCTestExpectation(description: "Delete All JWT Expectation")
        let storageType: MDStorageType = .all
        
        var resultCount: Int = .zero
        
        jwtStorage.createJWT(storageType: storageType, jwtResponse: Constants_For_Tests.mockedJWT) { [unowned self] createResults in
            
            switch createResults.first!.result {
                
            case .success(let createJWT):
                
                XCTAssertTrue(createJWT.accessToken == Constants_For_Tests.mockedJWT.accessToken)
                
                self.jwtStorage.deleteAllJWT(storageType: storageType) { deleteResults in
                    
                    deleteResults.forEach { deleteResult in
                        
                        switch deleteResult.result {
                            
                        case .success:
                            
                            resultCount += 1
                            
                            if (resultCount == deleteResults.count) {
                                expectation.fulfill()
                            }
                            
                        case .failure(let error):
                            XCTExpectFailure(error.localizedDescription)
                            expectation.fulfill()
                        }
                        
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
