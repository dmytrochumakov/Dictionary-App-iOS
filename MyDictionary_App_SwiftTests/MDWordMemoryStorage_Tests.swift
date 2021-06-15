//
//  MDWordMemoryStorage_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

class MDWordMemoryStorage_Tests: XCTestCase {
    
    static let mockedWord0: WordModel = .init(uuid: .init(),
                                              word: "word",
                                              wordDescription: "wordDescription",
                                              wordLanguage: "English",
                                              createdDate: .init(),
                                              updatedDate: .init())
    
    var wordMemoryStorage: MDWordMemoryStorageProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let operationQueue: OperationQueue = .init()
        let operationQueueService: OperationQueueServiceProtocol = OperationQueueService.init(operationQueue: operationQueue)
        let arrayWords: [WordModel] = []
        let wordMemoryStorage: MDWordMemoryStorageProtocol = MDWordMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                      arrayWords: arrayWords)
        self.wordMemoryStorage = wordMemoryStorage
    }
    
    func test_Create_One_Word_Functionality() {
        wordMemoryStorage.createWord(Self.mockedWord0) { [weak self] result in
            switch result {
            case .success(let createdWord):
                XCTAssertTrue(createdWord == Self.mockedWord0)
                XCTAssertTrue(self?.wordMemoryStorage.arrayWordsCount == 1)
            case .failure:
                XCTExpectFailure()
            }
        }
    }
    
    func test_Read_One_Created_Word_Functionality() {
        wordMemoryStorage.createWord(Self.mockedWord0) { [weak self] result in
            switch result {
            case .success(let createdWord):
                XCTAssertTrue(createdWord == Self.mockedWord0)
                XCTAssertTrue(self?.wordMemoryStorage.arrayWordsCount == 1)
                self?.wordMemoryStorage.readWord(fromUUID: createdWord.uuid, { result in
                    switch result {
                    case .success(let fetchedWord):
                        XCTAssertTrue(fetchedWord == createdWord)
                    case .failure:
                        XCTExpectFailure()
                    }
                })
            case .failure:
                XCTExpectFailure()
            }
        }
    }
    
}
