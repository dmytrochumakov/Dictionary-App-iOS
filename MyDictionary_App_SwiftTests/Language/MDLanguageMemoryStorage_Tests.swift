//
//  MDLanguageMemoryStorage_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDLanguageMemoryStorage_Tests: XCTestCase {
    
    fileprivate var languageMemoryStorage: MDLanguageMemoryStorageProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let operationQueue: OperationQueue = .init()
        let operationQueueService: OperationQueueServiceProtocol = OperationQueueService.init(operationQueue: operationQueue)
        
        let languageMemoryStorage: MDLanguageMemoryStorageProtocol = MDLanguageMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                                  array: [])
        
        self.languageMemoryStorage = languageMemoryStorage
        
    }
    
}

// MARK: - CRUD
extension MDLanguageMemoryStorage_Tests {
    
    func test_Create_Languages() {
        
        let expectation = XCTestExpectation(description: "Create Languages Expectation")
        
        languageMemoryStorage.createLanguages(Constants_For_Tests.mockedLanguages) { createResult in
            
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
        
        languageMemoryStorage.createLanguages(Constants_For_Tests.mockedLanguages) { [unowned self] createResult in
            
            switch createResult {
            
            case .success(let createLanguages):
                
                XCTAssertTrue(createLanguages.count == Constants_For_Tests.mockedLanguages.count)
                
                self.languageMemoryStorage.readAllLanguages { readResult in
                    
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
        
        languageMemoryStorage.createLanguages(Constants_For_Tests.mockedLanguages) { [unowned self] createResult in
            
            switch createResult {
            
            case .success(let createLanguages):
                
                XCTAssertTrue(createLanguages.count == Constants_For_Tests.mockedLanguages.count)
                
                self.languageMemoryStorage.deleteAllLanguages { [unowned self] deleteResult in
                    
                    switch deleteResult {
                    
                    case .success:
                        
                        self.languageMemoryStorage.entitiesIsEmpty { entitiesIsEmptyResult in
                            
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
