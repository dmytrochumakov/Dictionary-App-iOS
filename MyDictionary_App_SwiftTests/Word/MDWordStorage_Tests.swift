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
        
        wordStorage.createWord(Constants_For_Tests.mockedWord0, storageType: storageType) { [unowned self] results in
            
            switch results.first!.result {
            
            case .success(let createdWord):
                
                XCTAssertTrue(createdWord.wordId == Constants_For_Tests.mockedWord0.wordId)
                XCTAssertTrue(createdWord.wordText == Constants_For_Tests.mockedWord0.wordText)
                XCTAssertTrue(createdWord.wordDescription == Constants_For_Tests.mockedWord0.wordDescription)
                XCTAssertTrue(createdWord.languageName == Constants_For_Tests.mockedWord0.languageName)
                XCTAssertTrue(createdWord.createdAt == Constants_For_Tests.mockedWord0.createdAt)
                XCTAssertTrue(createdWord.updatedAt == Constants_For_Tests.mockedWord0.updatedAt)
                
                wordStorage.entitiesCount(storageType: storageType) { entitiesCountResults in
                    
                    switch entitiesCountResults.first!.result {
                    
                    case .success(let entitiesCount):
                        
                        XCTAssertTrue(entitiesCount == 1)
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
    
    func test_Read_One_Created_Word_From_Memory_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read One Created Word From Memory Expectation")
        let storageType: MDStorageType = .memory
        
        wordStorage.createWord(Constants_For_Tests.mockedWord0, storageType: storageType) { [unowned self] createResults in
            
            switch createResults.first!.result {
            
            case .success(let createdWord):
                
                XCTAssertTrue(createdWord.wordId == Constants_For_Tests.mockedWord0.wordId)
                
                self.wordStorage.readWord(fromWordID: createdWord.wordId, storageType: storageType) { readResults in
                    
                    switch readResults.first!.result {
                    
                    case .success(let readWord):
                        
                        XCTAssertTrue(readWord.wordId == createdWord.wordId)
                        XCTAssertTrue(readWord.wordText == createdWord.wordText)
                        XCTAssertTrue(readWord.wordDescription == createdWord.wordDescription)
                        XCTAssertTrue(readWord.languageName == createdWord.languageName)
                        XCTAssertTrue(readWord.createdAt == createdWord.createdAt)
                        XCTAssertTrue(readWord.updatedAt == createdWord.updatedAt)
                        
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
    
    func test_Update_One_Created_Word_Memory_Word_String_And_Word_Description_String_Functionality() {
        
        let expectation = XCTestExpectation(description: "Update One Created Word In Memory Expectation")
        let storageType: MDStorageType = .memory
        
        wordStorage.createWord(Constants_For_Tests.mockedWord0, storageType: storageType) { [unowned self] createResults in
            
            switch createResults.first!.result {
            
            case .success(let createdWord):
                
                self.wordStorage.updateWord(byWordID: createdWord.wordId,
                                            newWordText: Constants_For_Tests.mockedWordForUpdate.wordText,
                                            newWordDescription: Constants_For_Tests.mockedWordForUpdate.wordDescription,
                                            storageType: storageType) { updateResults in
                    
                    switch updateResults.first!.result {
                    
                    case .success(let updatedWord):
                        
                        XCTAssertTrue(updatedWord.wordText == Constants_For_Tests.mockedWordForUpdate.wordText)
                        XCTAssertTrue(updatedWord.wordDescription == Constants_For_Tests.mockedWordForUpdate.wordDescription)
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
    
    func test_Delete_One_Created_Word_From_Memory_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete One Created Word From Memory Expectation")
        let storageType: MDStorageType = .memory
        
        wordStorage.createWord(Constants_For_Tests.mockedWord0, storageType: storageType) { [unowned self] createResults in
            
            switch createResults.first!.result {
            
            case .success(let createdWord):
                
                self.wordStorage.deleteWord(createdWord,
                                            storageType: storageType, { [unowned self] deleteResults in
                                                
                                                switch deleteResults.first!.result {
                                                
                                                case .success:
                                                    
                                                    self.wordStorage.entitiesIsEmpty(storageType: storageType) { entitiesIsEmptyResults in
                                                        
                                                        switch entitiesIsEmptyResults.first!.result {
                                                        
                                                        case .success(let entitiesIsEmpty):
                                                            
                                                            XCTAssertTrue(entitiesIsEmpty)
                                                            expectation.fulfill()
                                                            
                                                        case .failure(_):
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

// MARK: - Core Data CRUD
extension MDWordStorage_Tests {
    
    func test_Create_One_Word_Into_Core_Data_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create One Word Into Core Data Expectation")
        let storageType: MDStorageType = .coreData
        
        wordStorage.createWord(Constants_For_Tests.mockedWord0, storageType: storageType) { [unowned self] createResults in
            
            switch createResults.first!.result {
            
            case .success(let createdWord):
                
                XCTAssertTrue(createdWord.wordId == Constants_For_Tests.mockedWord0.wordId)
                XCTAssertTrue(createdWord.wordText == Constants_For_Tests.mockedWord0.wordText)
                XCTAssertTrue(createdWord.wordDescription == Constants_For_Tests.mockedWord0.wordDescription)
                XCTAssertTrue(createdWord.languageName == Constants_For_Tests.mockedWord0.languageName)
                XCTAssertTrue(createdWord.createdAt == Constants_For_Tests.mockedWord0.createdAt)
                XCTAssertTrue(createdWord.updatedAt == Constants_For_Tests.mockedWord0.updatedAt)
                
                wordStorage.entitiesCount(storageType: storageType) { entitiesCountResults in
                    
                    switch entitiesCountResults.first!.result {
                    
                    case .success(let entitiesCount):
                        
                        XCTAssertTrue(entitiesCount == 1)
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
    
    func test_Read_One_Created_Word_From_Core_Data_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read One Created Word From Core Data Expectation")
        let storageType: MDStorageType = .coreData
        
        wordStorage.createWord(Constants_For_Tests.mockedWord0, storageType: storageType) { [unowned self] createResults in
            
            switch createResults.first!.result {
            
            case .success(let createdWord):
                
                XCTAssertTrue(createdWord.wordId == Constants_For_Tests.mockedWord0.wordId)
                
                self.wordStorage.readWord(fromWordID: createdWord.wordId, storageType: storageType) { readResults in
                    
                    switch readResults.first!.result {
                    
                    case .success(let readWord):
                        
                        XCTAssertTrue(readWord.wordId == createdWord.wordId)
                        XCTAssertTrue(readWord.wordText == createdWord.wordText)
                        XCTAssertTrue(readWord.wordDescription == createdWord.wordDescription)
                        XCTAssertTrue(readWord.languageName == createdWord.languageName)
                        XCTAssertTrue(readWord.createdAt == createdWord.createdAt)
                        XCTAssertTrue(readWord.updatedAt == createdWord.updatedAt)
                        
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
    
    func test_Update_One_Created_Word_Core_Data_Word_String_And_Word_Description_String_Functionality() {
        
        let expectation = XCTestExpectation(description: "Update One Created Word Into Core Data Expectation")
        let storageType: MDStorageType = .coreData
        
        wordStorage.createWord(Constants_For_Tests.mockedWord0, storageType: storageType) { [unowned self] createResults in
            
            switch createResults.first!.result {
            
            case .success(let createdWord):
                
                self.wordStorage.updateWord(byWordID: createdWord.wordId,
                                            newWordText: Constants_For_Tests.mockedWordForUpdate.wordText,
                                            newWordDescription: Constants_For_Tests.mockedWordForUpdate.wordDescription,
                                            storageType: storageType) { updateResults in
                    
                    switch updateResults.first!.result {
                    
                    case .success(let updatedWord):
                        
                        XCTAssertTrue(updatedWord.wordText == Constants_For_Tests.mockedWordForUpdate.wordText)
                        XCTAssertTrue(updatedWord.wordDescription == Constants_For_Tests.mockedWordForUpdate.wordDescription)
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
    
    func test_Delete_One_Created_Word_From_Core_Data_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete One Created Word From Core Data Expectation")
        let storageType: MDStorageType = .coreData
        
        wordStorage.createWord(Constants_For_Tests.mockedWord0, storageType: storageType) { [unowned self] createResults in
            
            switch createResults.first!.result {
            
            case .success(let createdWord):
                
                self.wordStorage.deleteWord(createdWord,
                                            storageType: storageType, { [unowned self] deleteResults in
                                                
                                                switch deleteResults.first!.result {
                                                
                                                case .success:
                                                    
                                                    self.wordStorage.entitiesIsEmpty(storageType: storageType) { entitiesIsEmptyResults in
                                                        
                                                        switch entitiesIsEmptyResults.first!.result {
                                                        
                                                        case .success(let entitiesIsEmpty):
                                                            
                                                            XCTAssertTrue(entitiesIsEmpty)
                                                            expectation.fulfill()
                                                            
                                                        case .failure(_):
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

// MARK: - All CRUD
extension MDWordStorage_Tests {
    
    func test_Create_One_Word_In_All_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create One Word In All Expectation")
        let storageType: MDStorageType = .all
        
        var resultCount: Int = .zero
        
        wordStorage.createWord(Constants_For_Tests.mockedWord0, storageType: storageType) { [unowned self] createResults in
            
            createResults.forEach { createResult in
                
                switch createResult.result {
                case .success(let createdWord):
                    
                    resultCount += 1
                    
                    XCTAssertTrue(createdWord.wordId == Constants_For_Tests.mockedWord0.wordId)
                    XCTAssertTrue(createdWord.wordText == Constants_For_Tests.mockedWord0.wordText)
                    XCTAssertTrue(createdWord.wordDescription == Constants_For_Tests.mockedWord0.wordDescription)
                    XCTAssertTrue(createdWord.languageName == Constants_For_Tests.mockedWord0.languageName)
                    XCTAssertTrue(createdWord.createdAt == Constants_For_Tests.mockedWord0.createdAt)
                    XCTAssertTrue(createdWord.updatedAt == Constants_For_Tests.mockedWord0.updatedAt)
                    
                    wordStorage.entitiesCount(storageType: createResult.storageType) { [unowned self] entitiesCountResults in
                        
                        switch entitiesCountResults.first!.result {
                        
                        case .success(let entitiesCount):
                            
                            XCTAssertTrue(entitiesCount == 1)
                            
                            if (resultCount == createResults.count) {
                                expectation.fulfill()
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
            
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Read_One_Word_From_All_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read One Word From All Expectation")
        let storageType: MDStorageType = .all
        
        var resultCount: Int = .zero
        
        wordStorage.createWord(Constants_For_Tests.mockedWord0, storageType: storageType) { [unowned self] createResults in
            
            switch createResults.first!.result {
            
            case .success(let createdWord):
                
                wordStorage.readWord(fromWordID: createdWord.wordId, storageType: storageType) { readResults in
                    
                    readResults.forEach { readResult in
                        
                        switch readResult.result {
                        case .success(let readWord):
                            
                            resultCount += 1
                            
                            XCTAssertTrue(readWord.wordId == createdWord.wordId)
                            XCTAssertTrue(readWord.wordText == createdWord.wordText)
                            XCTAssertTrue(readWord.wordDescription == createdWord.wordDescription)
                            XCTAssertTrue(readWord.languageName == createdWord.languageName)
                            XCTAssertTrue(readWord.createdAt == createdWord.createdAt)
                            XCTAssertTrue(readWord.updatedAt == createdWord.updatedAt)
                            
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
    
    func test_Update_One_Word_In_All_Functionality() {
        
        let expectation = XCTestExpectation(description: "Update One Word In All Expectation")
        let storageType: MDStorageType = .all
        
        var resultCount: Int = .zero
        
        wordStorage.createWord(Constants_For_Tests.mockedWord0, storageType: storageType) { [unowned self] createResults in
            
            switch createResults.first!.result {
            
            case .success(let createdWord):
                
                self.wordStorage.updateWord(byWordID: createdWord.wordId,
                                            newWordText: Constants_For_Tests.mockedWordForUpdate.wordText,
                                            newWordDescription: Constants_For_Tests.mockedWordForUpdate.wordDescription,
                                            storageType: storageType) { updateResults in
                    
                    updateResults.forEach { updateResult in
                        
                        switch updateResult.result {
                        case .success(let updatedWord):
                            
                            resultCount += 1
                            
                            XCTAssertTrue(updatedWord.wordText == Constants_For_Tests.mockedWordForUpdate.wordText)
                            XCTAssertTrue(updatedWord.wordDescription == Constants_For_Tests.mockedWordForUpdate.wordDescription)
                            
                            if (resultCount == updateResults.count) {
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
    
    func test_Delete_One_Word_From_All_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete One Word From All Expectation")
        let storageType: MDStorageType = .all
        
        var resultCount: Int = .zero
        
        wordStorage.createWord(Constants_For_Tests.mockedWord0, storageType: storageType) { [unowned self] createResults in
            
            switch createResults.first!.result {
            
            case .success(let createdWord):
                
                self.wordStorage.deleteWord(createdWord, storageType: storageType) { [unowned self] deleteResults in
                    
                    deleteResults.forEach { deleteResult in
                        
                        switch deleteResult.result {
                        
                        case .success(let deleteWord):
                            
                            XCTAssertTrue(createdWord.wordId == deleteWord.wordId)
                            
                            self.wordStorage.entitiesIsEmpty(storageType: deleteResult.storageType) { entitiesIsEmptyResults in
                                
                                switch entitiesIsEmptyResults.first!.result {
                                
                                case .success(let entitiesIsEmpty):
                                    
                                    resultCount += 1
                                    
                                    XCTAssertTrue(entitiesIsEmpty)
                                    
                                    if (resultCount == deleteResults.count) {
                                        expectation.fulfill()
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
                }
                
            case .failure:
                XCTExpectFailure()
                expectation.fulfill()
            }
            
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
}
