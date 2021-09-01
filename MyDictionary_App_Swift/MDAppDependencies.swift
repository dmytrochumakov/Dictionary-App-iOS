//
//  MDAppDependencies.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 07.07.2021.
//

import UIKit
import Firebase
import Reachability

protocol MDAppDependenciesProtocol {
    
    var rootWindow: UIWindow! { get set }
    var reachability: Reachability! { get }
    var operationQueue: OperationQueue! { get }
    var operationQueueService: OperationQueueServiceProtocol! { get }
    var coreDataStack: CoreDataStack! { get }
    
    // API //
    var apiJWT: MDAPIJWTProtocol! { get }
    var apiUser: MDAPIUserProtocol! { get }
    var apiLanguage: MDAPILanguageProtocol! { get }
    var apiCourse: MDAPICourseProtocol! { get }
    var apiWord: MDAPIWordProtocol! { get }
    // End API //
    
    // Storage //
    var jwtStorage: MDJWTStorageProtocol! { get }
    var userStorage: MDUserStorageProtocol! { get }
    var languageStorage: MDLanguageStorageProtocol! { get }
    var courseStorage: MDCourseStorageProtocol! { get }
    var wordStorage: MDWordStorageProtocol! { get }
    // End Storage
    
    var appSettings: AppSettingsProtocol! { get }
    
}

final class MDAppDependencies: NSObject,
                               MDAppDependenciesProtocol {
    
    var rootWindow: UIWindow!
    var reachability: Reachability!
    var operationQueue: OperationQueue!
    var operationQueueService: OperationQueueServiceProtocol!
    var coreDataStack: CoreDataStack!
    
    // API //
    var apiJWT: MDAPIJWTProtocol!
    var apiUser: MDAPIUserProtocol!
    var apiLanguage: MDAPILanguageProtocol!
    var apiCourse: MDAPICourseProtocol!
    var apiWord: MDAPIWordProtocol!
    // End API //
    
    // Storage //
    var jwtStorage: MDJWTStorageProtocol!
    var userStorage: MDUserStorageProtocol!
    var languageStorage: MDLanguageStorageProtocol!
    var courseStorage: MDCourseStorageProtocol!
    var wordStorage: MDWordStorageProtocol!
    // End Storage //
    
    var appSettings: AppSettingsProtocol!
    
    override init() {
        super.init()
        configureDependencies()
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDAppDependencies {
    
    func configureDependencies() {
        
        guard let reachability = try? Reachability.init() else { fatalError("Impossible initialize Reachability Service") }
        self.reachability = reachability
        //
        let operationQueue: OperationQueue = .init()
        self.operationQueue = operationQueue
        //
        let operationQueueService: OperationQueueServiceProtocol = OperationQueueService.init(operationQueue: operationQueue)
        self.operationQueueService = operationQueueService
        //
        let coreDataStack: CoreDataStack = .init()
        self.coreDataStack = coreDataStack        
        //
        let requestDispatcher: MDRequestDispatcherProtocol = Constants.RequestDispatcher.defaultRequestDispatcher(reachability: reachability)
        //
        
        
        // API //
        let apiJWT: MDAPIJWTProtocol = MDAPIJWT.init(requestDispatcher: requestDispatcher,
                                                     operationQueueService: operationQueueService)
        self.apiJWT = apiJWT
        //
        let apiUser: MDAPIUserProtocol = MDAPIUser.init(requestDispatcher: requestDispatcher,
                                                        operationQueueService: operationQueueService)
        self.apiUser = apiUser
        //
        let apiLanguage: MDAPILanguageProtocol = MDAPILanguage.init(requestDispatcher: requestDispatcher,
                                                                    operationQueueService: operationQueueService)
        self.apiLanguage = apiLanguage
        //
        let apiCourse: MDAPICourseProtocol = MDAPICourse.init(requestDispatcher: requestDispatcher,
                                                              operationQueueService: operationQueueService)
        self.apiCourse = apiCourse
        //
        let apiWord: MDAPIWordProtocol = MDAPIWord.init(requestDispatcher: requestDispatcher,
                                                        operationQueueService: operationQueueService)
        self.apiWord = apiWord
        //
        // END API //
        
        
        // Storage //
        // JWT //
        let jwtMemoryStorage: MDJWTMemoryStorageProtocol = MDJWTMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                   array: .init())
        
        let jwtCoreDataStorage: MDJWTCoreDataStorageProtocol = MDJWTCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                         managedObjectContext: coreDataStack.privateContext,
                                                                                         coreDataStack: coreDataStack)
        
        let jwtStorage: MDJWTStorageProtocol = MDJWTStorage.init(memoryStorage: jwtMemoryStorage,
                                                                 coreDataStorage: jwtCoreDataStorage)
        
        self.jwtStorage = jwtStorage
        // End JWT //
        
        // User //
        let userMemoryStorage: MDUserMemoryStorageProtocol = MDUserMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                      array: .init())
        
        let userCoreDataStorage: MDUserCoreDataStorageProtocol = MDUserCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                            managedObjectContext: coreDataStack.privateContext,
                                                                                            coreDataStack: coreDataStack)
        
        let userStorage: MDUserStorageProtocol = MDUserStorage.init(memoryStorage: userMemoryStorage,
                                                                    coreDataStorage: userCoreDataStorage)
        
        self.userStorage = userStorage
        // End User //
        
        // Language //
        let languageMemoryStorage: MDLanguageMemoryStorageProtocol = MDLanguageMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                                  array: .init())
        
        let languageCoreDataStorage: MDLanguageCoreDataStorageProtocol = MDLanguageCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                                        managedObjectContext: coreDataStack.privateContext,
                                                                                                        coreDataStack: coreDataStack)
        
        let languageStorage: MDLanguageStorageProtocol = MDLanguageStorage.init(memoryStorage: languageMemoryStorage,
                                                                                coreDataStorage: languageCoreDataStorage)
        
        self.languageStorage = languageStorage
        // End Language //
        
        // Language //
        let courseMemoryStorage: MDCourseMemoryStorageProtocol = MDCourseMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                            array: .init())
        
        let courseCoreDataStorage: MDCourseCoreDataStorageProtocol = MDCourseCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                                  managedObjectContext: coreDataStack.privateContext,
                                                                                                  coreDataStack: coreDataStack)
        
        let courseStorage: MDCourseStorageProtocol = MDCourseStorage.init(memoryStorage: courseMemoryStorage,
                                                                          coreDataStorage: courseCoreDataStorage)
        
        self.courseStorage = courseStorage
        // End Language //
        
        // Word //
        let wordMemoryStorage: MDWordMemoryStorageProtocol = MDWordMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                      arrayWords: .init())
        
        let wordCoreDataStorage: MDWordCoreDataStorageProtocol = MDWordCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                            managedObjectContext: coreDataStack.privateContext,
                                                                                            coreDataStack: coreDataStack)
        
        let wordStorage: MDWordStorageProtocol = MDWordStorage.init(memoryStorage: wordMemoryStorage,
                                                                    coreDataStorage: wordCoreDataStorage)
        
        self.wordStorage = wordStorage
        // End Word //
        // End Storage //        
        
        let userDefaults: UserDefaults = .standard
        let appSettings: AppSettingsProtocol = AppSettings.init(userDefaults:userDefaults )
        self.appSettings = appSettings
        
        // Configure FirebaseApp
        FirebaseApp.configure()
        
    }
    
}
