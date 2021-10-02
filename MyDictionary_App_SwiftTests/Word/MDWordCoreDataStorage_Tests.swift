//
//  MDWordCoreDataStorage_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDWordCoreDataStorage_Tests: XCTestCase {
    
    fileprivate var wordCoreDataStorage: MDWordCoreDataStorageProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let operationQueue: OperationQueue = .init()
        let operationQueueService: MDOperationQueueServiceProtocol = MDOperationQueueService.init(operationQueue: operationQueue)
        
        let coreDataStack: MDCoreDataStack = TestCoreDataStack()
        
        let wordCoreDataStorage: MDWordCoreDataStorageProtocol = MDWordCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                            managedObjectContext: coreDataStack.privateContext,
                                                                                            coreDataStack: coreDataStack)
        self.wordCoreDataStorage = wordCoreDataStorage
        
    }
    
}

// MARK: - Create
extension MDWordCoreDataStorage_Tests {
    
    func test_Create_One_Word_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create One Word Expectation")
        
        wordCoreDataStorage.createWord(Constants_For_Tests.mockedWord0) { [unowned self] result in
            
            switch result {
            
            case .success(let createdWord):
                
                XCTAssertTrue(createdWord.wordId == Constants_For_Tests.mockedWord0.wordId)
                
                self.wordCoreDataStorage.entitiesIsEmpty() { entitiesIsEmptyResult in
                    
                    switch entitiesIsEmptyResult {
                    
                    case .success(let entitiesIsEmpty):
                        
                        XCTAssertFalse(entitiesIsEmpty)
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
    
    func test_Create_Words_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create Words Expectation")
        
        wordCoreDataStorage.createWords(Constants_For_Tests.mockedWords) { result in
            
            switch result {
            
            case .success(let createdWords):
                
                XCTAssertTrue(createdWords.count == Constants_For_Tests.mockedWords.count)
                expectation.fulfill()
                
            case .failure:
                XCTExpectFailure()
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
}

// MARK: - Read
extension MDWordCoreDataStorage_Tests {
    
    func test_Read_One_Created_Word_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read One Created Word Expectation")
        
        wordCoreDataStorage.createWord(Constants_For_Tests.mockedWord0) { [unowned self] result in
            
            switch result {
            
            case .success(let createdWord):
                
                XCTAssertTrue(createdWord.wordId == Constants_For_Tests.mockedWord0.wordId)
                
                self.wordCoreDataStorage.readWord(fromWordID: createdWord.wordId) { result in
                    
                    switch result {
                    
                    case .success(let fetchedWord):
                        
                        XCTAssertTrue(fetchedWord.wordId == createdWord.wordId)
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

// MARK: - Update
extension MDWordCoreDataStorage_Tests {
    
    func test_Update_One_Created_Word_Word_String_And_Word_Description_String_Functionality() {
        
        let expectation = XCTestExpectation(description: "Update One Created Word Expectation")
        
        wordCoreDataStorage.createWord(Constants_For_Tests.mockedWord0) { [unowned self] createResult in
            
            switch createResult {
            
            case .success(let createdWord):
                
                self.wordCoreDataStorage.updateWord(byWordID: createdWord.wordId,
                                                    newWordText: Constants_For_Tests.mockedWordForUpdate.wordText,
                                                    newWordDescription: Constants_For_Tests.mockedWordForUpdate.wordDescription) { updateResult in
                    
                    switch updateResult {
                    
                    case .success:
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

// MARK: - Delete
extension MDWordCoreDataStorage_Tests {
    
    func test_Delete_One_Created_Word_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete One Created Word Expectation")
        
        wordCoreDataStorage.createWord(Constants_For_Tests.mockedWord0) { [unowned self] createResult in
            
            switch createResult {
            
            case .success(let createdWord):
                
                self.wordCoreDataStorage.deleteWord(byWordId: createdWord.wordId) { deleteResult in
                    
                    switch deleteResult {
                    
                    case .success:
                        
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
    
    func test_Delete_All_Words_From_Core_Data_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete All Words From Core Data Expectation")        
        
        wordCoreDataStorage.createWord(Constants_For_Tests.mockedWord0) { [unowned self] createResult in
            
            switch createResult {
            
            case .success:
                
                self.wordCoreDataStorage.deleteAllWords() { deleteResult in
                    
                    switch deleteResult {
                    
                    case .success:
                        
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
