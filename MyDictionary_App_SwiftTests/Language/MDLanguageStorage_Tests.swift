//
//  MDLanguageStorage_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDLanguageStorage_Tests: XCTestCase {
    
    fileprivate var languageStorage: MDLanguageStorageProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let operationQueue: OperationQueue = .init()
        
        let operationQueueService: OperationQueueServiceProtocol = OperationQueueService.init(operationQueue: operationQueue)
        
        let memoryStorage: MDLanguageMemoryStorageProtocol = MDLanguageMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                          array: .init())
        
        let coreDataStack: MDCoreDataStack = TestCoreDataStack.init()
        
        let coreDataStorage: MDLanguageCoreDataStorageProtocol = MDLanguageCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                                managedObjectContext: coreDataStack.privateContext,
                                                                                                coreDataStack: coreDataStack)
        
        let languageStorage: MDLanguageStorageProtocol = MDLanguageStorage.init(memoryStorage: memoryStorage,
                                                                                coreDataStorage: coreDataStorage)
        
        self.languageStorage = languageStorage
        
    }
    
}

// MARK: - All CRUD
extension MDLanguageStorage_Tests {
    
    func test_Create_All_Languages() {
        
        let expectation = XCTestExpectation(description: "Create Languages In All Expectation")
        let storageType: MDStorageType = .all
        
        var resultCount: Int = .zero
        
        languageStorage.createLanguages(storageType: storageType, languageEntities: Constants_For_Tests.mockedLanguages) { createResults in
            
            createResults.forEach { createResult in
                
                switch createResult.result {
                
                case .success(let createLanguages):
                    
                    resultCount += 1
                    
                    XCTAssertTrue(createLanguages.count == Constants_For_Tests.mockedLanguages.count)
                    
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
    
    func test_Read_All_Languages() {
        
        let expectation = XCTestExpectation(description: "Read All Languages Expectation")
        let storageType: MDStorageType = .all
        
        var resultCount: Int = .zero
        
        languageStorage.createLanguages(storageType: storageType, languageEntities: Constants_For_Tests.mockedLanguages) { [unowned self] createResults in
            
            switch createResults.first!.result {
            
            case .success(let createLanguages):
                
                XCTAssertTrue(createLanguages.count == Constants_For_Tests.mockedLanguages.count)
                
                self.languageStorage.readAllLanguages(storageType: storageType) { readResults in
                    
                    readResults.forEach { readResult in
                        
                        switch readResult.result {
                        
                        case .success(let readLanguages):
                            
                            resultCount += 1
                            
                            XCTAssertTrue(createLanguages.count == readLanguages.count)
                            
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
    
    func test_Delete_All_Languages() {
        
        let expectation = XCTestExpectation(description: "Delete All Languages Expectation")
        let storageType: MDStorageType = .all
        
        var resultCount: Int = .zero
        
        languageStorage.createLanguages(storageType: storageType, languageEntities: Constants_For_Tests.mockedLanguages) { [unowned self] createResults in
            
            switch createResults.first!.result {
            
            case .success(let createLanguages):
                
                XCTAssertTrue(createLanguages.count == Constants_For_Tests.mockedLanguages.count)
                
                self.languageStorage.deleteAllLanguages(storageType: storageType) { deleteResults in
                    
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
