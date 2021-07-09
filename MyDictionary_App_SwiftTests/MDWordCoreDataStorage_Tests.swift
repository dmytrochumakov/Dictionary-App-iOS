//
//  MDWordCoreDataStorage_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDWordCoreDataStorage_Tests: XCTestCase {
    
    fileprivate static let testTimeout: TimeInterval = 20.0
    
    fileprivate static let mockedWord0: WordModel = .init(uuid: .init(),
                                                          word: "MOSF",
                                                          wordDescription: "metal–oxide–semiconductor-field",
                                                          wordLanguage: "English",
                                                          createdDate: .init(),
                                                          updatedDate: .init())
    
    fileprivate static let mockedWordForUpdate: WordModel = .init(uuid: .init(),
                                                                  word: "MOSFC",
                                                                  wordDescription: "metal–oxide–semiconductor-field-c",
                                                                  wordLanguage: "Spanish",
                                                                  createdDate: .init(),
                                                                  updatedDate: .init())
    
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
        
        wordCoreDataStorage.createWord(Self.mockedWord0) { [unowned self] result in
            switch result {
            case .success(let createdWord):
                XCTAssertTrue(createdWord.uuid == Self.mockedWord0.uuid)
                self.wordCoreDataStorage.readWords(fetchLimit: .zero, fetchOffset: .zero) { readResult in
                    switch readResult {
                    case .success(let readWords):
                        XCTAssertTrue(readWords.count == 1)
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
        
        wait(for: [expectation], timeout: Self.testTimeout)
        
    }
    
}

// MARK: - Read
extension MDWordCoreDataStorage_Tests {
    
    func test_Read_One_Created_Word_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read One Created Word Expectation")
        
        wordCoreDataStorage.createWord(Self.mockedWord0) { [unowned self] result in
            switch result {
            case .success(let createdWord):
                XCTAssertTrue(createdWord.uuid == Self.mockedWord0.uuid)
                self.wordCoreDataStorage.readWord(fromUUID: createdWord.uuid, { [unowned self] result in
                    switch result {
                    case .success(let fetchedWord):
                        XCTAssertTrue(fetchedWord.uuid == createdWord.uuid)
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
        
        wait(for: [expectation], timeout: Self.testTimeout)
        
    }
    
}

// MARK: - Update
extension MDWordCoreDataStorage_Tests {
    
    func test_Update_One_Created_Word_Word_String_And_Word_Description_String_Functionality() {
        
        let expectation = XCTestExpectation(description: "Update One Created Word Expectation")
        
        wordCoreDataStorage.createWord(Self.mockedWord0) { [unowned self] createResult in
            switch createResult {
            case .success(let createdWord):
                self.wordCoreDataStorage.updateWord(byUUID: createdWord.uuid,
                                                    word: Self.mockedWordForUpdate.word,
                                                    wordDescription: Self.mockedWordForUpdate.wordDescription, { [unowned self] updateResult in
                                                        switch updateResult {
                                                        case .success(let updatedWord):
                                                            XCTAssertTrue(updatedWord.word == Self.mockedWordForUpdate.word)
                                                            XCTAssertTrue(updatedWord.wordDescription == Self.mockedWordForUpdate.wordDescription)
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
        
        wait(for: [expectation], timeout: Self.testTimeout)
        
    }
    
}

// MARK: - Delete
extension MDWordCoreDataStorage_Tests {
    
    func test_Delete_One_Created_Word_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete One Created Word Expectation")
        
        wordCoreDataStorage.createWord(Self.mockedWord0) { [unowned self] createResult in
            switch createResult {
            case .success(let createdWord):
                self.wordCoreDataStorage.deleteWord(createdWord, { [unowned self] deleteResult in
                    switch deleteResult {
                    case .success:
                        self.wordCoreDataStorage.readWords(fetchLimit: .zero, fetchOffset: .zero) { [unowned self] readResult  in
                            switch readResult {
                            case .success(let readWords):
                                XCTAssertTrue(readWords.count == .zero)
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
        
        wait(for: [expectation], timeout: Self.testTimeout)
        
    }
    
}
