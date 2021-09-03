//
//  MDUserCoreDataStorage_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDUserCoreDataStorage_Tests: XCTestCase {
    
    fileprivate var userCoreDataStorage: MDUserCoreDataStorageProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let operationQueue: OperationQueue = .init()
        let operationQueueService: OperationQueueServiceProtocol = OperationQueueService.init(operationQueue: operationQueue)
        
        let coreDataStack: CoreDataStack = TestCoreDataStack()
        
        let userCoreDataStorage: MDUserCoreDataStorageProtocol = MDUserCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                            managedObjectContext: coreDataStack.privateContext,
                                                                                            coreDataStack: coreDataStack)
        
        self.userCoreDataStorage = userCoreDataStorage
        
    }
    
}

extension MDUserCoreDataStorage_Tests {
    
    func test_Create_User_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create User Expectation")
        
        userCoreDataStorage.createUser(Constants_For_Tests.mockedUser,
                                       password: Constants_For_Tests.mockedUserPassword) { result in
            
            switch result {
            
            case .success(let createdUser):
                
                XCTAssertTrue(createdUser.userId == Constants_For_Tests.mockedUser.userId)
                XCTAssertTrue(createdUser.nickname == Constants_For_Tests.mockedUser.nickname)
                XCTAssertTrue(createdUser.password == Constants_For_Tests.mockedUserPassword)
                XCTAssertTrue(createdUser.createdAt == Constants_For_Tests.mockedUser.createdAt)
                
                expectation.fulfill()
                
            case .failure:
                XCTExpectFailure()
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Read_User_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read User Expectation")
        
        userCoreDataStorage.createUser(Constants_For_Tests.mockedUser,
                                       password: Constants_For_Tests.mockedUserPassword) { [unowned self] createResult in
            
            switch createResult {
            
            case .success(let createdUser):
                
                userCoreDataStorage.readUser(fromUserID: createdUser.userId) { readResult in
                    
                    switch readResult {
                    
                    case .success(let readUser):
                        
                        XCTAssertTrue(createdUser.userId == readUser.userId)
                        XCTAssertTrue(createdUser.nickname == readUser.nickname)
                        XCTAssertTrue(createdUser.password == readUser.password)
                        XCTAssertTrue(createdUser.createdAt == readUser.createdAt)
                        
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
    
    func test_Delete_User_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete User Expectation")
        
        userCoreDataStorage.createUser(Constants_For_Tests.mockedUser,
                                       password: Constants_For_Tests.mockedUserPassword) { [unowned self] createResult in
            
            switch createResult {
            
            case .success(let createdUser):
                
                self.userCoreDataStorage.deleteUser(createdUser.userId) { deleteResult in
                    
                    switch deleteResult {
                    
                    case .success:
                        
                        self.userCoreDataStorage.entitiesIsEmpty { entitiesIsEmptyResult in
                            
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
