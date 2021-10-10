//
//  MDSyncManager_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 16.09.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDSyncManager_Tests: XCTestCase {
    
    fileprivate var syncManager: MDSyncManagerProtocol!
    fileprivate var apiJWT: MDAPIJWTProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let requestDispatcher: MDRequestDispatcherProtocol = MDConstants.RequestDispatcher.defaultRequestDispatcher(reachability: .init())
        
        let coreDataStack: MDCoreDataStack = TestCoreDataStack.init()
        
        let apiJWT: MDAPIJWTProtocol = MDAPIJWT.init(requestDispatcher: requestDispatcher,
                                                     operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.jwtAPIOperationQueue)!)
        self.apiJWT = apiJWT
        
        let jwtStorage: MDJWTStorageProtocol = MDJWTStorage.init(memoryStorage: MDJWTMemoryStorage.init(operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.jwtMemoryStorageOperationQueue)!,
                                                                                                        array: .init()),
                                                                 coreDataStorage: MDJWTCoreDataStorage.init(operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.jwtCoreDataStorageOperationQueue)!,
                                                                                                            managedObjectContext: coreDataStack.privateContext,
                                                                                                            coreDataStack: coreDataStack))
        
        let userStorage: MDUserStorageProtocol = MDUserStorage.init(memoryStorage: MDUserMemoryStorage.init(operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.userMemoryStorageOperationQueue)!,
                                                                                                            array: .init()),
                                                                    coreDataStorage: MDUserCoreDataStorage.init(operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.userCoreDataStorageOperationQueue)!,
                                                                                                                managedObjectContext: coreDataStack.privateContext,
                                                                                                                coreDataStack: coreDataStack))
        
        let languageStorage: MDLanguageStorageProtocol = MDLanguageStorage.init(memoryStorage: MDLanguageMemoryStorage.init(operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.languageMemoryStorageOperationQueue)!,
                                                                                                                            array: .init()),
                                                                                coreDataStorage: MDLanguageCoreDataStorage.init(operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.languageCoreDataStorageOperationQueue)!,
                                                                                                                                managedObjectContext: coreDataStack.privateContext,
                                                                                                                                coreDataStack: coreDataStack))
        
        let courseStorage: MDCourseStorageProtocol = MDCourseStorage.init(memoryStorage: MDCourseMemoryStorage.init(operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.courseMemoryStorageOperationQueue)!,
                                                                                                                    array: .init()),
                                                                          coreDataStorage: MDCourseCoreDataStorage.init(operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.courseCoreDataStorageOperationQueue)!,
                                                                                                                        managedObjectContext: coreDataStack.privateContext,
                                                                                                                        coreDataStack: coreDataStack))
        
        let wordStorage: MDWordStorageProtocol = MDWordStorage.init(memoryStorage: MDWordMemoryStorage.init(operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.wordMemoryStorageOperationQueue)!,
                                                                                                            array: .init()),
                                                                    coreDataStorage: MDWordCoreDataStorage.init(operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.wordCoreDataStorageOperationQueue)!,
                                                                                                                managedObjectContext: coreDataStack.privateContext,
                                                                                                                coreDataStack: coreDataStack))
        
        self.syncManager = MDSyncManager.init(sync: MDSync.init(apiJWT: apiJWT,
                                                                jwtStorage: jwtStorage,
                                                                apiUser: MDAPIUser.init(requestDispatcher: requestDispatcher,
                                                                                        operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.userAPIOperationQueue)!),
                                                                userStorage: userStorage,
                                                                apiLanguage: MDAPILanguage.init(requestDispatcher: requestDispatcher,
                                                                                                operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.languageAPIOperationQueue)!),
                                                                languageStorage: languageStorage,
                                                                apiCourse: MDAPICourse.init(requestDispatcher: requestDispatcher,
                                                                                            operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.courseAPIOperationQueue)!),
                                                                courseStorage: courseStorage,
                                                                apiWord: MDAPIWord.init(requestDispatcher: requestDispatcher,
                                                                                        operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.wordAPIOperationQueue)!),
                                                                wordStorage: wordStorage,
                                                                
                                                                storageCleanupService: MDStorageCleanupService.init(jwtStorage: jwtStorage,
                                                                                                                    userStorage: userStorage,
                                                                                                                    languageStorage: languageStorage,
                                                                                                                    courseStorage: courseStorage,
                                                                                                                    wordStorage: wordStorage,
                                                                                                                    operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.storageCleanupServiceOperationQueue)!)))
        
    }
    
}

// MARK: - Tests
extension MDSyncManager_Tests {
    
    func test_Full_Sync() {
        
        let expectation = XCTestExpectation(description: "Full Sync Expectation")
        
        apiJWT.accessToken(jwtApiRequest: Constants_For_Tests.jwtApiRequest) { [unowned self] (jwtResult) in
            
            switch jwtResult {
                
            case .success(let jwtResponse):
                
                syncManager.startFullSync(withSyncItem: Constants_For_Tests.syncItem(accessToken: jwtResponse.accessToken)) { progress in
                    
                    debugPrint(#function, Self.self, "progress: ", progress)
                    
                } completionHandler: { result in
                    
                    switch result {
                        
                    case .success:
                        
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
    
    func test_JWT_And_User_And_Language_Sync() {
        
        let expectation = XCTestExpectation(description: "JWT And User And Language Sync Expectation")
        
        apiJWT.accessToken(jwtApiRequest: Constants_For_Tests.jwtApiRequest) { [unowned self] (jwtResult) in
            
            switch jwtResult {
                
            case .success(let jwtResponse):
                
                syncManager.startWithJWTAndUserAndLanguageSync(withSyncItem: Constants_For_Tests.syncItem(accessToken: jwtResponse.accessToken)) { progress in
                    
                    debugPrint(#function, Self.self, "progress: ", progress)
                    
                } completionHandler: { result in
                    
                    switch result {
                        
                    case .success:
                        
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
