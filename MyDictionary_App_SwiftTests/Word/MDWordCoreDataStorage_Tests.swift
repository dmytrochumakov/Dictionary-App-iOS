//
//  MDWordCoreDataStorage_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import XCTest
import CoreData
@testable import MyDictionary_App_Swift

final class MDWordCoreDataStorage_Tests: XCTestCase {
    
    fileprivate var managedObjectContext: NSManagedObjectContext!
    fileprivate var wordCoreDataStorage: MDWordCoreDataStorageProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let coreDataStack: MDCoreDataStack = TestCoreDataStack()
        
        self.managedObjectContext = coreDataStack.privateContext
        
        let wordCoreDataStorage: MDWordCoreDataStorageProtocol = MDWordCoreDataStorage.init(operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.wordCoreDataStorageOperationQueue)!,
                                                                                            managedObjectContext: coreDataStack.privateContext,
                                                                                            coreDataStack: coreDataStack)
        self.wordCoreDataStorage = wordCoreDataStorage
        
    }
    
}

// MARK: - Create
extension MDWordCoreDataStorage_Tests {
    
    func test_Create_One_Word_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create One Word Expectation")
        
        wordCoreDataStorage.createWord(courseUUID: Constants_For_Tests.mockedWordCourseUUID,
                                       uuid: Constants_For_Tests.mockedWordUUID,
                                       wordText: Constants_For_Tests.mockedWordText,
                                       wordDescription: Constants_For_Tests.mockedWordDescription,
                                       createdAt: Constants_For_Tests.mockedWordCreatedAt) { [unowned self] result in
            
            switch result {
                
            case .success(let createdWord):
                
                XCTAssertTrue(createdWord.wordText == Constants_For_Tests.mockedWordText)
                XCTAssertTrue(createdWord.wordDescription == Constants_For_Tests.mockedWordDescription)
                
                self.wordCoreDataStorage.readWord(byWordUUID: createdWord.uuid!) { readResult in
                    
                    switch readResult {
                        
                    case .success(let readEntity):
                        
                        XCTAssertTrue(createdWord.courseUUID == readEntity.courseUUID)
                        XCTAssertTrue(createdWord.uuid == readEntity.uuid)
                        XCTAssertTrue(createdWord.wordText == readEntity.wordText)
                        XCTAssertTrue(createdWord.wordDescription == readEntity.wordDescription)
                        XCTAssertTrue(createdWord.createdAt == readEntity.createdAt)
                        
                        expectation.fulfill()
                        
                    case .failure(let error):
                        XCTExpectFailure(error.localizedDescription)
                        expectation.fulfill()
                    }
                    
                }
                
            case .failure(let error):
                XCTExpectFailure(error.localizedDescription)
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
        
        wordCoreDataStorage.createWord(courseUUID: Constants_For_Tests.mockedWordCourseUUID,
                                       uuid: Constants_For_Tests.mockedWordUUID,
                                       wordText: Constants_For_Tests.mockedWordText,
                                       wordDescription: Constants_For_Tests.mockedWordDescription,
                                       createdAt: Constants_For_Tests.mockedWordCreatedAt) { [unowned self] result in
            
            switch result {
                
            case .success(let createdWord):
                
                XCTAssertTrue(createdWord.wordText == Constants_For_Tests.mockedWordText)
                XCTAssertTrue(createdWord.wordDescription == Constants_For_Tests.mockedWordDescription)
                
                self.wordCoreDataStorage.readWord(byWordUUID: createdWord.uuid!) { readResult in
                    
                    switch readResult {
                        
                    case .success(let readEntity):
                        
                        XCTAssertTrue(createdWord.courseUUID == readEntity.courseUUID)
                        XCTAssertTrue(createdWord.uuid == readEntity.uuid)
                        XCTAssertTrue(createdWord.wordText == readEntity.wordText)
                        XCTAssertTrue(createdWord.wordDescription == readEntity.wordDescription)
                        XCTAssertTrue(createdWord.createdAt == readEntity.createdAt)
                        
                        expectation.fulfill()
                        
                    case .failure(let error):
                        XCTExpectFailure(error.localizedDescription)
                        expectation.fulfill()
                    }
                    
                }
                
            case .failure(let error):
                XCTExpectFailure(error.localizedDescription)
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
        
        wordCoreDataStorage.createWord(courseUUID: Constants_For_Tests.mockedWordCourseUUID,
                                       uuid: Constants_For_Tests.mockedWordUUID,
                                       wordText: Constants_For_Tests.mockedWordText,
                                       wordDescription: Constants_For_Tests.mockedWordDescription,
                                       createdAt: Constants_For_Tests.mockedWordCreatedAt) { [unowned self] createResult in
            
            switch createResult {
                
            case .success(let createdWord):
                
                self.wordCoreDataStorage.updateWordTextAndWordDescription(byCourseUUID: Constants_For_Tests.mockedWordCourseUUID,
                                                                          andWordUUID: createdWord.uuid!,
                                                                          newWordText: Constants_For_Tests.mockedWordForUpdateText,
                                                                          newWordDescription: Constants_For_Tests.mockedWordForUpdateDescription) { [unowned self] updateResult in
                    
                    switch updateResult {
                        
                    case .success:
                        
                        self.wordCoreDataStorage.readWord(byWordUUID: createdWord.uuid!) { readResult in
                            
                            switch readResult {
                                
                            case .success(let readEntity):
                                
                                XCTAssertTrue(readEntity.wordText == Constants_For_Tests.mockedWordForUpdateText)
                                XCTAssertTrue(readEntity.wordDescription == Constants_For_Tests.mockedWordForUpdateDescription)
                                
                                expectation.fulfill()
                                
                            case .failure(let error):
                                XCTExpectFailure(error.localizedDescription)
                                expectation.fulfill()
                            }
                            
                        }
                        
                    case .failure(let error):
                        XCTExpectFailure(error.localizedDescription)
                        expectation.fulfill()
                    }
                }
            case .failure(let error):
                XCTExpectFailure(error.localizedDescription)
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
        
        wordCoreDataStorage.createWord(courseUUID: Constants_For_Tests.mockedWordCourseUUID,
                                       uuid: Constants_For_Tests.mockedWordUUID,
                                       wordText: Constants_For_Tests.mockedWordText,
                                       wordDescription: Constants_For_Tests.mockedWordDescription,
                                       createdAt: Constants_For_Tests.mockedWordCreatedAt) { [unowned self] createResult in
            
            switch createResult {
                
            case .success(let createdWord):
                
                wordCoreDataStorage.deleteWord(byWordUUID: createdWord.uuid!) { [unowned self] deleteResult in
                    
                    switch deleteResult {
                        
                    case .success:
                        
                        wordCoreDataStorage.exists(byCourseUUID: createdWord.courseUUID!,
                                                   andWordText: createdWord.wordText!) { existsResult in
                            
                            switch existsResult {
                                
                            case .success(let exists):
                                
                                XCTAssertFalse(exists)
                                
                                expectation.fulfill()
                                
                            case .failure(let error):
                                XCTExpectFailure(error.localizedDescription)
                                expectation.fulfill()
                            }
                            
                        }
                        
                    case .failure(let error):
                        XCTExpectFailure(error.localizedDescription)
                        expectation.fulfill()
                    }
                }
            case .failure(let error):
                XCTExpectFailure(error.localizedDescription)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Delete_All_Words_From_Core_Data_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete All Words From Core Data Expectation")
        
        wordCoreDataStorage.createWord(courseUUID: Constants_For_Tests.mockedWordCourseUUID,
                                       uuid: Constants_For_Tests.mockedWordUUID,
                                       wordText: Constants_For_Tests.mockedWordText,
                                       wordDescription: Constants_For_Tests.mockedWordDescription,
                                       createdAt: Constants_For_Tests.mockedWordCreatedAt) { [unowned self] createResult in
            
            switch createResult {
                
            case .success:
                
                wordCoreDataStorage.deleteAllWords() { [unowned self] deleteResult in
                    
                    switch deleteResult {
                        
                    case .success:
                        
                        wordCoreDataStorage.entitiesIsEmpty { isEmptyResult in
                            
                            switch isEmptyResult {
                                
                            case .success(let isEmpty):
                                
                                XCTAssertTrue(isEmpty)
                                
                                expectation.fulfill()
                                
                            case .failure(let error):
                                XCTExpectFailure(error.localizedDescription)
                                expectation.fulfill()
                            }
                            
                        }
                        
                    case .failure(let error):
                        XCTExpectFailure(error.localizedDescription)
                        expectation.fulfill()
                    }
                }
                
            case .failure(let error):
                XCTExpectFailure(error.localizedDescription)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
}
