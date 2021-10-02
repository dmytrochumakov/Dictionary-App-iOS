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
        
        let requestDispatcher: MDRequestDispatcherProtocol = MDConstants.RequestDispatcher.defaultRequestDispatcher(reachability: try! .init())
        
        let operationQueue: OperationQueue = .init()
        
        let operationQueueService: MDOperationQueueServiceProtocol = MDOperationQueueService.init(operationQueue: operationQueue)
        
        let coreDataStack: MDCoreDataStack = TestCoreDataStack.init()
        
        let apiJWT: MDAPIJWTProtocol = MDAPIJWT.init(requestDispatcher: requestDispatcher,
                                                     operationQueueService: operationQueueService)
        self.apiJWT = apiJWT
        
        let jwtStorage: MDJWTStorageProtocol = MDJWTStorage.init(memoryStorage: MDJWTMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                                        array: .init()),
                                                                 coreDataStorage: MDJWTCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                                            managedObjectContext: coreDataStack.privateContext,
                                                                                                            coreDataStack: coreDataStack))
        
        let userStorage: MDUserStorageProtocol = MDUserStorage.init(memoryStorage: MDUserMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                                            array: .init()),
                                                                    coreDataStorage: MDUserCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                                                managedObjectContext: coreDataStack.privateContext,
                                                                                                                coreDataStack: coreDataStack))
        
        let languageStorage: MDLanguageStorageProtocol = MDLanguageStorage.init(memoryStorage: MDLanguageMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                                                            array: .init()),
                                                                                coreDataStorage: MDLanguageCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                                                                managedObjectContext: coreDataStack.privateContext,
                                                                                                                                coreDataStack: coreDataStack))
        
        let courseStorage: MDCourseStorageProtocol = MDCourseStorage.init(memoryStorage: MDCourseMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                                                    array: .init()),
                                                                          coreDataStorage: MDCourseCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                                                        managedObjectContext: coreDataStack.privateContext,
                                                                                                                        coreDataStack: coreDataStack))
        
        let wordStorage: MDWordStorageProtocol = MDWordStorage.init(memoryStorage: MDWordMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                                            arrayWords: .init()),
                                                                    coreDataStorage: MDWordCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                                                managedObjectContext: coreDataStack.privateContext,
                                                                                                                coreDataStack: coreDataStack))
        
        self.syncManager = MDSyncManager.init(sync: MDSync.init(apiJWT: apiJWT,
                                                                jwtStorage: jwtStorage,
                                                                apiUser: MDAPIUser.init(requestDispatcher: requestDispatcher,
                                                                                        operationQueueService: operationQueueService),
                                                                userStorage: userStorage,
                                                                apiLanguage: MDAPILanguage.init(requestDispatcher: requestDispatcher,
                                                                                                operationQueueService: operationQueueService),
                                                                languageStorage: languageStorage,
                                                                apiCourse: MDAPICourse.init(requestDispatcher: requestDispatcher,
                                                                                            operationQueueService: operationQueueService),
                                                                courseStorage: courseStorage,
                                                                apiWord: MDAPIWord.init(requestDispatcher: requestDispatcher,
                                                                                        operationQueueService: operationQueueService),
                                                                wordStorage: wordStorage,
                                                                
                                                                storageCleanupService: MDStorageCleanupService.init(jwtStorage: jwtStorage,
                                                                                                                    userStorage: userStorage,
                                                                                                                    languageStorage: languageStorage,
                                                                                                                    courseStorage: courseStorage,
                                                                                                                    wordStorage: wordStorage)))
        
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
