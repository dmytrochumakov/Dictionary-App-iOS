//
//  MDUserStorage_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDUserStorage_Tests: XCTestCase {
    
    fileprivate var userStorage: MDUserStorageProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let memoryStorage: MDUserMemoryStorageProtocol = MDUserMemoryStorage.init(operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.userMemoryStorageOperationQueue)!,
                                                                                  array: .init())
        
        let coreDataStack: MDCoreDataStack = TestCoreDataStack.init()
        
        let coreDataStorage: MDUserCoreDataStorageProtocol = MDUserCoreDataStorage.init(operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.userCoreDataStorageOperationQueue)!,
                                                                                        managedObjectContext: coreDataStack.privateContext,
                                                                                        coreDataStack: coreDataStack)
        
        let userStorage: MDUserStorageProtocol = MDUserStorage.init(memoryStorage: memoryStorage,
                                                                    coreDataStorage: coreDataStorage,
                                                                    operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.userStorageOperationQueue)!)
        
        self.userStorage = userStorage
        
    }
    
}

// MARK: - All CRUD
extension MDUserStorage_Tests {
    
    func test_Create_User_In_All_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create User In All Expectation")
        let storageType: MDStorageType = .all
        
        var resultCount: Int = .zero
        
        userStorage.createUser(Constants_For_Tests.mockedUser,
                               password: Constants_For_Tests.mockedUserPassword,
                               storageType: storageType) { createResults in
            
            createResults.forEach { createResult in
                
                switch createResult.result {
                    
                case .success(let createdUser):
                    
                    resultCount += 1
                    
                    XCTAssertTrue(createdUser.userId == Constants_For_Tests.mockedUser.userId)
                    XCTAssertTrue(createdUser.nickname == Constants_For_Tests.mockedUser.nickname)
                    XCTAssertTrue(createdUser.password == Constants_For_Tests.mockedUserPassword)
                    XCTAssertTrue(createdUser.createdAt == Constants_For_Tests.mockedUser.createdAt)
                    
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
    
    func test_Read_First_User_All_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read First User From All Expectation")
        let storageType: MDStorageType = .all
        
        var resultCount: Int = .zero
        
        userStorage.createUser(Constants_For_Tests.mockedUser,
                               password: Constants_For_Tests.mockedUserPassword,
                               storageType: storageType) { [unowned self] createResults in
            
            switch createResults.first!.result {
                
            case .success(let createdUser):
                
                userStorage.readFirstUser(storageType: storageType) { readResults in
                    
                    readResults.forEach { readResult in
                        
                        switch readResult.result {
                            
                        case .success(let readUser):
                            
                            resultCount += 1
                            
                            XCTAssertTrue(createdUser.userId == readUser.userId)
                            XCTAssertTrue(createdUser.nickname == readUser.nickname)
                            XCTAssertTrue(createdUser.password == readUser.password)
                            XCTAssertTrue(createdUser.createdAt == readUser.createdAt)
                            
                            if (resultCount == readResults.count) {
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
    
    func test_Read_User_From_All_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read User From All Expectation")
        let storageType: MDStorageType = .all
        
        var resultCount: Int = .zero
        
        userStorage.createUser(Constants_For_Tests.mockedUser,
                               password: Constants_For_Tests.mockedUserPassword,
                               storageType: storageType) { [unowned self] createResults in
            
            switch createResults.first!.result {
                
            case .success(let createdUser):
                
                userStorage.readUser(fromUserID: createdUser.userId, storageType: storageType) { readResults in
                    
                    readResults.forEach { readResult in
                        
                        switch readResult.result {
                            
                        case .success(let readUser):
                            
                            resultCount += 1
                            
                            XCTAssertTrue(createdUser.userId == readUser.userId)
                            XCTAssertTrue(createdUser.nickname == readUser.nickname)
                            XCTAssertTrue(createdUser.password == readUser.password)
                            XCTAssertTrue(createdUser.createdAt == readUser.createdAt)
                            
                            if (resultCount == readResults.count) {
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
    
    func test_Delete_User_From_All_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete User From All Expectation")
        let storageType: MDStorageType = .all
        
        var resultCount: Int = .zero
        
        userStorage.createUser(Constants_For_Tests.mockedUser,
                               password: Constants_For_Tests.mockedUserPassword,
                               storageType: storageType) { [unowned self] createResults in
            
            switch createResults.first!.result {
                
            case .success(let createdUser):
                
                self.userStorage.deleteUser(createdUser.userId, storageType: storageType) { deleteResults in
                    
                    deleteResults.forEach { deleteResult in
                        
                        switch deleteResult.result {
                            
                        case .success:
                            
                            resultCount += 1
                            
                            if (resultCount == deleteResults.count) {
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
    
}
