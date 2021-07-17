//
//  MDWordStorage_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 13.07.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDWordStorage_Tests: XCTestCase {
        
    fileprivate static let testTimeout: TimeInterval = 20.0
    
    fileprivate static let mockedWord0: WordModel = .init(id: .init(),
                                                          word: "word",
                                                          wordDescription: "wordDescription",
                                                          wordLanguage: "English",
                                                          createdDate: .init(),
                                                          updatedDate: .init())
    
    fileprivate static let mockedWordForUpdate: WordModel = .init(id: .init(),
                                                                  word: "word for update",
                                                                  wordDescription: "word for update Description",
                                                                  wordLanguage: "Spanish",
                                                                  createdDate: .init(),
                                                                  updatedDate: .init())
    
    fileprivate var wordStorage: MDWordStorageProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let operationQueue: OperationQueue = .init()
        
        let operationQueueService: OperationQueueServiceProtocol = OperationQueueService.init(operationQueue: operationQueue)
        
        let memoryStorage: MDWordMemoryStorageProtocol = MDWordMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                  arrayWords: [])
        
        let coreDataStack: CoreDataStack = CoreDataStack.init()
        let coreDataStorage: MDWordCoreDataStorageProtocol = MDWordCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                        managedObjectContext: coreDataStack.privateContext,
                                                                                        coreDataStack: coreDataStack)
        
        let wordStorage: MDWordStorageProtocol = MDWordStorage.init(memoryStorage: memoryStorage,
                                                                    coreDataStorage: coreDataStorage)
        self.wordStorage = wordStorage
        
    }
        
}

// MARK: - Memory CRUD
extension MDWordStorage_Tests {
    
    func test_Create_One_Word_In_Memory_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create One Word In Memory Expectation")
        let storageType: MDWordStorageType = .memory
        
        wordStorage.createWord(Self.mockedWord0, storageType: storageType) { [unowned self] result in
            switch result {
            case .success(let createdWord):
                XCTAssertTrue(createdWord.id == Self.mockedWord0.id)
                XCTAssertTrue(createdWord.word == Self.mockedWord0.word)
                XCTAssertTrue(createdWord.wordDescription == Self.mockedWord0.wordDescription)
                XCTAssertTrue(createdWord.wordLanguage == Self.mockedWord0.wordLanguage)
                XCTAssertTrue(createdWord.createdDate == Self.mockedWord0.createdDate)
                XCTAssertTrue(createdWord.updatedDate == Self.mockedWord0.updatedDate)
                expectation.fulfill()
            case .failure:
                XCTExpectFailure()
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: Self.testTimeout)
        
    }
    
    func test_Read_One_Created_Word_From_Memory_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read One Created Word From Memory Expectation")
        let storageType: MDWordStorageType = .memory
        
        wordStorage.createWord(Self.mockedWord0, storageType: storageType) { [unowned self] result in
            switch result {
            case .success(let createdWord):
                XCTAssertTrue(createdWord.id == Self.mockedWord0.id)
                self.wordStorage.readWord(fromID: createdWord.id, storageType: storageType, { [unowned self] result in
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
        
        wait(for: [expectation], timeout: Self.testTimeout)
        
    }
    
    func test_Update_One_Created_Word_Memory_Word_String_And_Word_Description_String_Functionality() {
        
        let expectation = XCTestExpectation(description: "Update One Created Word In Memory Expectation")
        let storageType: MDWordStorageType = .memory
        
        wordStorage.createWord(Self.mockedWord0, storageType: storageType) { [unowned self] createResult in
            switch createResult {
            case .success(let createdWord):
                self.wordStorage.updateWord(byID: createdWord.id,
                                                  word: Self.mockedWordForUpdate.word,
                                                  wordDescription: Self.mockedWordForUpdate.wordDescription,
                                                  storageType: storageType, { [unowned self] updateResult in
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
    
    func test_Delete_One_Created_Word_From_Memory_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete One Created Word From Memory Expectation")
        let storageType: MDWordStorageType = .memory
        
        wordStorage.createWord(Self.mockedWord0, storageType: storageType) { [unowned self] createResult in
            switch createResult {
            case .success(let createdWord):
                self.wordStorage.deleteWord(createdWord,
                                            storageType: storageType, { [unowned self] deleteResult in
                    switch deleteResult {
                    case .success:
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

// MARK: - Core Data CRUD
extension MDWordStorage_Tests {
    
    func test_Create_One_Word_Into_Core_Data_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create One Word Into Core Data Expectation")
        let storageType: MDWordStorageType = .coreData
        
        wordStorage.createWord(Self.mockedWord0, storageType: storageType) { [unowned self] result in
            switch result {
            case .success(let createdWord):
                XCTAssertTrue(createdWord.id == Self.mockedWord0.id)
                XCTAssertTrue(createdWord.word == Self.mockedWord0.word)
                XCTAssertTrue(createdWord.wordDescription == Self.mockedWord0.wordDescription)
                XCTAssertTrue(createdWord.wordLanguage == Self.mockedWord0.wordLanguage)
                XCTAssertTrue(createdWord.createdDate == Self.mockedWord0.createdDate)
                XCTAssertTrue(createdWord.updatedDate == Self.mockedWord0.updatedDate)
                expectation.fulfill()
            case .failure:
                XCTExpectFailure()
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: Self.testTimeout)
        
    }
    
    func test_Read_One_Created_Word_From_Core_Data_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read One Created Word From Core Data Expectation")
        let storageType: MDWordStorageType = .coreData
        
        wordStorage.createWord(Self.mockedWord0, storageType: storageType) { [unowned self] result in
            switch result {
            case .success(let createdWord):
                XCTAssertTrue(createdWord.id == Self.mockedWord0.id)
                self.wordStorage.readWord(fromID: createdWord.id, storageType: storageType, { [unowned self] result in
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
        
        wait(for: [expectation], timeout: Self.testTimeout)
        
    }
    
    func test_Update_One_Created_Word_Core_Data_Word_String_And_Word_Description_String_Functionality() {
        
        let expectation = XCTestExpectation(description: "Update One Created Word Into Core Data Expectation")
        let storageType: MDWordStorageType = .coreData
        
        wordStorage.createWord(Self.mockedWord0, storageType: storageType) { [unowned self] createResult in
            switch createResult {
            case .success(let createdWord):
                self.wordStorage.updateWord(byID: createdWord.id,
                                                  word: Self.mockedWordForUpdate.word,
                                                  wordDescription: Self.mockedWordForUpdate.wordDescription,
                                                  storageType: storageType, { [unowned self] updateResult in
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
    
    func test_Delete_One_Created_Word_From_Core_Data_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete One Created Word From Core Data Expectation")
        let storageType: MDWordStorageType = .coreData
        
        wordStorage.createWord(Self.mockedWord0, storageType: storageType) { [unowned self] createResult in
            switch createResult {
            case .success(let createdWord):
                self.wordStorage.deleteWord(createdWord,
                                            storageType: storageType, { [unowned self] deleteResult in
                    switch deleteResult {
                    case .success:
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
