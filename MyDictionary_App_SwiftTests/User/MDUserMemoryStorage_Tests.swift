//
//  MDUserMemoryStorage_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDUserMemoryStorage_Tests: XCTestCase {
    
    fileprivate var userMemoryStorage: MDUserMemoryStorage!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let operationQueue: OperationQueue = .init()
        let operationQueueService: OperationQueueServiceProtocol = OperationQueueService.init(operationQueue: operationQueue)
        
        let userMemoryStorage: MDUserMemoryStorage = MDUserMemoryStorage.init(operationQueueService: operationQueueService,
                                                                              userEntity: nil)
        
        self.userMemoryStorage = userMemoryStorage
        
    }
    
}

extension MDUserMemoryStorage_Tests {
    
    func test_Create_User_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create User Expectation")
        
        userMemoryStorage.createUser(Constants_For_Tests.mockedUser) { result in
            
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
    
    func test_Read_User_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read User Expectation")
        
        userMemoryStorage.createUser(Constants_For_Tests.mockedUser) { [unowned self] createResult in
            
            switch createResult {
            
            case .success(let createdUser):
                
                userMemoryStorage.readUser(fromUserID: createdUser.userId) { readResult in
                    
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
    
    func test_Delete_User_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete User Expectation")
        
        userMemoryStorage.createUser(Constants_For_Tests.mockedUser) { [unowned self] createResult in
            
            switch createResult {
            
            case .success(let createdUser):
                
                self.userMemoryStorage.deleteUser(createdUser) { deleteResult in
                    
                    switch deleteResult {
                    
                    case .success(let deleteUser):
                        
                        XCTAssertTrue(createdUser.userId == deleteUser.userId)
                        XCTAssertTrue(self.userMemoryStorage.userEntity == nil)
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
