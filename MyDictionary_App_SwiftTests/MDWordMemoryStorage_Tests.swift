//
//  MDWordMemoryStorage_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDWordMemoryStorage_Tests: XCTestCase {
    
    fileprivate static let testTimeout: TimeInterval = 20.0
    
    fileprivate static let mockedWord0: WordModel = .init(uuid: .init(),
                                                          word: "word",
                                                          wordDescription: "wordDescription",
                                                          wordLanguage: "English",
                                                          createdDate: .init(),
                                                          updatedDate: .init())
    
    fileprivate static let mockedWordForUpdate: WordModel = .init(uuid: .init(),
                                                                  word: "word for update",
                                                                  wordDescription: "word for update Description",
                                                                  wordLanguage: "Spanish",
                                                                  createdDate: .init(),
                                                                  updatedDate: .init())
    
    fileprivate var wordMemoryStorage: MDWordMemoryStorageProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let operationQueue: OperationQueue = .init()
        let operationQueueService: OperationQueueServiceProtocol = OperationQueueService.init(operationQueue: operationQueue)
        let arrayWords: [WordModel] = []
        let wordMemoryStorage: MDWordMemoryStorageProtocol = MDWordMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                      arrayWords: arrayWords)
        self.wordMemoryStorage = wordMemoryStorage
    }
    
}

extension MDWordMemoryStorage_Tests {
    
    func test_Create_One_Word_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create One Word Expectation")
        
        wordMemoryStorage.createWord(Self.mockedWord0) { [unowned self] result in
            switch result {
            case .success(let createdWord):
                XCTAssertTrue(createdWord.uuid == Self.mockedWord0.uuid)
                XCTAssertTrue(self.wordMemoryStorage.arrayWordsCount == 1)
                expectation.fulfill()
            case .failure:
                XCTExpectFailure()
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: Self.testTimeout)
        
    }
    
    func test_Read_One_Created_Word_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read One Created Word Expectation")
        
        wordMemoryStorage.createWord(Self.mockedWord0) { [unowned self] result in
            switch result {
            case .success(let createdWord):
                XCTAssertTrue(createdWord.uuid == Self.mockedWord0.uuid)
                XCTAssertTrue(self.wordMemoryStorage.arrayWordsCount == 1)
                self.wordMemoryStorage.readWord(fromUUID: createdWord.uuid, { [unowned self] result in
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
    
    func test_Update_One_Created_Word_Functionality() {
        
        let expectation = XCTestExpectation(description: "Update One Created Word Expectation")
        
        wordMemoryStorage.createWord(Self.mockedWord0) { [unowned self] createResult in
            switch createResult {
            case .success(let createdWord):
                self.wordMemoryStorage.updateWord(byUUID: createdWord.uuid,
                                                  word: Self.mockedWordForUpdate, { [unowned self] updateResult in
                                                    switch updateResult {
                                                    case .success(let updatedWord):
                                                        XCTAssertTrue(updatedWord.uuid == Self.mockedWordForUpdate.uuid)
                                                        XCTAssertTrue(updatedWord.word == Self.mockedWordForUpdate.word)
                                                        XCTAssertTrue(updatedWord.wordDescription == Self.mockedWordForUpdate.wordDescription)
                                                        XCTAssertTrue(updatedWord.wordLanguage == Self.mockedWordForUpdate.wordLanguage)
                                                        XCTAssertTrue(updatedWord.createdDate == Self.mockedWordForUpdate.createdDate)
                                                        XCTAssertTrue(updatedWord.updatedDate == Self.mockedWordForUpdate.updatedDate)
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
    
    func test_Delete_One_Created_Word_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete One Created Word Expectation")
        
        wordMemoryStorage.createWord(Self.mockedWord0) { [unowned self] createResult in
            switch createResult {
            case .success(let createdWord):
                self.wordMemoryStorage.deleteWord(createdWord, { [unowned self] deleteResult in
                    switch deleteResult {
                    case .success:
                        XCTAssertTrue(self.wordMemoryStorage.arrayWordsCount == .zero)
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
