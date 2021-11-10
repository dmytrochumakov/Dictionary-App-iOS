//
//  MDAppDependencies.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 07.07.2021.
//

import UIKit
import CoreData
import Firebase

protocol MDAppDependenciesProtocol {
    
    var rootWindow: UIWindow! { get set }
    var coreDataStack: MDCoreDataStack! { get }
    
    // Manager
    var operationQueueManager: MDOperationQueueManagerProtocol! { get }
    var coreDataManager: MDCoreDataManager! { get }
    var courseManager: MDCourseManagerProtocol! { get }
    var wordManager: MDWordManagerProtocol! { get }
    //
    
    // Storage //
    var courseCoreDataStorage: MDCourseCoreDataStorageProtocol! { get }
    var wordCoreDataStorage: MDWordCoreDataStorageProtocol! { get }
    var languageMemoryStorage: MDLanguageMemoryStorageProtocol! { get }
    // End Storage
    
    var appSettings: MDAppSettingsProtocol! { get }
    
    var bridge: MDBridgeProtocol! { get }
    
    var appLanguageService: MDAppLanguageServiceProtocol! { get }
    
}

final class MDAppDependencies: NSObject,
                               MDAppDependenciesProtocol {
    
    var rootWindow: UIWindow!
    var coreDataStack: MDCoreDataStack!
    
    // Manager
    var operationQueueManager: MDOperationQueueManagerProtocol!
    var coreDataManager: MDCoreDataManager!
    var courseManager: MDCourseManagerProtocol!
    var wordManager: MDWordManagerProtocol!
    //
    
    // Storage //
    var courseCoreDataStorage: MDCourseCoreDataStorageProtocol!
    var wordCoreDataStorage: MDWordCoreDataStorageProtocol!
    var languageMemoryStorage: MDLanguageMemoryStorageProtocol!
    // End Storage //
    
    var appSettings: MDAppSettingsProtocol!
    
    var bridge: MDBridgeProtocol!
    
    var appLanguageService: MDAppLanguageServiceProtocol!
    
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
        
        // Core Data Stack //
        let coreDataStack: MDCoreDataStack = .init()
        self.coreDataStack = coreDataStack
        // End Core Data Stack //
        //
        
        
        // Managers //
        // Operation Queue Manager //
        let operationQueues: [OperationQueue] = [MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.courseCoreDataStorageOperationQueue),
                                                 
                                                 
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.wordCoreDataStorageOperationQueue),
                                                 
                                                 
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.filterSearchTextServiceOperationQueue)
                                                 
        ]
        //
        let operationQueueManager: MDOperationQueueManagerProtocol = MDOperationQueueManager.init(operationQueues: operationQueues)
        self.operationQueueManager = operationQueueManager
        // End Operation Queue Manager //
        //
        
        
        // Core Data Manager //
        let coreDataMigrator: MDCoreDataMigratorProtocol = MDCoreDataMigrator.init()
        let coreDataManager: MDCoreDataManager = MDCoreDataManager.init(storeType: NSSQLiteStoreType,
                                                                        migrator: coreDataMigrator)
        coreDataManager.setup {
            debugPrint(#function, Self.self, "MDCoreDataManager configured successfully")
        }
        self.coreDataManager = coreDataManager
        // End Core Data Manager //
        //
        
        
        // Course Core Data Storage //
        let courseCoreDataStorage: MDCourseCoreDataStorageProtocol = MDCourseCoreDataStorage.init(operationQueue: operationQueueManager.operationQueue(byName: MDConstants.QueueName.courseCoreDataStorageOperationQueue)!,
                                                                                                  managedObjectContext: coreDataStack.privateContext,
                                                                                                  coreDataStack: coreDataStack)
        // Course Manager //
        let courseManager: MDCourseManagerProtocol = MDCourseManager.init(courseCoreDataStorage: courseCoreDataStorage)
        self.courseManager = courseManager
        // End Course Manager //
        //
        
        
        // Word Core Data Storage //
        let wordCoreDataStorage: MDWordCoreDataStorageProtocol = MDWordCoreDataStorage.init(operationQueue: operationQueueManager.operationQueue(byName: MDConstants.QueueName.wordCoreDataStorageOperationQueue)!,
                                                                                            managedObjectContext: coreDataStack.privateContext,
                                                                                            coreDataStack: coreDataStack)
        // Word Manager //
        let wordManager: MDWordManagerProtocol = MDWordManager.init(wordCoreDataStorage: wordCoreDataStorage)
        self.wordManager = wordManager
        // End Word Manager //
        //
        // End Managers //
        
        
        // Storage //
        // Course //
        self.courseCoreDataStorage = courseCoreDataStorage
        // End Course //
        
        // Word //
        self.wordCoreDataStorage = wordCoreDataStorage
        // End Word //
        
        // Language Storage
        let languageMemoryStorage: MDLanguageMemoryStorageProtocol = MDLanguageMemoryStorage.init(languages: MDLanguageMemoryStorage.readAllLanguagesFromJSON())
        
        self.languageMemoryStorage = languageMemoryStorage
        // End Language //
        // End Storage //
        
        
        // App Settings //
        let userDefaults: UserDefaults = .standard
        let appSettings: MDAppSettingsProtocol = MDAppSettings.init(userDefaults: userDefaults)
        self.appSettings = appSettings
        //
        // End App Settings //
        
        
        //
        // Bridge
        let bridge: MDBridgeProtocol = MDBridge.init()
        self.bridge = bridge
        //
        // End Bridge //
        
        
        //
        // App Language Service
        let appLanguageService: MDAppLanguageServiceProtocol = MDAppLanguageService.init(locale: .current,
                                                                                         defaultAppLanguage: .en)
        //
        self.appLanguageService = appLanguageService
        //
        // End App Language Service //
        
        
        // Configure FirebaseApp
        FirebaseApp.configure()
        
    }
    
}
