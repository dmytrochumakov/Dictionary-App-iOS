//
//  MDAppDependencies.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 07.07.2021.
//

import UIKit
import Firebase

protocol MDAppDependenciesProtocol {
    
    var rootWindow: UIWindow! { get set }
    var reachability: Reachability! { get }
    var coreDataStack: MDCoreDataStack! { get }
    
    // Manager
    var operationQueueManager: MDOperationQueueManagerProtocol! { get }
    //
    
    // Storage //
    var courseCoreDataStorage: MDCourseCoreDataStorageProtocol! { get }
    var wordCoreDataStorage: MDWordCoreDataStorageProtocol! { get }
    // End Storage
    
    var appSettings: MDAppSettingsProtocol! { get }
    
    var bridge: MDBridgeProtocol! { get }
    
    var appLanguageService: MDAppLanguageServiceProtocol! { get }
    
}

final class MDAppDependencies: NSObject,
                               MDAppDependenciesProtocol {
    
    var rootWindow: UIWindow!
    var reachability: Reachability!
    var coreDataStack: MDCoreDataStack!
    
    // Manager
    var operationQueueManager: MDOperationQueueManagerProtocol!
    //
    
    // Storage //
    var courseCoreDataStorage: MDCourseCoreDataStorageProtocol!
    var wordCoreDataStorage: MDWordCoreDataStorageProtocol!
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
        
        let reachability = Reachability.init()
        self.reachability = reachability
        //
        let coreDataStack: MDCoreDataStack = .init()
        self.coreDataStack = coreDataStack
        //
        
        
        // Managers //
        //
        let operationQueues: [OperationQueue] = [MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.courseCoreDataStorageOperationQueue),
                                                 
                                                 
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.wordCoreDataStorageOperationQueue),
                                                 
                                                 
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.filterSearchTextServiceOperationQueue)
                                                 
        ]
        //
        let operationQueueManager: MDOperationQueueManagerProtocol = MDOperationQueueManager.init(operationQueues: operationQueues)
        self.operationQueueManager = operationQueueManager
        //
        // End Managers //
        
        
        // Storage //
        // Course //
        let courseCoreDataStorage: MDCourseCoreDataStorageProtocol = MDCourseCoreDataStorage.init(operationQueue: operationQueueManager.operationQueue(byName: MDConstants.QueueName.courseCoreDataStorageOperationQueue)!,
                                                                                                  managedObjectContext: coreDataStack.privateContext,
                                                                                                  coreDataStack: coreDataStack)
        
        self.courseCoreDataStorage = courseCoreDataStorage
        // End Course //
        
        // Word //
        let wordCoreDataStorage: MDWordCoreDataStorageProtocol = MDWordCoreDataStorage.init(operationQueue: operationQueueManager.operationQueue(byName: MDConstants.QueueName.wordCoreDataStorageOperationQueue)!,
                                                                                            managedObjectContext: coreDataStack.privateContext,
                                                                                            coreDataStack: coreDataStack)
        
        self.wordCoreDataStorage = wordCoreDataStorage
        // End Word //
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
