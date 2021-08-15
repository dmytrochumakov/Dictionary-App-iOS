//
//  MDWordStorage_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 13.07.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDWordStorage_Tests: XCTestCase {
    
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
        let storageType: MDStorageType = .memory
        
        wordStorage.createWord(Constants_For_Tests.mockedWord0, storageType: storageType) { [unowned self] result in
            switch result {
            case .success(let createdWord):
                XCTAssertTrue(createdWord.id == Constants_For_Tests.mockedWord0.id)
                XCTAssertTrue(createdWord.word == Constants_For_Tests.mockedWord0.word)
                XCTAssertTrue(createdWord.word_description == Constants_For_Tests.mockedWord0.word_description)
                XCTAssertTrue(createdWord.word_language == Constants_For_Tests.mockedWord0.word_language)
                XCTAssertTrue(createdWord.created_at == Constants_For_Tests.mockedWord0.created_at)
                XCTAssertTrue(createdWord.updated_at == Constants_For_Tests.mockedWord0.updated_at)                
                expectation.fulfill()
            case .failure:
                XCTExpectFailure()
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Read_One_Created_Word_From_Memory_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read One Created Word From Memory Expectation")
        let storageType: MDStorageType = .memory
        
        wordStorage.createWord(Constants_For_Tests.mockedWord0, storageType: storageType) { [unowned self] result in
            switch result {
            case .success(let createdWord):
                XCTAssertTrue(createdWord.id == Constants_For_Tests.mockedWord0.id)
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
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Update_One_Created_Word_Memory_Word_String_And_Word_Description_String_Functionality() {
        
        let expectation = XCTestExpectation(description: "Update One Created Word In Memory Expectation")
        let storageType: MDStorageType = .memory
        
        wordStorage.createWord(Constants_For_Tests.mockedWord0, storageType: storageType) { [unowned self] createResult in
            switch createResult {
            case .success(let createdWord):
                self.wordStorage.updateWord(byID: createdWord.id,
                                            word: Constants_For_Tests.mockedWordForUpdate.word,
                                            word_description: Constants_For_Tests.mockedWordForUpdate.word_description,
                                            storageType: storageType, { [unowned self] updateResult in
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
    
    func test_Delete_One_Created_Word_From_Memory_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete One Created Word From Memory Expectation")
        let storageType: MDStorageType = .memory
        
        wordStorage.createWord(Constants_For_Tests.mockedWord0, storageType: storageType) { [unowned self] createResult in
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
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
}

// MARK: - Core Data CRUD
extension MDWordStorage_Tests {
    
    func test_Create_One_Word_Into_Core_Data_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create One Word Into Core Data Expectation")
        let storageType: MDStorageType = .coreData
        
        wordStorage.createWord(Constants_For_Tests.mockedWord0, storageType: storageType) { [unowned self] result in
            switch result {
            case .success(let createdWord):
                XCTAssertTrue(createdWord.id == Constants_For_Tests.mockedWord0.id)
                XCTAssertTrue(createdWord.word == Constants_For_Tests.mockedWord0.word)
                XCTAssertTrue(createdWord.word_description == Constants_For_Tests.mockedWord0.word_description)
                XCTAssertTrue(createdWord.word_language == Constants_For_Tests.mockedWord0.word_language)
                XCTAssertTrue(createdWord.created_at == Constants_For_Tests.mockedWord0.created_at)
                XCTAssertTrue(createdWord.updated_at == Constants_For_Tests.mockedWord0.updated_at)
                expectation.fulfill()
            case .failure:
                XCTExpectFailure()
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Read_One_Created_Word_From_Core_Data_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read One Created Word From Core Data Expectation")
        let storageType: MDStorageType = .coreData
        
        wordStorage.createWord(Constants_For_Tests.mockedWord0, storageType: storageType) { [unowned self] result in
            switch result {
            case .success(let createdWord):
                XCTAssertTrue(createdWord.id == Constants_For_Tests.mockedWord0.id)
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
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Update_One_Created_Word_Core_Data_Word_String_And_Word_Description_String_Functionality() {
        
        let expectation = XCTestExpectation(description: "Update One Created Word Into Core Data Expectation")
        let storageType: MDStorageType = .coreData
        
        wordStorage.createWord(Constants_For_Tests.mockedWord0, storageType: storageType) { [unowned self] createResult in
            switch createResult {
            case .success(let createdWord):
                self.wordStorage.updateWord(byID: createdWord.id,
                                            word: Constants_For_Tests.mockedWordForUpdate.word,
                                            word_description: Constants_For_Tests.mockedWordForUpdate.word_description,
                                            storageType: storageType, { [unowned self] updateResult in
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
    
    func test_Delete_One_Created_Word_From_Core_Data_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete One Created Word From Core Data Expectation")
        let storageType: MDStorageType = .coreData
        
        wordStorage.createWord(Constants_For_Tests.mockedWord0, storageType: storageType) { [unowned self] createResult in
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
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
}
