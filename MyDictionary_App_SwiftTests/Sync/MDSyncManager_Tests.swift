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
        
        let operationQueueService: OperationQueueServiceProtocol = OperationQueueService.init(operationQueue: operationQueue)                
        
        let coreDataStack: MDCoreDataStack = TestCoreDataStack.init()
        
        let apiJWT: MDAPIJWTProtocol = MDAPIJWT.init(requestDispatcher: requestDispatcher,
                                                     operationQueueService: operationQueueService)
        self.apiJWT = apiJWT
        
        self.syncManager = MDSyncManager.init(sync: MDSync.init(apiJWT: apiJWT,
                                                                jwtStorage: MDJWTStorage.init(memoryStorage: MDJWTMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                                                                     array: .init()),
                                                                                              coreDataStorage: MDJWTCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                                                                         managedObjectContext: coreDataStack.privateContext,
                                                                                                                                         coreDataStack: coreDataStack)),
                                                                apiUser: MDAPIUser.init(requestDispatcher: requestDispatcher,
                                                                                        operationQueueService: operationQueueService),
                                                                userStorage: MDUserStorage.init(memoryStorage: MDUserMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                                                                        array: .init()),
                                                                                                coreDataStorage: MDUserCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                                                                            managedObjectContext: coreDataStack.privateContext,
                                                                                                                                            coreDataStack: coreDataStack)),
                                                                apiLanguage: MDAPILanguage.init(requestDispatcher: requestDispatcher,
                                                                                                operationQueueService: operationQueueService),
                                                                languageStorage: MDLanguageStorage.init(memoryStorage: MDLanguageMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                                                                                    array: .init()),
                                                                                                        coreDataStorage: MDLanguageCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                                                                                        managedObjectContext: coreDataStack.privateContext,
                                                                                                                                                        coreDataStack: coreDataStack)),
                                                                apiCourse: MDAPICourse.init(requestDispatcher: requestDispatcher,
                                                                                            operationQueueService: operationQueueService),
                                                                courseStorage: MDCourseStorage.init(memoryStorage: MDCourseMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                                                                              array: .init()),
                                                                                                    coreDataStorage: MDCourseCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                                                                                  managedObjectContext: coreDataStack.privateContext,
                                                                                                                                                  coreDataStack: coreDataStack)),
                                                                apiWord: MDAPIWord.init(requestDispatcher: requestDispatcher,
                                                                                        operationQueueService: operationQueueService),
                                                                wordStorage: MDWordStorage.init(memoryStorage: MDWordMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                                                                        arrayWords: .init()),
                                                                                                coreDataStorage: MDWordCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                                                                            managedObjectContext: coreDataStack.privateContext,
                                                                                                                                            coreDataStack: coreDataStack))))
        
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
