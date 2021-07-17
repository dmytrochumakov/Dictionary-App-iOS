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
        let operationQueueService: OperationQueueServiceProtocol = OperationQueueService.init(operationQueue: operationQueue)
        
        let coreDataStack: CoreDataStack = TestCoreDataStack()
        
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
                XCTAssertTrue(createdWord.id == Constants_For_Tests.mockedWord0.id)
                self.wordCoreDataStorage.wordsCount() { [unowned self] wordsCountResult in
                    switch wordsCountResult {
                    case .success(let count):
                        XCTAssertTrue(count == 1)
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

// MARK: - Read
extension MDWordCoreDataStorage_Tests {
    
    func test_Read_One_Created_Word_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read One Created Word Expectation")
        
        wordCoreDataStorage.createWord(Constants_For_Tests.mockedWord0) { [unowned self] result in
            switch result {
            case .success(let createdWord):
                XCTAssertTrue(createdWord.id == Constants_For_Tests.mockedWord0.id)
                self.wordCoreDataStorage.readWord(fromID: createdWord.id, { [unowned self] result in
                    switch result {
                    case .success(let fetchedWord):
                        XCTAssertTrue(fetchedWord.id == createdWord.id)
                        expectation.fulfill()
                    case .failure:
                        XCTExpectFailure()
                        expectation.fulfill()
                    }
                })
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
                self.wordCoreDataStorage.updateWord(byID: createdWord.id,
                                                    word: Constants_For_Tests.mockedWordForUpdate.word,
                                                    word_description: Constants_For_Tests.mockedWordForUpdate.word_description, { [unowned self] updateResult in
                                                        switch updateResult {
                                                        case .success(let updatedWord):
                                                            XCTAssertTrue(updatedWord.word == Constants_For_Tests.mockedWordForUpdate.word)
                                                            XCTAssertTrue(updatedWord.word_description == Constants_For_Tests.mockedWordForUpdate.word_description)
                                                            expectation.fulfill()
                                                        case .failure:
                                                            XCTExpectFailure()
                                                            expectation.fulfill()
                                                        }
                                                    })
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
                self.wordCoreDataStorage.deleteWord(createdWord, { [unowned self] deleteResult in
                    switch deleteResult {
                    case .success:
                        self.wordCoreDataStorage.wordsCount() { [unowned self] wordsCountResult in
                            switch wordsCountResult {
                            case .success(let count):
                                XCTAssertTrue(count == .zero)
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
                })
            case .failure:
                XCTExpectFailure()
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
}
