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
        
        userStorage.createUser(Constants_For_Tests.mockedUser, storageType: storageType) { [unowned self] results in
            
            switch results.first!.result {
            
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
        
        userStorage.createUser(Constants_For_Tests.mockedUser, storageType: storageType) { [unowned self] createResults in
            
            switch createResults.first!.result {
            
            case .success(let createdUser):
                
                userStorage.readUser(fromUserID: createdUser.userId, storageType: storageType) { [unowned self] readResults in
                    
                    switch readResults.first!.result {
                    
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
        
        userStorage.createUser(Constants_For_Tests.mockedUser, storageType: storageType) { [unowned self] createResults in
            
            switch createResults.first!.result {
            
            case .success(let createdUser):
                
                self.userStorage.deleteUser(createdUser, storageType: storageType) { [unowned self] deleteResults in
                    
                    switch deleteResults.first!.result {
                    
                    case .success(let deleteUser):
                        
                        XCTAssertTrue(createdUser.userId == deleteUser.userId)
                        
                        self.userStorage.entitiesIsEmpty(storageType: storageType) { [unowned self] entitiesIsEmptyResults in
                            
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
extension MDUserStorage_Tests {
    
    func test_Create_User_In_Core_Data_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create User In Core Data Expectation")
        let storageType: MDStorageType = .coreData
        
        userStorage.createUser(Constants_For_Tests.mockedUser, storageType: storageType) { [unowned self] results in
            
            switch results.first!.result {
            
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
        
        userStorage.createUser(Constants_For_Tests.mockedUser, storageType: storageType) { [unowned self] createResults in
            
            switch createResults.first!.result {
            
            case .success(let createdUser):
                
                userStorage.readUser(fromUserID: createdUser.userId, storageType: storageType) { [unowned self] readResults in
                    
                    switch readResults.first!.result {
                    
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
        
        userStorage.createUser(Constants_For_Tests.mockedUser, storageType: storageType) { [unowned self] createResults in
            
            switch createResults.first!.result {
            
            case .success(let createdUser):
                
                self.userStorage.deleteUser(createdUser, storageType: storageType) { [unowned self] deleteResults in
                    
                    switch deleteResults.first!.result {
                    
                    case .success(let deleteUser):
                        
                        XCTAssertTrue(createdUser.userId == deleteUser.userId)
                        
                        self.userStorage.entitiesIsEmpty(storageType: storageType) { [unowned self] entitiesIsEmptyResults in
                            
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
extension MDUserStorage_Tests {
    
    func test_Create_User_In_All_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create User In All Expectation")
        let storageType: MDStorageType = .all
        
        var resultCount: Int = .zero
        
        userStorage.createUser(Constants_For_Tests.mockedUser, storageType: storageType) { [unowned self] createResults in
            
            createResults.forEach { createResult in
                
                switch createResult.result {
                
                case .success(let createdUser):
                    
                    resultCount += 1
                    
                    XCTAssertTrue(createdUser.userId == Constants_For_Tests.mockedUser.userId)
                    XCTAssertTrue(createdUser.nickname == Constants_For_Tests.mockedUser.nickname)
                    XCTAssertTrue(createdUser.password == Constants_For_Tests.mockedUser.password)
                    XCTAssertTrue(createdUser.createdAt == Constants_For_Tests.mockedUser.createdAt)
                    XCTAssertTrue(createdUser.updatedAt == Constants_For_Tests.mockedUser.updatedAt)
                    
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
    
    func test_Read_User_From_All_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read User From All Expectation")
        let storageType: MDStorageType = .all
        
        var resultCount: Int = .zero
        
        userStorage.createUser(Constants_For_Tests.mockedUser, storageType: storageType) { [unowned self] createResults in
            
            switch createResults.first!.result {
            
            case .success(let createdUser):
                
                userStorage.readUser(fromUserID: createdUser.userId, storageType: storageType) { [unowned self] readResults in
                    
                    readResults.forEach { readResult in
                        
                        switch readResult.result {
                        
                        case .success(let readUser):
                            
                            resultCount += 1
                            
                            XCTAssertTrue(createdUser.userId == readUser.userId)
                            XCTAssertTrue(createdUser.nickname == readUser.nickname)
                            XCTAssertTrue(createdUser.password == readUser.password)
                            XCTAssertTrue(createdUser.createdAt == readUser.createdAt)
                            XCTAssertTrue(createdUser.updatedAt == readUser.updatedAt)
                            
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
        
        userStorage.createUser(Constants_For_Tests.mockedUser, storageType: storageType) { [unowned self] createResults in
            
            switch createResults.first!.result {
            
            case .success(let createdUser):
                
                self.userStorage.deleteUser(createdUser, storageType: storageType) { [unowned self] deleteResults in
                    
                    deleteResults.forEach { deleteResult in
                        
                        switch deleteResult.result {
                        
                        case .success(let deleteUser):
                            
                            XCTAssertTrue(createdUser.userId == deleteUser.userId)
                            
                            self.userStorage.entitiesIsEmpty(storageType: deleteResult.storageType) { [unowned self] entitiesIsEmptyResults in
                                
                                switch entitiesIsEmptyResults.first!.result {
                                
                                case .success(let entitiesIsEmpty):
                                    
                                    resultCount += 1
                                    
                                    XCTAssertTrue(entitiesIsEmpty)
                                    
                                    if (resultCount == deleteResults.count) {
                                        expectation.fulfill()
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
                }
            case .failure:
                XCTExpectFailure()
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
}
