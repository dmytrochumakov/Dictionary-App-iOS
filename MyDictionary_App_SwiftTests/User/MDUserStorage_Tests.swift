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
        
        let operationQueue: OperationQueue = .init()
        
        let operationQueueService: OperationQueueServiceProtocol = OperationQueueService.init(operationQueue: operationQueue)
        
        let memoryStorage: MDUserMemoryStorageProtocol = MDUserMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                  userEntity: nil)
        
        let coreDataStack: CoreDataStack = CoreDataStack.init()
        let coreDataStorage: MDUserCoreDataStorageProtocol = MDUserCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                        managedObjectContext: coreDataStack.privateContext,
                                                                                        coreDataStack: coreDataStack)
        
        let userStorage: MDUserStorageProtocol = MDUserStorage.init(memoryStorage: memoryStorage,
                                                                    coreDataStorage: coreDataStorage)
        
        self.userStorage = userStorage
        
    }
    
}

// MARK: - Memory CRUD
extension MDUserStorage_Tests {
    
    func test_Create_User_In_Memory_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create User In Memory Expectation")
        let storageType: MDStorageType = .memory
        
        userStorage.createUser(Constants_For_Tests.mockedUser, storageType: storageType) { [unowned self] result in
            switch result {
            case .success(let createdUser):
                XCTAssertTrue(createdUser.userId == Constants_For_Tests.mockedUser.userId)
                XCTAssertTrue(createdUser.nickname == Constants_For_Tests.mockedUser.nickname)
                XCTAssertTrue(createdUser.password == Constants_For_Tests.mockedUser.password)
                XCTAssertTrue(createdUser.createdAt == Constants_For_Tests.mockedUser.createdAt)
                XCTAssertTrue(createdUser.updatedAt == Constants_For_Tests.mockedUser.updatedAt)
                expectation.fulfill()
            case .failure:
                XCTExpectFailure()
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Read_User_From_Memory_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read User From Memory Expectation")
        let storageType: MDStorageType = .memory
        
        userStorage.createUser(Constants_For_Tests.mockedUser, storageType: storageType) { [unowned self] createResult in
            switch createResult {
            case .success(let createdUser):
                userStorage.readUser(fromUserID: createdUser.userId, storageType: storageType) { [unowned self] readResult in
                    switch readResult {
                    case .success(let readUser):
                        XCTAssertTrue(createdUser.userId == readUser.userId)
                        XCTAssertTrue(createdUser.nickname == readUser.nickname)
                        XCTAssertTrue(createdUser.password == readUser.password)
                        XCTAssertTrue(createdUser.createdAt == readUser.createdAt)
                        XCTAssertTrue(createdUser.updatedAt == readUser.updatedAt)
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
    
    func test_Delete_User_From_Memory_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete User From Memory Expectation")
        let storageType: MDStorageType = .memory
        
        userStorage.createUser(Constants_For_Tests.mockedUser, storageType: storageType) { [unowned self] createResult in
            switch createResult {
            case .success(let createdUser):
                self.userStorage.deleteUser(createdUser, storageType: storageType) { deleteResult in
                    switch deleteResult {
                    case .success(let deleteUser):
                        XCTAssertTrue(createdUser.userId == deleteUser.userId)
                        self.userStorage.entitiesIsEmpty(storageType: storageType) { [unowned self] entitiesIsEmptyResult in
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

// MARK: - Core Data CRUD
extension MDUserStorage_Tests {
    
    func test_Create_User_In_Core_Data_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create User In Core Data Expectation")
        let storageType: MDStorageType = .coreData
        
        userStorage.createUser(Constants_For_Tests.mockedUser, storageType: storageType) { [unowned self] result in
            switch result {
            case .success(let createdUser):
                XCTAssertTrue(createdUser.userId == Constants_For_Tests.mockedUser.userId)
                XCTAssertTrue(createdUser.nickname == Constants_For_Tests.mockedUser.nickname)
                XCTAssertTrue(createdUser.password == Constants_For_Tests.mockedUser.password)
                XCTAssertTrue(createdUser.createdAt == Constants_For_Tests.mockedUser.createdAt)
                XCTAssertTrue(createdUser.updatedAt == Constants_For_Tests.mockedUser.updatedAt)
                expectation.fulfill()
            case .failure:
                XCTExpectFailure()
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Read_User_From_Core_Data_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read User From Core Data Expectation")
        let storageType: MDStorageType = .coreData
        
        userStorage.createUser(Constants_For_Tests.mockedUser, storageType: storageType) { [unowned self] createResult in
            switch createResult {
            case .success(let createdUser):
                userStorage.readUser(fromUserID: createdUser.userId, storageType: storageType) { [unowned self] readResult in
                    switch readResult {
                    case .success(let readUser):
                        XCTAssertTrue(createdUser.userId == readUser.userId)
                        XCTAssertTrue(createdUser.nickname == readUser.nickname)
                        XCTAssertTrue(createdUser.password == readUser.password)
                        XCTAssertTrue(createdUser.createdAt == readUser.createdAt)
                        XCTAssertTrue(createdUser.updatedAt == readUser.updatedAt)
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
    
    func test_Delete_User_From_Core_Data_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete From Core Data User Expectation")
        let storageType: MDStorageType = .coreData
        
        userStorage.createUser(Constants_For_Tests.mockedUser, storageType: storageType) { [unowned self] createResult in
            switch createResult {
            case .success(let createdUser):
                self.userStorage.deleteUser(createdUser, storageType: storageType) { deleteResult in
                    switch deleteResult {
                    case .success(let deleteUser):
                        XCTAssertTrue(createdUser.userId == deleteUser.userId)
                        self.userStorage.entitiesIsEmpty(storageType: storageType) { [unowned self] entitiesIsEmptyResult in
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
