//
//  MDLanguageCoreDataStorage_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDLanguageCoreDataStorage_Tests: XCTestCase {
    
    fileprivate var languageCoreDataStorage: MDLanguageCoreDataStorageProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let operationQueue: OperationQueue = .init()
        let operationQueueService: OperationQueueServiceProtocol = OperationQueueService.init(operationQueue: operationQueue)
        
        let coreDataStack: CoreDataStack = TestCoreDataStack()
        
        let languageCoreDataStorage: MDLanguageCoreDataStorageProtocol = MDLanguageCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                                        managedObjectContext: coreDataStack.privateContext,
                                                                                                        coreDataStack: coreDataStack)
        
        self.languageCoreDataStorage = languageCoreDataStorage
        
    }
    
}

// MARK: - CRUD
extension MDLanguageCoreDataStorage_Tests {
    
    func test_Create_Languages() {
        
        let expectation = XCTestExpectation(description: "Create Languages Expectation")
        
        languageCoreDataStorage.createLanguages(Constants_For_Tests.mockedLanguages) { createResult in
            
            switch createResult {
            
            case .success(let createLanguages):
                
                XCTAssertTrue(createLanguages.count == Constants_For_Tests.mockedLanguages.count)
                expectation.fulfill()
                
            case .failure:
                XCTExpectFailure()
                expectation.fulfill()
            }
            
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Read_All_Languages() {
        
        let expectation = XCTestExpectation(description: "Read All Languages Expectation")
        
        languageCoreDataStorage.createLanguages(Constants_For_Tests.mockedLanguages) { [unowned self] createResult in
            
            switch createResult {
            
            case .success(let createLanguages):
                
                XCTAssertTrue(createLanguages.count == Constants_For_Tests.mockedLanguages.count)
                
                self.languageCoreDataStorage.readAllLanguages { readResult in
                    
                    switch readResult {
                    
                    case .success(let readLanguages):
                        
                        XCTAssertTrue(readLanguages.count == createLanguages.count)
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
    
    func test_Delete_All_Languages() {
        
        let expectation = XCTestExpectation(description: "Delete All Languages Expectation")
        
        languageCoreDataStorage.createLanguages(Constants_For_Tests.mockedLanguages) { [unowned self] createResult in
            
            switch createResult {
            
            case .success(let createLanguages):
                
                XCTAssertTrue(createLanguages.count == Constants_For_Tests.mockedLanguages.count)
                
                self.languageCoreDataStorage.deleteAllLanguages { [unowned self] deleteResult in
                    
                    switch deleteResult {
                    
                    case .success:
                        
                        self.languageCoreDataStorage.entitiesIsEmpty { entitiesIsEmptyResult in
                            
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
