//
//  MDFillMemoryService_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 17.09.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDFillMemoryService_Tests: XCTestCase {
    
    fileprivate var fillMemoryService: MDFillMemoryServiceProtocol!
    
    fileprivate var jwtCoreDataStorage: MDJWTCoreDataStorageProtocol!
    fileprivate var userCoreDataStorage: MDUserCoreDataStorageProtocol!
    fileprivate var languageCoreDataStorage: MDLanguageCoreDataStorageProtocol!
    fileprivate var courseCoreDataStorage: MDCourseCoreDataStorageProtocol!
    fileprivate var wordCoreDataStorage: MDWordCoreDataStorageProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let operationQueue: OperationQueue = .init()
        
        let coreDataStack: MDCoreDataStack = TestCoreDataStack.init()
        
        let operationQueueService: MDOperationQueueServiceProtocol = MDOperationQueueService.init(operationQueue: operationQueue)
        
        self.jwtCoreDataStorage = MDJWTCoreDataStorage.init(operationQueueService: operationQueueService,
                                                            managedObjectContext: coreDataStack.privateContext,
                                                            coreDataStack: coreDataStack)
        
        self.userCoreDataStorage = MDUserCoreDataStorage.init(operationQueueService: operationQueueService,
                                                              managedObjectContext: coreDataStack.privateContext,
                                                              coreDataStack: coreDataStack)
        
        self.languageCoreDataStorage = MDLanguageCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                      managedObjectContext: coreDataStack.privateContext,
                                                                      coreDataStack: coreDataStack)
        
        self.courseCoreDataStorage = MDCourseCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                  managedObjectContext: coreDataStack.privateContext,
                                                                  coreDataStack: coreDataStack)
        
        self.wordCoreDataStorage = MDWordCoreDataStorage.init(operationQueueService: operationQueueService,
                                                              managedObjectContext: coreDataStack.privateContext,
                                                              coreDataStack: coreDataStack)
        
        self.fillMemoryService = MDFillMemoryService.init(isLoggedIn: true,
                                                          jwtStorage: MDJWTStorage.init(memoryStorage: MDJWTMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                                                               array: .init()),
                                                                                        coreDataStorage: jwtCoreDataStorage),
                                                          userStorage: MDUserStorage.init(memoryStorage: MDUserMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                                                                  array: .init()),
                                                                                          coreDataStorage: userCoreDataStorage),
                                                          languageStorage: MDLanguageStorage.init(memoryStorage: MDLanguageMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                                                                              array: .init()),
                                                                                                  coreDataStorage: languageCoreDataStorage),
                                                          courseStorage: MDCourseStorage.init(memoryStorage: MDCourseMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                                                                        array: .init()),
                                                                                              coreDataStorage: courseCoreDataStorage),
                                                          wordStorage: MDWordStorage.init(memoryStorage: MDWordMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                                                                  arrayWords: .init()),
                                                                                          coreDataStorage: wordCoreDataStorage),
                                                          bridge: MDBridge.init())
        
    }
    
}

extension MDFillMemoryService_Tests {
    
    func test_Fill_Memory() {
        
        let expectation = XCTestExpectation(description: "Fill Memory Expectation")
        
        // Initialize Dispatch Group
        let dispatchGroup: DispatchGroup = .init()
                
        // Dispatch Group Enter
        dispatchGroup.enter()
        jwtCoreDataStorage.createJWT(Constants_For_Tests.mockedJWT) { createJWTResult in
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        userCoreDataStorage.createUser(Constants_For_Tests.mockedUser,
                                       password: Constants_For_Tests.mockedUserPassword) { createUserResult in
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        languageCoreDataStorage.createLanguages(Constants_For_Tests.mockedLanguages) { createLanguagesResult in
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        courseCoreDataStorage.createCourse(Constants_For_Tests.mockedCourse) { createCourseResult in
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        wordCoreDataStorage.createWord(Constants_For_Tests.mockedWord0) { createWordResult in
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
                
        // Notify And Pass Final Result
        dispatchGroup.notify(queue: .main) {
        
            self.fillMemoryService.fillMemoryFromCoreDataIfNeeded { result in
                
                switch result {
                
                case .success:
                    
                    expectation.fulfill()
                    
                case .failure(let error):
                    XCTExpectFailure(error.localizedDescription)
                    expectation.fulfill()
                }
                
            }
            
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
}
